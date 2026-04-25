import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ClaimProfileScreen extends StatelessWidget {
  const ClaimProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Claim Profile')),
      body: const Center(child: Text('Claim Profile Content')),
    );
  }
}
