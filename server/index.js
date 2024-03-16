const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
const Room = require("./models/room");
const app = express();
const port = process.env.PORT || 3000;

var server = http.createServer(app);

const io = require("socket.io")(server);

io.on("connection", (socket) => {
  console.log(`User connected: ${socket.id}`);
  socket.on("room", async ({ nickname }) => {
    try {
      //room is created
      let room = new Room();
      let player = {
        socketID: socket.id,
        nickname,
        playerType: "X",
      };
      room.players.push(player);
      room.turn = player;
      room = await room.save();
      const roomID = room._id.toString();
      socket.join(roomID);
      io.to(roomID).emit("createRoomSuccess", room);
    } catch (e) {
      console.log(e);
    }
  });

  socket.on("joinRoom", async ({ nickname, roomID }) => {
    try {
      if (!roomID.match(/^[0-9a-fA-F]{24}$/)) {
        socket.emit("errorOccured", "Please enter a valid room id.");
        return;
      }
      let room = await Room.findById(roomID);
      if (room.isJoin) {
        let player = {
          nickname,
          socketID: socket.id,
          playerType: "O",
        };
        socket.join(roomID);
        room.players.push(player);
        room.isJoin = false;
        room = await room.save();

        io.to(roomID).emit("joinRoomSuccess", room);
        io.to(roomID).emit("updatePlayers", room.players);
        io.to(roomID).emit("updateRoom", room);
      } else {
        socket.emit("errorOccured", "Game is in progress.Try again later.");
        return;
      }
    } catch (e) {
      console.log(e);
    }
  });

  socket.on("tap", async ({ index, roomID }) => {
    try {
      let room = await Room.findById(roomID);
      let choice = room.turn.playerType;
      if (room.turnIndex == 0) {
        room.turnIndex = 1;
        room.turn = room.players[1];
      } else {
        room.turnIndex = 0;
        room.turn = room.players[0];
      }
      room = await room.save();
      io.to(roomID).emit("tapped", {
        index,
        choice,
        room,
      });
    } catch (e) {
      console.log(e);
    }
  });

  socket.on("winner", async ({ winnerSocketId, roomId }) => {
    try {
      let room = await Room.findById(roomId);
      let player = room.players.find(
        (player) => player.socketID == winnerSocketId
      );
      player.points += 1;
        
      room = await room.save();
      if (player.points >= room.maxRounds) {
        io.to(roomId).emit("endGame", player);
      } else {
        io.to(roomId).emit("pointIncrease", player);
      }
    } catch (e) {
      console.log(e);
    }
  });
});

//middleware
app.use(express.json());

const DB =
  "mongodb+srv://tanjim437:Jerin4103@tictactoe.w3gw0uf.mongodb.net/?retryWrites=true&w=majority&appName=TicTacToe";

mongoose
  .connect(DB)
  .then(() => console.log("Connection successfull"))
  .catch((e) => console.log(e));

server.listen(port, () => {
  console.log(`Server has been started on port ${port}`);
});
