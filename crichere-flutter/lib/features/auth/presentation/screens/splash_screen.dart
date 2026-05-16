import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/router/app_router.gr.dart';

@RoutePage()
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authCheckProvider, (_, next) {
      next.whenData((_) {
        final authState = ref.read(authStateProvider);
        if (authState == AuthState.authenticated) {
          context.router.replaceAll([const HomeRoute()]);
        } else {
          context.router.replaceAll([const PhoneEntryRoute()]);
        }
      });
    });

    return Scaffold(
      backgroundColor: CricColor.appBg,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Cricket ball icon matching web splash
            SizedBox(
              width: 56,
              height: 56,
              child: CustomPaint(painter: _CricketBallPainter()),
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: CricColor.textPrimary,
                ),
                children: const [
                  TextSpan(text: 'Cric'),
                  TextSpan(text: 'here', style: TextStyle(color: CricColor.gold)),
                ],
              ),
            ),
            const SizedBox(height: 28),
            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: CricColor.gold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CricketBallPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Ball body
    canvas.drawCircle(center, radius, Paint()..color = const Color(0xFFDC2626));

    // Seam lines
    final seamPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path1 = Path()
      ..moveTo(size.width / 2, 2)
      ..cubicTo(size.width / 2 + 6, size.height * 0.3, size.width / 2 + 6, size.height * 0.7, size.width / 2, size.height - 2);
    canvas.drawPath(path1, seamPaint);

    final path2 = Path()
      ..moveTo(size.width / 2, 2)
      ..cubicTo(size.width / 2 - 6, size.height * 0.3, size.width / 2 - 6, size.height * 0.7, size.width / 2, size.height - 2);
    canvas.drawPath(path2, seamPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
