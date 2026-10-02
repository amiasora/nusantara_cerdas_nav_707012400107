import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/pengajuan_model.dart';
import 'app_routes.dart';
import '../pages/beranda.dart';
import '../pages/layanan.dart';
import '../pages/warga.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() =>
      _KerangkaNavigasiState();
}

class _KerangkaNavigasiState
    extends State<KerangkaNavigasi> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  int indeksAktif = 0;

  void pilihTujuan(int indeks) {
    setState(() {
      indeksAktif = indeks;
    });
  }

  void bukaDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  Future<void> tampilkanKonfirmasiKeluar(
    BuildContext context,
  ) async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Keluar'),
          content: const Text(
            'Apakah Anda ingin keluar dari menu saat ini '
            'dan kembali ke Beranda?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  false,
                );
              },
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  true,
                );
              },
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );

    if (!mounted || konfirmasi != true) {
      return;
    }

    setState(() {
      indeksAktif = 0;
    });

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text(
            'Kembali ke Beranda.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  Future<void> bukaMenuPendukung(
    BuildContext context,
    int indeks,
  ) async {
    final navigator = Navigator.of(context);

    navigator.pop();

    if (!context.mounted) {
      return;
    }

    if (indeks == 3) {
      await navigator.pushNamed(
        AppRoutes.pengaturanKota,
      );
    } else if (indeks == 4) {
      await navigator.pushNamed(
        AppRoutes.tentangAplikasi,
      );
    } else if (indeks == 5) {
      await tampilkanKonfirmasiKeluar(
        context,
      );
    }
  }

  void tanganiTombolKembali(
    BuildContext context,
    bool didPop,
  ) {
    if (didPop) {
      return;
    }

    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.pop(context);
      return;
    }

    if (indeksAktif != 0) {
      pilihTujuan(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.sizeOf(context).width;
    final layarLebar = lebar >= 600;

    return PopScope(
      canPop: indeksAktif == 0,
      onPopInvokedWithResult: (didPop, result) {
        tanganiTombolKembali(
          context,
          didPop,
        );
      },
      child: Scaffold(
        key: _scaffoldKey,

        body: Row(
          children: [
            if (layarLebar)
              NavigationRail(
                selectedIndex: indeksAktif,
                onDestinationSelected: pilihTujuan,
                labelType: NavigationRailLabelType.all,
                leading: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: IconButton(
                    tooltip: 'Buka menu',
                    onPressed: bukaDrawer,
                    icon: const Icon(
                      Icons.location_city,
                      size: 32,
                    ),
                  ),
                ),
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: Text('Beranda'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.apps_outlined),
                    selectedIcon: Icon(Icons.apps),
                    label: Text('Layanan'),
                  ),
                  NavigationRailDestination(
                    icon: _IkonWargaDenganBadge(
                      dipilih: false,
                    ),
                    selectedIcon: _IkonWargaDenganBadge(
                      dipilih: true,
                    ),
                    label: Text('Warga'),
                  ),
                ],
              ),

            Expanded(
              child: IndexedStack(
                index: indeksAktif,
                children: const [
                  Beranda(),
                  Layanan(),
                  Warga(),
                ],
              ),
            ),
          ],
        ),

        drawer: NavigationDrawer(
          selectedIndex: indeksAktif,
          onDestinationSelected: (indeks) {
            if (indeks < 3) {
              Navigator.pop(context);
              pilihTujuan(indeks);
            } else {
              bukaMenuPendukung(
                context,
                indeks,
              );
            }
          },
          children: const [
            Padding(
              padding: EdgeInsets.fromLTRB(
                28,
                24,
                16,
                12,
              ),
              child: Text(
                'Nusantara Cerdas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            NavigationDrawerDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: Text('Beranda'),
            ),

            NavigationDrawerDestination(
              icon: Icon(Icons.apps_outlined),
              selectedIcon: Icon(Icons.apps),
              label: Text('Layanan'),
            ),

            NavigationDrawerDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: Text('Warga'),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 10,
              ),
              child: Divider(),
            ),

            NavigationDrawerDestination(
              icon: Icon(Icons.settings_outlined),
              label: Text('Pengaturan Kota'),
            ),

            NavigationDrawerDestination(
              icon: Icon(Icons.info_outline),
              label: Text('Tentang Aplikasi'),
            ),

            NavigationDrawerDestination(
              icon: Icon(Icons.logout),
              label: Text('Keluar'),
            ),
          ],
        ),

        floatingActionButton: layarLebar
            ? null
            : FloatingActionButton.small(
                tooltip: 'Buka menu',
                onPressed: bukaDrawer,
                child: const Icon(Icons.menu),
              ),

        bottomNavigationBar: layarLebar
            ? null
            : NavigationBar(
                selectedIndex: indeksAktif,
                onDestinationSelected: pilihTujuan,
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: 'Beranda',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.apps_outlined),
                    selectedIcon: Icon(Icons.apps),
                    label: 'Layanan',
                  ),
                  NavigationDestination(
                    icon: _IkonWargaDenganBadge(
                      dipilih: false,
                    ),
                    selectedIcon: _IkonWargaDenganBadge(
                      dipilih: true,
                    ),
                    label: 'Warga',
                  ),
                ],
              ),
      ),
    );
  }
}

class _IkonWargaDenganBadge extends StatelessWidget {
  final bool dipilih;

  const _IkonWargaDenganBadge({
    required this.dipilih,
  });

  @override
  Widget build(BuildContext context) {
    final totalPengajuan =
        context.select<PengajuanModel, int>(
      (model) => model.totalPengajuan,
    );

    return Badge(
      isLabelVisible: totalPengajuan > 0,
      label: Text('$totalPengajuan'),
      child: Icon(
        dipilih
            ? Icons.person
            : Icons.person_outline,
      ),
    );
  }
}