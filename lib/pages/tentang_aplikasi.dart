import 'package:flutter/material.dart';

class TentangAplikasi extends StatelessWidget {
  const TentangAplikasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
      ),
      body: const Center(
        child: Text(
          'Nusantara Cerdas Mobile\nVersi 1.0',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}