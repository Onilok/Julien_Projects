import express, { Response, Request, response } from "express";
import http, { get, IncomingMessage, createServer } from "http";
import bodyParser from "body-parser";
import {
  db,
  query_channels,
  query_message,
  query_select_user,
  query_users,
} from "./db";
import { RowDataPacket } from "mysql2";
import expressSession, { SessionData } from "express-session";
import { Server, Socket } from "socket.io";
import { connect } from "http2";
import * as path from "path";

declare module "express-session" {
  interface SessionData {
    user?: { id: number; username: string };
  }
}
interface SessionIncommingMessage extends IncomingMessage {
  session: SessionData;
}

interface SessionSocket extends Socket {
  request: SessionIncommingMessage;
}

export let name_channel = "channel 1";

export let username: string,
  password: string,
  channel_id: number,
  user_id: number,
  content: string;

const wrapper = (middleware: any) => (socket: Socket, next: any) =>
  middleware(socket.request, {}, next);

const app = express();
const httpServer = http.createServer(app);
const session = expressSession({
  secret: "verysecret",
  resave: false,
  saveUninitialized: true,
  cookie: {},
});
const io = new Server(httpServer);

const jsonParser = bodyParser.json();
const urlencodedparser = bodyParser.urlencoded({ extended: true });

app.use(jsonParser);
app.use(urlencodedparser);
app.use(session);
app.use(express.static(path.join(__dirname, "/")));

io.use(wrapper(session));
app.get("/", (request: Request, response: Response) => {
  if (request.session.user) {
    response.send({ title: `hello  ${request.session.user.username}` });
  } else {
    response.send("You are not logged in yet");
  }
});
app.get("/chat", (request: Request, response: Response) => {
  if (request.session.user) {
    response.sendFile(__dirname + "/chat.html");
  } else {
    response.redirect("/login");
  }
});

app.get("/login", (request: Request, response: Response) => {
  response.sendFile(__dirname + "/login.html");
});
app.get("/inscription", (request: Request, response: Response) => {
  response.sendFile(__dirname + "/inscription.html");
});

app.post("/login", (request: Request, response: Response) => {
  const username = request.body.username;
  const password = request.body.password;

  if (username && password) {
    db.connect(function (err) {
      if (err) throw err;
      console.log("Connected!");
    });
    db.execute(query_channels);
    db.execute(query_users);
    db.execute(query_message);
    const queryy = `SELECT * FROM users WHERE username = ?;`;

    db.query(queryy, username, (error, result: any) => {
      const data = <RowDataPacket>result;
      //if (results[0].password !== password || results == null)
      if (data.length === 0) {
        console.log("user not found");
        response.redirect("/login");
        response.send(console.log("user not found try again"));
      } else {
        const Current_user = data[0].username;
        console.log("userfound ");
        console.log(Current_user);
        user_id = data[0].user_id;

        request.session.user = {
          id: data[0].user_id,
          username: data[0].username,
        };

        response.redirect("/chat");
        console.log("bravo vous etes connecté");
      }
    });

    //console.log(username, password);
    //db.execute(query_insert_users);
  } else {
    console.log("username or password missing");
    response.send("username or password is missing");
  }

  // Plus de logique pour gérer la connexion
});

app.get("/chat", (request, response) => {
  console.log("chat route");
  response.send("bravo vous etes connecter au chat");
});
/*
io.on("connection", (socket) => {
  console.log(user_id, "c'est vrai");
  let query_insert_channels = `INSERT INTO channels(name) VALUES('${name_channel}');`;
  console.log("user co");
  socket.on("chat message", (mssg) => {
    console.log("message :" + mssg);
    content = mssg;
    console.log(content);
    console.log(user_id);
    db.connect(function (err) {
      if (err) throw err;
      console.log("Connected!");
    });
    let query_insert_messages = `INSERT INTO messages (user_id, content) VALUES (${user_id}, '${content}');`;

    console.log(query_insert_messages);
    db.execute(query_insert_messages);
  });
  socket.on("disconnect", () => {
    console.log("user disconnected");
  });
});
*/
io.on("connection", (defaultSocket: Socket) => {
  const socket = <SessionSocket>defaultSocket;
  const userSession = socket.request.session.user;

  socket.on("chat message", (msg: any) => {
    content = msg;
    let query_insert_messages = `INSERT INTO messages (user_id, content) VALUES (${user_id}, '${content}');`;
    db.execute(query_insert_messages);

    console.log(userSession?.username + " : " + msg);
    io.emit("chat message", userSession?.username + " : " + msg);
  });
});

app.get("/inscription", (request, response) => {
  console.log("route inscription");
  response.send("Inscrit toi le reuf");
});

app.post("/inscription", (request: Request, response: Response) => {
  let username = request.body.username;
  let password = request.body.password;
  if (username && password) {
    db.connect(function (err) {
      if (err) throw err;
      console.log("Connected!");
    });
    db.execute(query_channels);
    db.execute(query_users);
    db.execute(query_message);

    let query_insert_users = `INSERT INTO users(username,password) VALUES('${username}','${password}')`;
    db.execute(query_insert_users);
    console.log("insertion ok");
    //response.send().status(200);
    response.redirect("/login");
  }
});
httpServer.listen(3000, () => console.log("listening on port 3000"));
