import 'package:flutter/foundation.dart';


class PengajuanModel extends ChangeNotifier {


  final List<String> _daftarPengajuan = [];



  List<String> get daftarPengajuan =>
      List.unmodifiable(_daftarPengajuan);



  int get totalPengajuan =>
      _daftarPengajuan.length;



  void tambahPengajuan(String namaLayanan) {

    _daftarPengajuan.add(namaLayanan);

    notifyListeners();

  }



  void hapusPengajuan(String namaLayanan) {

    _daftarPengajuan.remove(namaLayanan);

    notifyListeners();

  }



  void kosongkan() {

    _daftarPengajuan.clear();

    notifyListeners();

  }

}