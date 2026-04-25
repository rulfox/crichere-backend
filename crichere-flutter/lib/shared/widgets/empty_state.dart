import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyState extends StatelessWidget {
  final String message;
  final String? subMessage;

  const EmptyState({super.key, required this.message, this.subMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Using a placeholder Lottie URL or asset if available
          Lottie.network(
            'https://assets9.lottiefiles.com/packages/lf20_m6cuL6.json',
            height: 200,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.hourglass_empty, size: 80, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Text(message, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          if (subMessage != null) ...[
            const SizedBox(height: 8),
            Text(subMessage!, style: const TextStyle(color: Colors.grey)),
          ],
        ],
      ),
    );
  }
}
