import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void ubahModeGelap(bool aktif) {
    emit(
      aktif ? ThemeMode.dark : ThemeMode.light,
    );
  }
}