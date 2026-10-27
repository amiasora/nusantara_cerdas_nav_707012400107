import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import '../cubit/theme_cubit.dart';
import '../navigation/app_routes.dart';
import 'layanan.dart';

class Warga extends StatelessWidget {
  const Warga({super.key});

  Future<void> bukaDetailFavorit(
    BuildContext context,
    String namaLayanan,
  ) async {
    final item = Layanan.data.values
        .expand((daftar) => daftar)
        .firstWhere(
          (layanan) => layanan['nama'] == namaLayanan,
          orElse: () => <String, String>{},
        );

    if (item.isEmpty) {
      return;
    }

    final hasil = await Navigator.pushNamed(
      context,
      AppRoutes.detailLayanan,
      arguments: item,
    );

    if (!context.mounted || hasil == null) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(hasil.toString()),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void kirimSemuaPengajuan(BuildContext context) {
    final pengajuanCubit = context.read<PengajuanCubit>();
    final jumlah = pengajuanCubit.totalPengajuan;

    if (jumlah == 0) {
      return;
    }

    pengajuanCubit.kosongkan();

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            '$jumlah layanan berhasil diajukan bersama.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final modeGelap = tema.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Warga'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Sakelar untuk mengubah tema seluruh aplikasi.
          Card(
            child: SwitchListTile(
              secondary: Icon(
                modeGelap
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
              ),
              title: const Text('Mode gelap'),
              subtitle: const Text(
                'Gunakan tampilan gelap pada seluruh aplikasi.',
              ),
              value: modeGelap,
              onChanged: (aktif) {
                context
                    .read<ThemeCubit>()
                    .ubahModeGelap(aktif);
              },
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Layanan Favorit',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // Menampilkan seluruh favorit tanpa membatasi bidang.
          BlocBuilder<FavoritCubit, Set<String>>(
            builder: (context, favorit) {
              if (favorit.isEmpty) {
                return const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(Icons.star_border),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Belum ada layanan favorit',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Column(
                children: favorit.map((namaLayanan) {
                  return Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.star,
                        color: tema.colorScheme.primary,
                      ),
                      title: Text(namaLayanan),
                      trailing: const Icon(
                        Icons.chevron_right,
                      ),
                      onTap: () {
                        bukaDetailFavorit(
                          context,
                          namaLayanan,
                        );
                      },
                    ),
                  );
                }).toList(),
              );
            },
          ),

          const SizedBox(height: 24),

          const Text(
            'Keranjang Pengajuan',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // Menampilkan layanan yang menunggu pengajuan bersama.
          BlocBuilder<PengajuanCubit, List<String>>(
            builder: (context, daftarPengajuan) {
              if (daftarPengajuan.isEmpty) {
                return const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(Icons.assignment_outlined),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Belum ada layanan dalam keranjang pengajuan',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Total pengajuan: ${daftarPengajuan.length}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  ...daftarPengajuan.map((namaLayanan) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(
                          Icons.assignment_outlined,
                        ),
                        title: Text(namaLayanan),
                        trailing: IconButton(
                          tooltip: 'Hapus dari keranjang',
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            context
                                .read<PengajuanCubit>()
                                .hapusPengajuan(namaLayanan);
                          },
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 12),

                  FilledButton.icon(
                    onPressed: () {
                      kirimSemuaPengajuan(context);
                    },
                    icon: const Icon(Icons.send),
                    label: const Text(
                      'Kirim Semua Pengajuan',
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 24),

          const Text(
            'Riwayat Laporan',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          const Card(
            child: ListTile(
              leading: Icon(Icons.description),
              title: Text('Laporan Jalan Rusak'),
              subtitle: Text('Status: Diproses'),
            ),
          ),

          const Card(
            child: ListTile(
              leading: Icon(Icons.description),
              title: Text('Laporan Sampah'),
              subtitle: Text('Status: Selesai'),
            ),
          ),
        ],
      ),
    );
  }
}