import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:crichere_flutter/features/franchise/domain/entities/franchise_squad.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/material.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';

class ExportService {
  final ScreenshotController _screenshotController = ScreenshotController();

  Future<void> exportSquadToPdf(FranchiseSquadResponse squad) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(level: 0, child: pw.Text('Squad: ${squad.franchiseName}')),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                context: context,
                data: <List<String>>[
                  <String>['Player Name', 'Category', 'Assignment', 'Price'],
                  ...squad.players.map((p) => [
                        p.playerName,
                        p.playerCategory ?? '-',
                        p.assignmentType ?? 'AUCTIONED',
                        p.finalPrice != null ? '₹${p.finalPrice}' : '-',
                      ])
                ],
              ),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/squad_${squad.franchiseId}.pdf");
    await file.writeAsBytes(await pdf.save());

    await SharePlus.instance.share(ShareParams(
      files: [XFile(file.path)],
      text: 'Check out the ${squad.franchiseName} squad!',
    ));
  }

  Future<void> exportSquadToImage(FranchiseSquadResponse squad) async {
    final widget = SquadShareCard(squad: squad);

    final imageBytes = await _screenshotController.captureFromWidget(
      widget,
      delay: const Duration(milliseconds: 100),
      context: null,
      targetSize: const Size(1080, 1080),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/squad_${squad.franchiseId}.png");
    await file.writeAsBytes(imageBytes);

    await SharePlus.instance.share(ShareParams(
      files: [XFile(file.path)],
      text: 'Check out our squad for the upcoming league!',
    ));
  }
}

class SquadShareCard extends StatelessWidget {
  final FranchiseSquadResponse squad;
  const SquadShareCard({super.key, required this.squad});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1080,
      height: 1080,
      padding: const EdgeInsets.all(60),
      decoration: const BoxDecoration(
        color: CricColor.appBg,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [CricColor.navy, CricColor.appBg],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    squad.franchiseName.toUpperCase(),
                    style: CricTextStyle.displayLg.copyWith(fontSize: 64, color: CricColor.gold),
                  ),
                  Text(
                    'SQUAD 2026',
                    style: CricTextStyle.overline.copyWith(fontSize: 24, letterSpacing: 8),
                  ),
                ],
              ),
              const Icon(Icons.shield, color: CricColor.gold, size: 100),
            ],
          ),
          const SizedBox(height: 60),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4,
                crossAxisSpacing: 30,
                mainAxisSpacing: 20,
              ),
              itemCount: squad.players.length,
              itemBuilder: (context, index) {
                final p = squad.players[index];
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: CricColor.slate2.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: CricColor.gold.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${index + 1}',
                        style: CricTextStyle.mono.copyWith(color: CricColor.gold, fontSize: 18),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          p.playerName,
                          style: CricTextStyle.headingMd.copyWith(fontSize: 22),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (p.finalPrice != null)
                        Text(
                          '₹${p.finalPrice}',
                          style: CricTextStyle.badge.copyWith(color: CricColor.gold, fontSize: 16),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('crichere.com', style: CricTextStyle.mono.copyWith(color: CricColor.textDim, fontSize: 20)),
              Text('Total Players: ${squad.players.length}', style: CricTextStyle.caption.copyWith(fontSize: 20)),
            ],
          ),
        ],
      ),
    );
  }
}
