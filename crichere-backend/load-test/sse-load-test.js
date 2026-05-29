/*
 * SSE load harness for the public projector stream.
 *
 * Usage:
 *   node sse-load-test.js <auctionId> [baseUrl] [clients] [durationMs]
 *
 * Example:
 *   node sse-load-test.js 11111111-1111-1111-1111-111111111111 \
 *        http://localhost:8080 500 60000
 *
 * Targets /api/v1/public/auctions/{auctionId}/events (no auth required while the
 * auction is LIVE). For the authenticated stream use TOKEN env var:
 *
 *   TOKEN=<jwt> node sse-load-test.js <auctionId> http://localhost:8080 500 60000 --auth
 */

const http = require('http');
const { URL } = require('url');

const auctionId = process.argv[2];
const baseUrl = process.argv[3] || 'http://localhost:8080';
const numClients = parseInt(process.argv[4] || '100', 10);
const durationMs = parseInt(process.argv[5] || '30000', 10);
const useAuth = process.argv.includes('--auth');

if (!auctionId) {
    console.error('Usage: node sse-load-test.js <auctionId> [baseUrl] [clients] [durationMs] [--auth]');
    process.exit(1);
}

const path = useAuth
    ? `/api/v1/auctions/${auctionId}/events`
    : `/api/v1/public/auctions/${auctionId}/events`;

const target = new URL(path, baseUrl);
console.log(`SSE load test: ${numClients} clients -> ${target.href} for ${durationMs}ms`);

let connected = 0;
let totalMessages = 0;
let snapshots = 0;
let bidEvents = 0;
let errors = 0;
const latencies = [];

const headers = useAuth && process.env.TOKEN
    ? { Authorization: `Bearer ${process.env.TOKEN}`, Accept: 'text/event-stream' }
    : { Accept: 'text/event-stream' };

function connectOne(i) {
    const start = Date.now();
    const req = http.get({
        hostname: target.hostname,
        port: target.port,
        path: target.pathname,
        headers,
        agent: false,
    }, (res) => {
        if (res.statusCode !== 200) {
            errors++;
            console.error(`Client ${i}: HTTP ${res.statusCode}`);
            res.resume();
            return;
        }
        connected++;
        latencies.push(Date.now() - start);
        res.setEncoding('utf8');
        let buf = '';
        res.on('data', (chunk) => {
            buf += chunk;
            let nl;
            while ((nl = buf.indexOf('\n\n')) !== -1) {
                const ev = buf.slice(0, nl);
                buf = buf.slice(nl + 2);
                totalMessages++;
                if (ev.includes('event: SNAPSHOT')) snapshots++;
                if (ev.includes('event: BID_PLACED')) bidEvents++;
            }
        });
        res.on('end', () => { connected--; });
    });
    req.on('error', (e) => { errors++; console.error(`Client ${i}: ${e.message}`); });
}

for (let i = 0; i < numClients; i++) connectOne(i);

const tick = setInterval(() => {
    console.log(`connected=${connected} msgs=${totalMessages} snapshots=${snapshots} bids=${bidEvents} errors=${errors}`);
}, 5000);

setTimeout(() => {
    clearInterval(tick);
    latencies.sort((a, b) => a - b);
    const p = (q) => latencies[Math.floor(latencies.length * q)] || 0;
    console.log('--- Final Report ---');
    console.log(`Target: ${target.href}`);
    console.log(`Clients attempted: ${numClients}`);
    console.log(`Peak connected: ${connected}`);
    console.log(`Total messages: ${totalMessages}`);
    console.log(`Snapshots received: ${snapshots}`);
    console.log(`Bid events received: ${bidEvents}`);
    console.log(`Errors: ${errors}`);
    if (latencies.length) {
        console.log(`Connect latency p50/p95/p99 ms: ${p(0.5)} / ${p(0.95)} / ${p(0.99)}`);
    }
    process.exit(0);
}, durationMs);
