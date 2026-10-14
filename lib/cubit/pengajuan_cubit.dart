import 'package:flutter_bloc/flutter_bloc.dart';

class PengajuanCubit extends Cubit<List<String>> {
  PengajuanCubit()
      : super(List<String>.unmodifiable(<String>[]));

  List<String> get daftarPengajuan => state;

  int get totalPengajuan => state.length;

  void tambahPengajuan(String namaLayanan) {
    if (state.contains(namaLayanan)) {
      return;
    }

    final daftarBaru = [...state, namaLayanan];

    emit(List<String>.unmodifiable(daftarBaru));
  }

  void hapusPengajuan(String namaLayanan) {
    if (!state.contains(namaLayanan)) {
      return;
    }

    final daftarBaru = [...state];
    daftarBaru.remove(namaLayanan);

    emit(List<String>.unmodifiable(daftarBaru));
  }

  void kosongkan() {
    if (state.isEmpty) {
      return;
    }

    emit(List<String>.unmodifiable(<String>[]));
  }
}