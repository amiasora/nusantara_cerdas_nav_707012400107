import 'package:flutter/material.dart';

class PengaturanKota extends StatelessWidget {
  const PengaturanKota({super.key});

  void ujiRouteTidakDikenal(BuildContext context) {
    Navigator.pushNamed(
      context,
      '/route-salah',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Kota'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const ListTile(
            leading: Icon(Icons.location_city_outlined),
            title: Text('Wilayah'),
            subtitle: Text('Kota Nusantara'),
          ),

          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.warning_amber_outlined,
            ),
            title: const Text(
              'Uji Route Tidak Dikenal',
            ),
            subtitle: const Text(
              'Menguji penanganan route yang tidak terdaftar.',
            ),
            trailing: const Icon(
              Icons.chevron_right,
            ),
            onTap: () {
              ujiRouteTidakDikenal(context);
            },
          ),
        ],
      ),
    );
  }
}