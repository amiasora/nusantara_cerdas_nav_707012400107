import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/favorit_cubit.dart';
import 'cubit/pengajuan_cubit.dart';

import 'navigation/app_routes.dart';
import 'navigation/kerangka_navigasi.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<FavoritCubit>(
          create: (context) => FavoritCubit(),
        ),
        BlocProvider<PengajuanCubit>(
          create: (context) => PengajuanCubit(),
        ),
      ],
      child: const NusantaraCerdasMobile(),
    ),
  );
}

class NusantaraCerdasMobile extends StatelessWidget {
  const NusantaraCerdasMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nusantara Cerdas Mobile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.kerangka,
      routes: {
        AppRoutes.kerangka:
            (context) => const KerangkaNavigasi(),
        ...AppRoutes.daftarRoute(),
      },
      onGenerateRoute: AppRoutes.bentukRoute,
      onUnknownRoute: AppRoutes.routeTidakDikenal,
    );
  }
}