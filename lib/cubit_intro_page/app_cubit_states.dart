import 'package:book_reader_app/model/intro_page_model.dart';
import 'package:equatable/equatable.dart';

abstract class IntroCubitStates extends Equatable {}

class InitialState extends IntroCubitStates {
  @override
  List<Object?> get props => [];
}

class LoadingState extends IntroCubitStates {
  @override
  List<Object?> get props => [];
}

class LoadedState extends IntroCubitStates {
  LoadedState(this.introPageJson);
  final List<HomePageDataModel> introPageJson;
  @override
  List<Object?> get props => [introPageJson];
}