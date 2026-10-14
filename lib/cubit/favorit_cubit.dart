import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritCubit extends Cubit<Set<String>> {
  FavoritCubit()
      : super(Set<String>.unmodifiable(<String>{}));

  void tandai(String namaLayanan) {
    if (state.contains(namaLayanan)) {
      return;
    }

    final favoritBaru = {...state, namaLayanan};

    emit(Set<String>.unmodifiable(favoritBaru));
  }

  void batalTandai(String namaLayanan) {
    if (!state.contains(namaLayanan)) {
      return;
    }

    final favoritBaru = {...state};
    favoritBaru.remove(namaLayanan);

    emit(Set<String>.unmodifiable(favoritBaru));
  }
}