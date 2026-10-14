import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nusantara_cerdas_nav_707012400107/main.dart'
    as app;

void main() {
  const ukuranLayar = <String, Size>{
    'layar sempit': Size(390, 844),
    'layar lebar': Size(1200, 900),
  };

  for (final kasus in ukuranLayar.entries) {
    testWidgets(
      'Favorit dan pengajuan bekerja pada ${kasus.key}',
      (WidgetTester tester) async {
        tester.view.devicePixelRatio = 1.0;
        tester.view.physicalSize = kasus.value;

        addTearDown(tester.view.resetDevicePixelRatio);
        addTearDown(tester.view.resetPhysicalSize);

        // Memulai aplikasi dengan provider dari main().
        await tester.pumpWidget(const SizedBox.shrink());
        app.main();
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);

        // Memeriksa navigasi sesuai ukuran layar.
        if (kasus.key == 'layar sempit') {
          expect(
            find.byType(NavigationBar),
            findsOneWidget,
          );
          expect(
            find.byType(NavigationRail),
            findsNothing,
          );
        } else {
          expect(
            find.byType(NavigationRail),
            findsOneWidget,
          );
          expect(
            find.byType(NavigationBar),
            findsNothing,
          );
        }

        // Menandai Izin Usaha dari halaman Layanan.
        await tester.tap(find.text('Layanan'));
        await tester.pumpAndSettle();

        await tester.tap(
          find.byTooltip('Tandai sebagai favorit').first,
        );
        await tester.pump();

        // Memastikan favorit tersedia di halaman Warga.
        await tester.tap(find.text('Warga'));
        await tester.pumpAndSettle();

        expect(find.text('Izin Usaha'), findsOneWidget);

        // Membuka rincian melalui named route.
        await tester.tap(find.text('Izin Usaha'));
        await tester.pumpAndSettle();

        expect(
          find.text('Detail Layanan'),
          findsOneWidget,
        );

        // Memeriksa indikator sebelum pengajuan selesai.
        await tester.tap(find.text('Ajukan Permohonan'));
        await tester.pump();

        expect(find.text('Mengirim...'), findsOneWidget);
        expect(
          find.byType(CircularProgressIndicator),
          findsOneWidget,
        );

        // Menyelesaikan waktu simulasi pengiriman.
        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();

        expect(
          find.text('Total pengajuan: 1'),
          findsOneWidget,
        );

        // Nama layanan muncul pada favorit dan keranjang.
        expect(find.text('Izin Usaha'), findsNWidgets(2));

        final badgeSatu = find.descendant(
          of: find.byType(Badge),
          matching: find.text('1'),
        );

        expect(badgeSatu, findsWidgets);

        // Memastikan badge tetap tersedia di Beranda.
        await tester.tap(find.text('Beranda'));
        await tester.pumpAndSettle();

        expect(badgeSatu, findsWidgets);
        expect(tester.takeException(), isNull);

        // Menutup aplikasi dan membersihkan state tes.
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pumpAndSettle();
      },
    );
  }
}