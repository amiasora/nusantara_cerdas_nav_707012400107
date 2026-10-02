import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/favorit_model.dart';


class Warga extends StatelessWidget {

  const Warga({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Warga',
        ),
      ),


      body: ListView(

        padding:
            const EdgeInsets.all(16),


        children: [


          const Text(

            'Layanan Favorit',

            style: TextStyle(

              fontSize: 22,

              fontWeight:
                  FontWeight.bold,

            ),

          ),


          const SizedBox(
            height: 12,
          ),



          Consumer<FavoritModel>(

            builder:
                (context, favorit, child) {


              if (favorit.layananFavorit.isEmpty) {


                return Card(

                  child: Padding(

                    padding:
                        const EdgeInsets.all(16),


                    child: Row(

                      children: const [

                        Icon(
                          Icons.star_border,
                        ),


                        SizedBox(
                          width: 12,
                        ),


                        Text(
                          'Belum ada layanan favorit',
                        ),

                      ],

                    ),

                  ),

                );


              }



              return Column(

                children:

                    favorit.layananFavorit
                        .map(

                          (layanan) {


                            return Card(

                              child:
                                  ListTile(


                                leading:
                                    const Icon(

                                  Icons.star,

                                  color:
                                      Colors.amber,

                                ),



                                title:
                                    Text(
                                      layanan,
                                    ),


                                trailing:
                                    const Icon(
                                      Icons.chevron_right,
                                    ),


                              ),

                            );


                          },

                        )
                        .toList(),


              );


            },

          ),



          const SizedBox(
            height: 24,
          ),




          const Text(

            'Riwayat Laporan',

            style: TextStyle(

              fontSize: 22,

              fontWeight:
                  FontWeight.bold,

            ),

          ),



          const SizedBox(
            height: 12,
          ),




          Card(

            child:
                ListTile(


              leading:
                  const Icon(
                    Icons.description,
                  ),



              title:
                  const Text(
                    'Laporan Jalan Rusak',
                  ),



              subtitle:
                  const Text(
                    'Status: Diproses',
                  ),


            ),

          ),



          Card(

            child:
                ListTile(


              leading:
                  const Icon(
                    Icons.description,
                  ),



              title:
                  const Text(
                    'Laporan Sampah',
                  ),



              subtitle:
                  const Text(
                    'Status: Selesai',
                  ),


            ),

          ),


        ],

      ),

    );

  }

}