// ignore_for_file: prefer_const_constructors

import 'package:book_reader_app/cubit_intro_page/app_cubit_states.dart';
import 'package:book_reader_app/cubit_intro_page/app_cubits.dart';
import 'package:book_reader_app/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntroAppCubitLogics extends StatefulWidget {
  const IntroAppCubitLogics({super.key});

  @override
  State<IntroAppCubitLogics> createState() => _IntroAppCubitLogicsState();
}

class _IntroAppCubitLogicsState extends State<IntroAppCubitLogics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<IntroAppCubits, IntroCubitStates>(
        builder: (context, state) {
          if (state is LoadingState) {
            return HomePage();
            return Center(child: CircularProgressIndicator());
          } 
          if (state is LoadedState) {
            return HomePage();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
