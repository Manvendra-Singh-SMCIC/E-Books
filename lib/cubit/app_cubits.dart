// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:bloc/bloc.dart';
import 'package:book_reader_app/cubit/app_cubit_states.dart';
import 'package:book_reader_app/services/data_services.dart';

class AppCubits extends Cubit<CubitStates> {
  AppCubits({required this.data}) : super(InitialState()) {
    emit(HomePageState());
  }

  final DataServices data;
  late final img;

  void getData() async {
    try {
      emit(LoadingState());
      img = await data.getInfo();
      emit(LoadedState(img));
    } catch (e) {
      print(img);
      return;
    }
  }
}