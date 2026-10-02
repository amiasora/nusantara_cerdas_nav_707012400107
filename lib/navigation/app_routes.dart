import 'package:flutter/material.dart';

import '../pages/beranda.dart';
import '../pages/layanan.dart';
import '../pages/warga.dart';
import '../pages/detail_layanan.dart';
import '../pages/pengaturan_kota.dart';
import '../pages/tentang_aplikasi.dart';
import '../pages/riwayat_laporan.dart';
import '../pages/route_tidak_dikenal.dart';

class AppRoutes {
  static const String kerangka = '/';
  static const String beranda = '/beranda';
  static const String layanan = '/layanan';
  static const String warga = '/warga';
  static const String detailLayanan = '/detail-layanan';
  static const String pengaturanKota = '/pengaturan-kota';
  static const String tentangAplikasi = '/tentang-aplikasi';
  static const String riwayatLaporan = '/riwayat-laporan';

  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (_) => const Beranda(),
      layanan: (_) => const Layanan(),
      warga: (_) => const Warga(),
      pengaturanKota: (_) => const PengaturanKota(),
      tentangAplikasi: (_) => const TentangAplikasi(),
      riwayatLaporan: (_) => const RiwayatLaporan(),
    };
  }

  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    if (settings.name == detailLayanan) {
      final arguments = settings.arguments;

      if (arguments is Map<String, String>) {
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => DetailLayanan(
            data: arguments,
          ),
        );
      }

      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const RouteTidakDikenal(
          namaRoute: detailLayanan,
        ),
      );
    }

    // Route selain detail layanan akan dicari
    // melalui properti routes pada MaterialApp.
    // Jika tidak ditemukan, onUnknownRoute dijalankan.
    return null;
  }

  static Route<dynamic> routeTidakDikenal(
    RouteSettings settings,
  ) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => RouteTidakDikenal(
        namaRoute: settings.name,
      ),
    );
  }
}