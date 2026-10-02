import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/favorit_model.dart';
import '../navigation/app_routes.dart';


class Layanan extends StatelessWidget {

  const Layanan({super.key});


  static const Map<String, List<Map<String, String>>> data = {

    'Perizinan': [

      {
        'nama': 'Izin Usaha',
        'dinas': 'Dinas Penanaman Modal',
        'jam': '08.00–15.00',
        'keterangan':
            'Pengajuan izin usaha masyarakat.',
      },


      {
        'nama': 'Izin Bangunan',
        'dinas': 'Dinas Tata Ruang',
        'jam': '08.00–15.00',
        'keterangan':
            'Layanan perizinan bangunan.',
      },


      {
        'nama': 'Izin Keramaian',
        'dinas': 'Dinas Pelayanan Publik',
        'jam': '08.00–14.00',
        'keterangan':
            'Pengurusan izin kegiatan warga.',
      },

    ],



    'Kesehatan': [

      {
        'nama': 'Jadwal Puskesmas',
        'dinas': 'Dinas Kesehatan',
        'jam': '07.00–14.00',
        'keterangan':
            'Informasi jadwal layanan puskesmas.',
      },


      {
        'nama': 'Konsultasi Kesehatan',
        'dinas': 'Dinas Kesehatan',
        'jam': '08.00–15.00',
        'keterangan':
            'Konsultasi kesehatan dasar.',
      },


      {
        'nama': 'Ambulans Kota',
        'dinas': 'Dinas Kesehatan',
        'jam': '24 jam',
        'keterangan':
            'Informasi layanan ambulans.',
      },

    ],



    'Transportasi': [

      {
        'nama': 'Kartu Transportasi',
        'dinas': 'Dinas Perhubungan',
        'jam': '08.00–15.00',
        'keterangan':
            'Pengajuan kartu transportasi kota.',
      },


      {
        'nama': 'Pengaduan Jalan',
        'dinas': 'Dinas Perhubungan',
        'jam': '24 jam',
        'keterangan':
            'Pelaporan gangguan fasilitas jalan.',
      },


      {
        'nama': 'Informasi Rute',
        'dinas': 'Dinas Perhubungan',
        'jam': '24 jam',
        'keterangan':
            'Informasi rute transportasi publik.',
      },

    ],

  };



  Future<void> bukaDetail(
    BuildContext context,
    Map<String,String> item,
  ) async {


    final hasil = await Navigator.pushNamed(
      context,
      AppRoutes.detailLayanan,
      arguments: item,
    );


    if(!context.mounted || hasil == null){
      return;
    }


    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            hasil.toString(),
          ),

          behavior:
              SnackBarBehavior.floating,

        ),
      );

  }




  Widget buatDaftarLayanan(
    BuildContext context,
    List<Map<String,String>> items,
  ){


    return ListView.separated(

      padding:
          const EdgeInsets.all(16),


      itemCount:
          items.length,


      separatorBuilder:
          (context,index){

            return const SizedBox(
              height:12,
            );

          },



      itemBuilder:
          (context,index){


            final item = items[index];

            final nama =
                item['nama']!;



            // membaca status favorit
            final favorit =
                context.watch<FavoritModel>();


            final sudahFavorit =
                favorit.isFavorit(nama);



            return Card(


              elevation:1,


              shape:
                  RoundedRectangleBorder(

                borderRadius:
                    BorderRadius.circular(16),

              ),



              child: ListTile(


                contentPadding:
                    const EdgeInsets.symmetric(
                      horizontal:20,
                      vertical:10,
                    ),



                title: Text(

                  nama,

                  style:
                      const TextStyle(

                    fontSize:17,

                    fontWeight:
                        FontWeight.bold,

                  ),

                ),



                subtitle:
                    Padding(

                  padding:
                      const EdgeInsets.only(
                        top:6,
                      ),


                  child: Text(
                    item['keterangan']!,
                  ),

                ),




                trailing:

                    Row(

                  mainAxisSize:
                      MainAxisSize.min,


                  children:[


                    IconButton(

                      icon:

                          Icon(

                        sudahFavorit

                            ? Icons.star

                            : Icons.star_border,


                        color:

                            sudahFavorit

                                ? Colors.amber

                                : null,

                      ),



                      onPressed:(){


                        context
                            .read<FavoritModel>()
                            .toggle(nama);


                      },

                    ),



                    const Icon(
                      Icons.chevron_right,
                    ),

                  ],

                ),




                onTap:(){

                  bukaDetail(
                    context,
                    item,
                  );

                },

              ),

            );

          },

    );

  }




  @override
  Widget build(BuildContext context){


    return DefaultTabController(

      length:3,


      child: Scaffold(


        appBar:AppBar(

          title:
              const Text(
                'Layanan Publik',
              ),



          bottom:
              const TabBar(

            tabs:[

              Tab(
                text:'Perizinan',
              ),

              Tab(
                text:'Kesehatan',
              ),

              Tab(
                text:'Transportasi',
              ),

            ],

          ),

        ),



        body:
            TabBarView(

          children:[

            buatDaftarLayanan(
              context,
              data['Perizinan']!,
            ),


            buatDaftarLayanan(
              context,
              data['Kesehatan']!,
            ),


            buatDaftarLayanan(
              context,
              data['Transportasi']!,
            ),

          ],

        ),


      ),

    );

  }

}