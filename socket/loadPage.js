const os = require("os");

class loadPage {
  constructor(socket, options) {
    this.type = "on";
    this.Socket = socket;
    this.Options = options;
  }

  get getType() {
    return this.type;
  }

  exec() {
    this.Socket.emit("pageIsLoaded", {
      hostname: os.hostname(),
      network: os.networkInterfaces(),
      userInfo: os.userInfo(),
      cpu: os.cpus(),
      constants: os.constants,
    });
  }
}

module.exports = loadPage;
