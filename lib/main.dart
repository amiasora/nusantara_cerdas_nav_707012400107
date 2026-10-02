import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/favorit_model.dart';
import 'models/pengajuan_model.dart';

import 'navigation/app_routes.dart';
import 'navigation/kerangka_navigasi.dart';


void main() {

  runApp(

    MultiProvider(

      providers: [

        ChangeNotifierProvider(
          create: (context) => FavoritModel(),
        ),


        ChangeNotifierProvider(
          create: (context) => PengajuanModel(),
        ),

      ],


      child: const NusantaraCerdasMobile(),

    ),

  );

}



class NusantaraCerdasMobile extends StatelessWidget {

  const NusantaraCerdasMobile({
    super.key,
  });


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
            (_) => const KerangkaNavigasi(),


        ...AppRoutes.daftarRoute(),

      },


      onGenerateRoute:
          AppRoutes.bentukRoute,


      onUnknownRoute:
          AppRoutes.routeTidakDikenal,

    );

  }

}