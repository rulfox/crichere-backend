const http = require('http');

const targetUrl = process.argv[2] || 'http://localhost:8080/api/v1/auctions/sse';
const numClients = parseInt(process.argv[3]) || 100;
const durationMs = parseInt(process.argv[4]) || 30000;

console.log(`Starting SSE load test: ${numClients} clients targeting ${targetUrl} for ${durationMs}ms`);

let activeClients = 0;
let totalMessages = 0;
let errors = 0;

for (let i = 0; i < numClients; i++) {
    const req = http.get(targetUrl, (res) => {
        activeClients++;
        res.on('data', (chunk) => {
            const lines = chunk.toString().split('\n');
            lines.forEach(line => {
                if (line.startsWith('data:')) {
                    totalMessages++;
                }
            });
        });
        res.on('end', () => {
            activeClients--;
        });
    });

    req.on('error', (e) => {
        errors++;
        console.error(`Client ${i} error: ${e.message}`);
    });
}

const reportInterval = setInterval(() => {
    console.log(`Active: ${activeClients}, Messages: ${totalMessages}, Errors: ${errors}`);
}, 5000);

setTimeout(() => {
    clearInterval(reportInterval);
    console.log('--- Final Report ---');
    console.log(`Target: ${targetUrl}`);
    console.log(`Clients: ${numClients}`);
    console.log(`Total Messages Received: ${totalMessages}`);
    console.log(`Total Errors: ${errors}`);
    process.exit(0);
}, durationMs);
