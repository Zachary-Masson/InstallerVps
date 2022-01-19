const Data = require('../models/Data')

class getData {
    constructor(socket, options) {
        this.type = "on";
        this.Socket = socket;
        this.Options = options;
    }

    get getType() {
        return this.type;
    }

    exec() {
        new Data().getCpuUsage(cpu => {
            new Data().getMemoryUsage(memory => {
                this.Socket.emit("emitData", {
                    cpu,
                    memory
                });
            })
        })
    }
}

module.exports = getData;
