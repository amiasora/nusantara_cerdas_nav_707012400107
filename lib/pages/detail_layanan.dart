import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/pengajuan_model.dart';



class DetailLayanan extends StatefulWidget {

  final Map<String, String> data;


  const DetailLayanan({
    super.key,
    required this.data,
  });


  @override
  State<DetailLayanan> createState() =>
      _DetailLayananState();

}




class _DetailLayananState extends State<DetailLayanan> {


  bool sedangMengirim = false;



  Future<void> ajukanPermohonan() async {


    final namaLayanan =
        widget.data['nama'] ?? 'Layanan';



    setState(() {

      sedangMengirim = true;

    });



    // simulasi proses pengiriman
    await Future.delayed(
      const Duration(seconds: 2),
    );



    if (!mounted) return;



    context
        .read<PengajuanModel>()
        .tambahPengajuan(
          namaLayanan,
        );



    setState(() {

      sedangMengirim = false;

    });



    Navigator.pop(

      context,

      'Permohonan $namaLayanan telah diajukan.',

    );

  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(

        title:
            const Text(
              'Detail Layanan',
            ),

      ),



      body: ListView(

        padding:
            const EdgeInsets.all(24),



        children: [


          Text(

            widget.data['nama']
                ?? 'Nama layanan',


            style:
                Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(

                      fontWeight:
                          FontWeight.bold,

                    ),

          ),




          const SizedBox(
            height:24,
          ),




          ListTile(

            leading:
                const Icon(
                  Icons.account_balance,
                ),


            title:
                const Text(
                  'Dinas Penanggung Jawab',
                ),


            subtitle:
                Text(
                  widget.data['dinas']
                      ?? '-',
                ),

          ),




          ListTile(

            leading:
                const Icon(
                  Icons.schedule,
                ),


            title:
                const Text(
                  'Jam Operasional',
                ),


            subtitle:
                Text(
                  widget.data['jam']
                      ?? '-',
                ),

          ),




          ListTile(

            leading:
                const Icon(
                  Icons.info_outline,
                ),


            title:
                const Text(
                  'Keterangan',
                ),


            subtitle:
                Text(
                  widget.data['keterangan']
                      ?? '-',
                ),

          ),




          const SizedBox(
            height:24,
          ),




          FilledButton.icon(


            onPressed:

                sedangMengirim

                    ? null

                    : ajukanPermohonan,



            icon:

                sedangMengirim

                    ? const SizedBox(

                        width:20,

                        height:20,

                        child:
                            CircularProgressIndicator(

                          strokeWidth:
                              2,

                        ),

                      )


                    : const Icon(
                        Icons.send,
                      ),




            label:

                Text(

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