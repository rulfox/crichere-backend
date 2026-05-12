import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:crichere_flutter/features/franchise/domain/entities/franchise_squad.dart';
import 'package:share_plus/share_plus.dart';

class ExportService {
  Future<void> exportSquadToPdf(FranchiseSquad squad) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(level: 0, child: pw.Text('Squad: ${squad.franchiseName}')),
              pw.Text('Purse Remaining: INR ${squad.purseRemaining}'),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                context: context,
                data: <List<String>>[
                  <String>['Player Name', 'Role', 'Assignment', 'Price'],
                  ...squad.players.map((p) => [
                        p.name,
                        p.role,
                        p.assignmentType,
                        'INR ${p.price}',
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

  Future<void> exportSquadToImage(FranchiseSquad squad) async {
    // SC-005: 1080x1080 PNG for WhatsApp sharing
    // TODO: Implement using screenshot package and a custom widget
  }
}
