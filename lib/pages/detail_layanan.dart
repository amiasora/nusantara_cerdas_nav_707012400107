import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';

class DetailLayanan extends StatefulWidget {
  final Map<String, String> data;

  const DetailLayanan({
    super.key,
    required this.data,
  });

  @override
  State<DetailLayanan> createState() => _DetailLayananState();
}

class _DetailLayananState extends State<DetailLayanan> {
  bool sedangMengirim = false;

  Future<void> ajukanPermohonan() async {
    // Mencegah pemanggilan berulang selama proses berlangsung.
    if (sedangMengirim) {
      return;
    }

    final namaLayanan = widget.data['nama'] ?? 'Layanan';

    setState(() {
      sedangMengirim = true;
    });

    // Menyimulasikan proses pengiriman selama dua detik.
    await Future<void>.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) {
      return;
    }

    // Membatalkan proses jika pengguna telah meninggalkan halaman.
    if (ModalRoute.of(context)?.isCurrent != true) {
      setState(() {
        sedangMengirim = false;
      });
      return;
    }

    final pengajuanCubit = context.read<PengajuanCubit>();
    final sudahAda =
        pengajuanCubit.daftarPengajuan.contains(namaLayanan);

    pengajuanCubit.tambahPengajuan(namaLayanan);

    setState(() {
      sedangMengirim = false;
    });

    final hasil = sudahAda
        ? '$namaLayanan sudah ada dalam keranjang pengajuan.'
        : 'Permohonan $namaLayanan telah ditambahkan '
            'ke keranjang pengajuan.';

    Navigator.pop(context, hasil);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Layanan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            widget.data['nama'] ?? 'Nama layanan',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.account_balance),
            title: const Text('Dinas Penanggung Jawab'),
            subtitle: Text(
              widget.data['dinas'] ?? '-',
            ),
          ),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text('Jam Operasional'),
            subtitle: Text(
              widget.data['jam'] ?? '-',
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Keterangan'),
            subtitle: Text(
              widget.data['keterangan'] ?? '-',
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: sedangMengirim
                ? null
                : ajukanPermohonan,
            icon: sedangMengirim
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.send),
            label: Text(
              sedangMengirim
                  ? 'Mengirim...'
                  : 'Ajukan Permohonan',
            ),
          ),
        ],
      ),
    );
  }
}