import 'package:flutter/material.dart';

class RiwayatLaporan extends StatelessWidget {
  const RiwayatLaporan({super.key});

  void tampilkanPesan(
    BuildContext context,
    String pesan,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(pesan),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void tampilkanTambahLaporan(
    BuildContext context,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Laporan'),
          content: const Text(
            'Fitur penambahan laporan warga '
            'tersedia pada purwarupa.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Laporan'),
      ),

      body: const Center(
        child: Text(
          'Belum ada riwayat laporan.',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: 'Tambah laporan',
        onPressed: () {
          tampilkanTambahLaporan(context);
        },
        child: const Icon(Icons.add),
      ),

      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              tooltip: 'Beranda',
              onPressed: () {
                tampilkanPesan(
                  context,
                  'Aksi Beranda dipilih.',
                );
              },
              icon: const Icon(
                Icons.home_outlined,
              ),
            ),

            IconButton(
              tooltip: 'Notifikasi',
              onPressed: () {
                tampilkanPesan(
                  context,
                  'Belum ada notifikasi baru.',
                );
              },
              icon: const Icon(
                Icons.notifications_none,
              ),
            ),

            IconButton(
              tooltip: 'Pengaturan',
              onPressed: () {
                tampilkanPesan(
                  context,
                  'Menu pengaturan laporan dipilih.',
                );
              },
              icon: const Icon(
                Icons.settings_outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }
}