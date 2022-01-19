const os = require('os');
var spawn = require("child_process").spawn;
class Data {
    constructor() {

    }

    getCpuUsage(callback) {
        //Create function to get CPU information
        function cpuAverage() {

            //Initialise sum of idle and time of cores and fetch CPU info
            var totalIdle = 0, totalTick = 0;
            var cpus = os.cpus();

            //Loop through CPU cores
            for (var i = 0, len = cpus.length; i < len; i++) {

                //Select CPU core
                var cpu = cpus[i];

                let type;
                //Total up the time in the cores tick
                for (type in cpu.times) {
                    totalTick += cpu.times[type];
                }

                //Total up the idle time of the core
                totalIdle += cpu.times.idle;
            }

            //Return the average Idle and Tick times
            return { idle: totalIdle / cpus.length, total: totalTick / cpus.length };
        }

        //Grab first CPU Measure
        var startMeasure = cpuAverage();

        //Set delay for second Measure
        setTimeout(function () {

            //Grab second Measure
            var endMeasure = cpuAverage();

            //Calculate the difference in idle and total time between the measures
            var idleDifference = endMeasure.idle - startMeasure.idle;
            var totalDifference = endMeasure.total - startMeasure.total;

            //Calculate the average percentage CPU usage
            var percentageCPU = 100 - ~~(100 * idleDifference / totalDifference);

            //Output result to console
            callback(percentageCPU);

        }, 100);
    }

    getMemoryUsage(callback) {

        var prc = spawn("free", []);

        prc.stdout.setEncoding("utf8");
        prc.stdout.on("data", function (data) {
            var lines = data.toString().split(/\n/g),
                line = lines[1].split(/\s+/),
                total = parseInt(line[1], 10),
                used = parseInt(line[2], 10)
            callback((100 * used / total).toFixed(1))
        });

        prc.on("error", function (error) {
            console.log("[ERROR] Free memory process", error);
        });
    }
}

module.exports = Data