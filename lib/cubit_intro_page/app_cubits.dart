// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:bloc/bloc.dart';
import 'package:book_reader_app/cubit_intro_page/app_cubit_states.dart';
import 'package:book_reader_app/services/intro_page_services.dart';

class IntroAppCubits extends Cubit<IntroCubitStates> {

  IntroAppCubits({required this.introPageData}) : super((InitialState())) {
    emit(LoadingState());
  }

  final IntroPageDataServices introPageData;
  late final introPageJson;

  void introPage() async {
    try {
      emit(LoadingState());
      introPageJson = await introPageData.getInfo();
      emit(LoadedState(introPageJson));
    } catch (e) {
      print(introPageData);
      return;
    }
  }
}