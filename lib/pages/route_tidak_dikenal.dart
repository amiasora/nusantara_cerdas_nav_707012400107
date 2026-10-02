import 'package:flutter/material.dart';

class RouteTidakDikenal extends StatelessWidget {
  final String? namaRoute;

  const RouteTidakDikenal({
    super.key,
    this.namaRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Tidak Ditemukan'),
      ),
      body: Center(
        child: Text(
          'Route tidak dikenal:\n'
          '${namaRoute ?? 'Tidak tersedia'}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}