package com.crichere.domain.auction.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.domain.auction.dto.AuctionStateSnapshot
import com.crichere.domain.auction.service.AuctionService
import com.crichere.domain.auction.sse.SseBroadcaster
import com.crichere.domain.league.enums.AuctionStatus
import com.crichere.common.exception.BusinessLogicException
import com.fasterxml.jackson.databind.ObjectMapper
import org.springframework.http.HttpHeaders
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter
import org.springframework.web.util.HtmlUtils
import java.util.*

/**
 * Controller for public, no-auth auction views.
 * Provides a projector-friendly HTML page and mirrored LIVE-only state/event endpoints.
 */
@RestController
@RequestMapping("/public/auctions")
class DisplayController(
    private val auctionService: AuctionService,
    private val sseBroadcaster: SseBroadcaster,
    private val objectMapper: ObjectMapper
) {

    /**
     * Serves a self-contained HTML page for big-screen projector displays.
     * Connects to SSE events for real-time updates.
     */
    @GetMapping("/{id}/display", produces = [MediaType.TEXT_HTML_VALUE])
    fun getDisplayPage(@PathVariable id: UUID): ResponseEntity<String> {
        val auction = auctionService.getAuction(id)
        val html = buildDisplayPageHtml(id, auction.leagueId)
        return ResponseEntity.ok()
            .contentType(MediaType.TEXT_HTML)
            .body(html)
    }

    /**
     * Public access to auction state. Only allowed if the auction is LIVE.
     */
    @GetMapping("/{id}/state")
    fun getPublicAuctionState(@PathVariable id: UUID): ApiResponse<AuctionStateSnapshot> {
        val snapshot = auctionService.getStateSnapshot(id)
        if (snapshot.auctionStatus != AuctionStatus.LIVE) {
            throw BusinessLogicException("Public access allowed only when auction is LIVE", "error.auction_not_live")
        }
        return ResponseHelper.success(data = snapshot)
    }

    /**
     * Public access to SSE event stream by auction id. LIVE-only.
     * Used by the embedded projector display page; consumers must already know the
     * 128-bit auction UUID (equivalent in entropy to the public view token).
     */
    @GetMapping("/{id}/events", produces = [MediaType.TEXT_EVENT_STREAM_VALUE])
    fun streamPublicEvents(
        @PathVariable id: UUID,
        @RequestHeader(name = "Last-Event-ID", required = false) headerLastId: Long?,
        @RequestParam(name = "lastEventId", required = false) queryLastId: Long?
    ): ResponseEntity<SseEmitter> {
        return buildPublicStream(id, headerLastId ?: queryLastId)
    }

    /**
     * Internal helper: build a public SSE stream for a LIVE auction with proper
     * snapshot-first ordering and reconnect support.
     */
    private fun buildPublicStream(
        auctionId: UUID,
        lastEventId: Long?
    ): ResponseEntity<SseEmitter> {
        val auction = auctionService.getAuction(auctionId)
        if (auction.status != AuctionStatus.LIVE) {
            throw BusinessLogicException("Public access allowed only when auction is LIVE", "error.auction_not_live")
        }

        val emitter = SseEmitter(0L)
        emitter.send(SseEmitter.event().reconnectTime(3000L).comment("connected"))

        val snapshot = auctionService.getStateSnapshot(auctionId)
        val baseSeq = snapshot.lastSequenceNumber
        val snapshotEvent = mapOf("event" to "SNAPSHOT", "data" to snapshot)
        emitter.send(
            SseEmitter.event()
                .id(baseSeq.toString())
                .name("SNAPSHOT")
                .data(objectMapper.writeValueAsString(snapshotEvent))
        )

        val replayFrom = lastEventId ?: baseSeq
        auctionService.getAuditLogs(auctionId, replayFrom).forEach { log ->
            val payload = mapOf("id" to log.sequenceNumber, "event" to log.action.name, "data" to log.payload)
            emitter.send(
                SseEmitter.event()
                    .id(log.sequenceNumber.toString())
                    .name(log.action.name)
                    .data(objectMapper.writeValueAsString(payload))
            )
        }

        sseBroadcaster.addEmitter(auctionId, emitter)

        return ResponseEntity.ok()
            .header(HttpHeaders.CACHE_CONTROL, "no-cache, no-transform")
            .header("X-Accel-Buffering", "no")
            .header(HttpHeaders.CONNECTION, "keep-alive")
            .body(emitter)
    }

    /**
     * Token-based access to the auction viewer. Used for shareable public links.
     */
    @GetMapping("/view/{token}")
    fun getPublicAuctionView(@PathVariable token: String): ApiResponse<AuctionStateSnapshot> {
        val auction = auctionService.getAuctionByToken(token)
        if (auction.status != AuctionStatus.LIVE) {
            throw BusinessLogicException("Auction is not LIVE", "error.auction_not_live")
        }
        return ResponseHelper.success(data = auctionService.getStateSnapshot(auction.id))
    }

    /**
     * Token-based access to SSE events for public viewer clients.
     */
    @GetMapping("/view/{token}/events", produces = [MediaType.TEXT_EVENT_STREAM_VALUE])
    fun streamPublicViewEvents(
        @PathVariable token: String,
        @RequestHeader(name = "Last-Event-ID", required = false) headerLastId: Long?,
        @RequestParam(name = "lastEventId", required = false) queryLastId: Long?
    ): ResponseEntity<SseEmitter> {
        val auction = auctionService.getAuctionByToken(token)
        return buildPublicStream(auction.id, headerLastId ?: queryLastId)
    }

    /**
     * Token-based status check — used by clients to distinguish "expired" vs "not yet live"
     * without exposing the full snapshot.
     */
    @GetMapping("/view/{token}/status")
    fun getViewStatus(@PathVariable token: String): ApiResponse<Map<String, Any?>> {
        val auction = auctionService.getAuctionByToken(token)
        return ResponseHelper.success(data = mapOf(
            "auctionId" to auction.id,
            "leagueId" to auction.leagueId,
            "status" to auction.status,
            "startedAt" to auction.startedAt,
            "completedAt" to auction.completedAt
        ))
    }

    /**
     * Generates a self-contained HTML display page with embedded CSS and JavaScript.
     */
    private fun buildDisplayPageHtml(auctionId: UUID, leagueId: UUID): String {
        val safeAuctionId = HtmlUtils.htmlEscape(auctionId.toString())
        return """
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Crichere Auction Display</title>
                <style>
                    body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #1a1a1a; color: white; margin: 0; padding: 0; overflow: hidden; }
                    .container { display: flex; flex-direction: column; height: 100vh; }
                    .top-bar { display: flex; justify-content: space-between; padding: 10px 20px; background-color: #333; font-size: 1.2em; border-bottom: 2px solid #555; }
                    .main-content { display: flex; flex: 1; overflow: hidden; }
                    .player-section { flex: 2; display: flex; flex-direction: column; align-items: center; justify-content: center; padding: 20px; border-right: 1px solid #444; }
                    .franchise-section { flex: 1; padding: 20px; background-color: #252525; overflow-y: auto; }
                    .player-card { background-color: #333; border-radius: 15px; padding: 30px; text-align: center; width: 80%; box-shadow: 0 10px 30px rgba(0,0,0,0.5); }
                    .player-name { font-size: 3.5em; margin: 10px 0; color: #ffcc00; }
                    .player-role { font-size: 1.5em; color: #aaa; margin-bottom: 20px; }
                    .current-bid { font-size: 5em; margin: 20px 0; color: #00ff00; }
                    .leading-franchise { font-size: 2em; color: #fff; }
                    .bid-log { flex: 0.3; background-color: #111; padding: 10px; border-top: 1px solid #444; max-height: 150px; overflow-y: hidden; }
                    .bid-item { padding: 5px 15px; border-bottom: 1px solid #222; font-size: 0.9em; }
                    .purse-bar-container { margin-bottom: 15px; }
                    .purse-bar-bg { background-color: #444; height: 10px; border-radius: 5px; margin-top: 5px; }
                    .purse-bar-fill { background-color: #ffcc00; height: 100%; border-radius: 5px; }
                    .timer { font-size: 2.5em; color: #ff4444; margin-top: 20px; }
                    .overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.85); display: none; align-items: center; justify-content: center; z-index: 1000; }
                    .overlay-content { font-size: 5em; text-align: center; color: #00ff00; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="top-bar">
                        <div id="league-name">Loading...</div>
                        <div id="round-name"></div>
                        <div style="color: #00ff00;">● LIVE</div>
                    </div>
                    <div class="main-content">
                        <div class="player-section">
                            <div class="player-card">
                                <div id="player-role" class="player-role"></div>
                                <div id="player-name" class="player-name">Waiting for Player...</div>
                                <div id="current-bid" class="current-bid">₹0</div>
                                <div id="leading-franchise" class="leading-franchise">No Bids Yet</div>
                                <div id="timer" class="timer"></div>
                            </div>
                        </div>
                        <div id="franchise-list" class="franchise-section">
                        </div>
                    </div>
                    <div id="bid-log" class="bid-log">
                    </div>
                </div>
                <div id="overlay" class="overlay"><div class="overlay-content" id="overlay-text"></div></div>

                <script>
                    const auctionId = '$safeAuctionId';
                    let currentSnapshot = null;

                    async function fetchState() {
                        try {
                            const res = await fetch(`/api/v1/public/auctions/${auctionId}/state`);
                            const json = await res.json();
                            if (json.success) {
                                currentSnapshot = json.data;
                                updateUI();
                            }
                        } catch (e) { console.error('Fetch failed', e); }
                    }

                    function updateUI() {
                        if (!currentSnapshot) return;
                        document.getElementById('league-name').innerText = currentSnapshot.leagueName || 'Crichere Auction';
                        if (currentSnapshot.currentRound) {
                            document.getElementById('round-name').innerText = currentSnapshot.currentRound.name || 'Round ' + currentSnapshot.currentRound.roundNumber;
                        }
                        
                        const player = currentSnapshot.currentPlayer;
                        if (player) {
                            document.getElementById('player-name').innerText = player.playerName || 'Unknown Player';
                            document.getElementById('player-role').innerText = player.playerCategory || '';
                            document.getElementById('current-bid').innerText = '₹' + (currentSnapshot.currentHighestBid || 0).toLocaleString();
                            document.getElementById('leading-franchise').innerText = getFranchiseName(currentSnapshot.currentHighestBidderId) || 'No Bids Yet';
                        }

                        const franchiseList = document.getElementById('franchise-list');
                        franchiseList.innerHTML = '<h3>Franchise Purses</h3>';
                        currentSnapshot.franchisePurseStates.sort((a, b) => b.currentAmount - a.currentAmount).forEach(f => {
                            const pct = (f.currentAmount / (f.startingAmount || 1)) * 100;
                            franchiseList.innerHTML += `
                                <div class="purse-bar-container">
                                    <div style="display:flex; justify-content:space-between">
                                        <span>\${'$'}{getFranchiseName(f.franchiseId)}</span>
                                        <span>₹\${'$'}{f.currentAmount.toLocaleString()}</span>
                                    </div>
                                    <div class="purse-bar-bg">
                                        <div class="purse-bar-fill" style="width: \${'$'}{pct}%"></div>
                                    </div>
                                </div>
                            `;
                        });
                        
                        updateTimer();
                    }

                    function getFranchiseName(id) {
                        // This would be better if snapshot had franchise names
                        return 'Franchise ' + (id ? id.substring(0, 4) : '');
                    }

                    function updateTimer() {
                        if (!currentSnapshot || !currentSnapshot.timer || !currentSnapshot.timer.isRunning) {
                            document.getElementById('timer').innerText = '';
                            return;
                        }
                        const timer = currentSnapshot.timer;
                        const elapsed = Math.floor((Date.now() - new Date(timer.startedAt).getTime()) / 1000);
                        const remaining = Math.max(0, timer.durationSeconds - elapsed);
                        document.getElementById('timer').innerText = remaining + 's';
                    }

                    setInterval(updateTimer, 1000);

                    const evtSource = new EventSource(\`/api/v1/public/auctions/\${auctionId}/events\`);
                    evtSource.onmessage = (e) => {
                        const event = JSON.parse(e.data);
                        if (event.event === 'SNAPSHOT') {
                            currentSnapshot = event.data;
                            updateUI();
                        } else {
                            handleEvent(event);
                        }
                    };

                    function handleEvent(event) {
                        console.log('Event:', event);
                        const data = event.data;
                        const log = document.getElementById('bid-log');
                        
                        if (event.event === 'BID_PLACED') {
                            document.getElementById('current-bid').innerText = '₹' + data.bidAmount.toLocaleString();
                            document.getElementById('leading-franchise').innerText = getFranchiseName(data.franchiseId);
                            log.innerHTML = \`<div class="bid-item">\${'$'}{getFranchiseName(data.franchiseId)} bid ₹\${'$'}{data.bidAmount.toLocaleString()}</div>\` + log.innerHTML;
                        } else if (event.event === 'PLAYER_UP') {
                            document.getElementById('player-name').innerText = data.playerName;
                            document.getElementById('player-role').innerText = data.playerCategory || '';
                            document.getElementById('current-bid').innerText = '₹' + data.basePrice.toLocaleString();
                            document.getElementById('leading-franchise').innerText = 'No Bids Yet';
                            log.innerHTML = '';
                        } else if (event.event === 'PLAYER_SOLD') {
                            showOverlay('SOLD to ' + getFranchiseName(data.franchiseId) + ' for ₹' + data.finalPrice.toLocaleString(), '#00ff00', 4000);
                            fetchState();
                        } else if (event.event === 'PLAYER_UNSOLD') {
                            showOverlay('UNSOLD', '#ff4444', 3000);
                            fetchState();
                        } else if (event.event === 'TIMER_STARTED' || event.event === 'TIMER_RESET') {
                            currentSnapshot.timer = {
                                isRunning: true,
                                startedAt: data.startedAt,
                                durationSeconds: data.durationSeconds
                            };
                        } else if (event.event === 'TIMER_STOPPED') {
                            if (currentSnapshot.timer) currentSnapshot.timer.isRunning = false;
                        }
                    }

                    function showOverlay(text, color, duration) {
                        const overlay = document.getElementById('overlay');
                        const content = document.getElementById('overlay-text');
                        content.innerText = text;
                        content.style.color = color;
                        overlay.style.display = 'flex';
                        setTimeout(() => { overlay.style.display = 'none'; }, duration);
                    }

                    fetchState();
                </script>
            </body>
            </html>
        """.trimIndent()
    }
}
