package com.crichere.domain.auction.service

import com.crichere.common.exception.ResourceNotFoundException
import com.crichere.domain.auction.dto.AuctionPlayerSummary
import com.crichere.domain.auction.repository.FranchisePlayerRepository
import com.crichere.domain.auction.repository.PlayerAuctionStateRepository
import com.crichere.domain.franchise.repository.FranchiseRepository
import com.crichere.domain.league.repository.AuctionRepository
import com.crichere.domain.league.repository.LeagueRepository
import com.crichere.domain.auth.repository.UserRepository
import com.crichere.domain.player.repository.LeaguePlayerRepository
import org.apache.pdfbox.pdmodel.PDDocument
import org.apache.pdfbox.pdmodel.PDPage
import org.apache.pdfbox.pdmodel.PDPageContentStream
import org.apache.pdfbox.pdmodel.font.PDType1Font
import org.apache.pdfbox.pdmodel.font.Standard14Fonts
import org.springframework.stereotype.Service
import java.awt.Color
import java.awt.Font
import java.awt.image.BufferedImage
import java.io.ByteArrayOutputStream
import java.util.*
import javax.imageio.ImageIO

@Service
class ExportService(
    private val auctionRepository: AuctionRepository,
    private val leagueRepository: LeagueRepository,
    private val playerStateRepository: PlayerAuctionStateRepository,
    private val franchiseRepository: FranchiseRepository,
    private val franchisePlayerRepository: FranchisePlayerRepository,
    private val leaguePlayerRepository: LeaguePlayerRepository,
    private val userRepository: UserRepository
) {

    fun exportAuctionSummaryPdf(auctionId: UUID): ByteArray {
        val auction = auctionRepository.findById(auctionId).orElseThrow { ResourceNotFoundException("Auction not found") }
        val league = leagueRepository.findById(auction.leagueId).get()
        val playerStates = playerStateRepository.findByAuctionId(auctionId)
        val franchises = franchiseRepository.findByLeagueId(league.id)

        PDDocument().use { document ->
            // Page 1: Summary
            val page1 = PDPage()
            document.addPage(page1)
            PDPageContentStream(document, page1).use { contentStream ->
                contentStream.beginText()
                contentStream.setFont(PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD), 24f)
                contentStream.newLineAtOffset(50f, 750f)
                contentStream.showText("Auction Summary: ${league.name}")
                contentStream.endText()

                contentStream.beginText()
                contentStream.setFont(PDType1Font(Standard14Fonts.FontName.HELVETICA), 14f)
                contentStream.newLineAtOffset(50f, 700f)
                contentStream.showText("Total Players: ${playerStates.size}")
                contentStream.newLineAtOffset(0f, -20f)
                contentStream.showText("Sold: ${playerStates.count { it.state.name == "SOLD" }}")
                contentStream.endText()
            }

            // One page per franchise
            franchises.forEach { franchise ->
                val fPage = PDPage()
                document.addPage(fPage)
                PDPageContentStream(document, fPage).use { contentStream ->
                    contentStream.beginText()
                    contentStream.setFont(PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD), 18f)
                    contentStream.newLineAtOffset(50f, 750f)
                    contentStream.showText("Franchise: ${franchise.name}")
                    contentStream.endText()
                    
                    // List players... (Simplified for now)
                }
            }

            val baos = ByteArrayOutputStream()
            document.save(baos)
            return baos.toByteArray()
        }
    }

    fun exportFranchiseSquadPdf(auctionId: UUID, franchiseId: UUID): ByteArray {
        val franchise = franchiseRepository.findById(franchiseId).orElseThrow { ResourceNotFoundException("Franchise not found") }
        val league = leagueRepository.findById(franchise.leagueId).get()
        val auction = auctionRepository.findById(auctionId).orElseThrow { ResourceNotFoundException("Auction not found") }
        if (auction.leagueId != league.id) throw ResourceNotFoundException("Franchise does not belong to this auction's league")

        val fPlayers = franchisePlayerRepository.findByFranchiseId(franchiseId)
        val totalSpent = fPlayers.sumOf { it.boughtPrice.toLong() }

        PDDocument().use { document ->
            val page = PDPage()
            document.addPage(page)
            PDPageContentStream(document, page).use { cs ->
                cs.beginText()
                cs.setFont(PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD), 22f)
                cs.newLineAtOffset(50f, 760f)
                cs.showText("${franchise.name} — ${league.name}")
                cs.endText()

                cs.beginText()
                cs.setFont(PDType1Font(Standard14Fonts.FontName.HELVETICA), 13f)
                cs.newLineAtOffset(50f, 730f)
                cs.showText("Squad size: ${fPlayers.size}    Spent: $totalSpent    Remaining: ${franchise.remainingPurse}")
                cs.endText()

                cs.beginText()
                cs.setFont(PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD), 12f)
                cs.newLineAtOffset(50f, 695f)
                cs.showText("Player")
                cs.newLineAtOffset(220f, 0f)
                cs.showText("Category")
                cs.newLineAtOffset(120f, 0f)
                cs.showText("Round")
                cs.newLineAtOffset(80f, 0f)
                cs.showText("Price")
                cs.endText()

                var y = 675f
                fPlayers.forEach { fp ->
                    val lp = leaguePlayerRepository.findById(fp.leaguePlayerId).get()
                    val user = userRepository.findById(lp.userId).get()
                    cs.beginText()
                    cs.setFont(PDType1Font(Standard14Fonts.FontName.HELVETICA), 11f)
                    cs.newLineAtOffset(50f, y)
                    cs.showText(user.name ?: "Unknown")
                    cs.newLineAtOffset(220f, 0f)
                    cs.showText(lp.category ?: "-")
                    cs.newLineAtOffset(120f, 0f)
                    cs.showText("-") // Round not tracked per FranchisePlayer in current schema
                    cs.newLineAtOffset(80f, 0f)
                    cs.showText(fp.boughtPrice.toString())
                    cs.endText()
                    y -= 18f
                    if (y < 50f) {
                        val newPage = PDPage()
                        document.addPage(newPage)
                        y = 760f
                    }
                }
            }

            val baos = ByteArrayOutputStream()
            document.save(baos)
            return baos.toByteArray()
        }
    }

    fun exportFranchiseSquadImage(auctionId: UUID, franchiseId: UUID): ByteArray {
        val franchise = franchiseRepository.findById(franchiseId).orElseThrow { ResourceNotFoundException("Franchise not found") }
        val league = leagueRepository.findById(franchise.leagueId).get()
        val fPlayers = franchisePlayerRepository.findByFranchiseId(franchiseId)

        val image = BufferedImage(1080, 1080, BufferedImage.TYPE_INT_RGB)
        val g = image.createGraphics()
        
        g.color = Color.WHITE
        g.fillRect(0, 0, 1080, 1080)
        
        g.color = Color.BLACK
        g.font = Font("Arial", Font.BOLD, 48)
        g.drawString(franchise.name, 80, 100)
        
        g.font = Font("Arial", Font.PLAIN, 32)
        g.drawString(league.name, 80, 150)
        
        var y = 250
        fPlayers.forEach { fp ->
            val lp = leaguePlayerRepository.findById(fp.leaguePlayerId).get()
            val user = userRepository.findById(lp.userId).get()
            g.drawString("${user.name} - ${fp.boughtPrice}", 100, y)
            y += 50
        }
        
        g.dispose()
        val baos = ByteArrayOutputStream()
        ImageIO.write(image, "PNG", baos)
        return baos.toByteArray()
    }
}
