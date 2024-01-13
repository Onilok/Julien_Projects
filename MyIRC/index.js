var express = require("express");
var http = require("http");
var bodyParser = require("body-parser");
var app = express();
var httpServer = http.createServer(app);
var jsonParser = bodyParser.json();
var urlencodedparser = bodyParser.urlencoded({ extended: true });
app.use(jsonParser);
app.use(urlencodedparser);
app.get("/", function (request, response) {
    console.log("bleu");
    response.send("salut");
});
app.get("/login", function (request, response) {
    response.sendFile(__dirname + "/login.html");
});
app.post("/login"),
    function (request, response) {
        var username = request.body.username;
        var password = request.body.password;
        console.log(username, password);
    };
app.get("/chat", function (request, response) {
    console.log("chat route");
    response.send("Chat");
});
httpServer.listen(8080, function () { return console.log("hello world"); });
