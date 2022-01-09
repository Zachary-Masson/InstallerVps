const indexRoute = (path) => {
  const route = require("express").Router();

  route.get("/", (req, res) => res.sendFile("index.html", { root: path }));

  return route;
};

module.exports = indexRoute;
