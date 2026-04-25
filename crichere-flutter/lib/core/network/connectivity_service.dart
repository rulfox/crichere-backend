import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_service.g.dart';

@riverpod
Stream<ConnectivityResult> connectivity(Ref ref) {
  return Connectivity().onConnectivityChanged.map((results) => results.first);
}

class ConnectivityWatcher {
  static void watch(WidgetRef ref, BuildContext context) {
    ref.listen(connectivityProvider, (previous, next) {
      if (next.value == ConnectivityResult.none) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No Internet Connection'),
            backgroundColor: Colors.red,
            duration: Duration(days: 1),
          ),
        );
      } else if (previous?.value == ConnectivityResult.none) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Back Online'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }
}
