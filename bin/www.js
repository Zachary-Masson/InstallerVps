const ENV = require("dotenv").config().parsed;
const express = require("express");
const bodyParser = require("body-parser");
const fs = require("fs");
const app = express();

const server = require("http").Server(app);
const io = require("socket.io")(server);

const path = "./views/";

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const WWW = async () => {
  const routes = await fs.readdirSync("./routes");
  const eventSocket = await fs.readdirSync("./socket");

  app.use('/assets/', express.static('./public'))

  await routes.forEach((route) =>
    app.use(
      `/${route.split(".")[0] === "index" ? "/" : route.split(".")[0]}`,
      require(`../routes/${route}`)(path)
    )
  );

  io.on("connection", (socket) => {
    eventSocket.forEach((file) => {
      const Socket = require(`../socket/${file}`);
      socket[new Socket(socket).getType](file.split(".")[0], (Options) =>
        new Socket(socket, Options).exec()
      );
    });
  });

  await server.listen(ENV.PORT, () => {
    console.log(`Votre app est disponible sur localhost:${ENV.PORT} !`);
  });
};

module.exports = WWW;
