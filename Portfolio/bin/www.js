#!/usr/bin/env node

let app = require("../app");
let http = require("http");
let port = normalizePort(process.env.PORT || '3000');
app.set('port', port);
let server = http.createServer(app);
server.listen(port);
server.on('error', onError);
server.on('listening', onListening);

function normalizePort(val) {
    let port = parseInt(val, 10);

    if(isNaN(port)) {
        // named pipe
        return val;
    }

    if(port >= 0) {
        // port number
        return port;
    }

    return false;
}

function onError(error) {
    if(error.syscall !== 'listen') {
        throw error;
    }

    let bind = typeof port === 'string' ? 'Pipe ' + port : 'Port ' + port;

    switch(error.code) {
        case 'EACCES':
            console.error(bind + " requires elevated privileges");
            process.exit(1);
            break;
        case 'EADDRINUSE':
            console.error(bind + " is already in use");
            process.exit(1);
            break;
        default:
            throw error;
    }
}

function onListening() {
    let address = server.address();
    let bind = typeof address === 'string' ? 'pipe ' + address: 'port ' + address.port;

    for(let line of startUpMessage.split("\n")) {
        console.log(line);
    }

    console.log('Server listening on ' + bind + ' 🚀');
}

const startUpMessage = `Server initialized on port ` + port.toString();