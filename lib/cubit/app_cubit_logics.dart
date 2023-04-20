// ignore_for_file: prefer_const_constructors

import 'package:book_reader_app/cubit/app_cubit_states.dart';
import 'package:book_reader_app/cubit/app_cubits.dart';
import 'package:book_reader_app/homePage.dart';
import 'package:book_reader_app/pages/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubitLogics extends StatefulWidget {
  const AppCubitLogics({super.key});

  @override
  State<AppCubitLogics> createState() => _AppCubitLogicsState();
}

class _AppCubitLogicsState extends State<AppCubitLogics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state) {
          if (state is HomePageState) {
            return HomePage();
          }
          if (state is HomePageState) {
            return HomePage();
          }
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          } 
          if (state is LoadedState) {
            return MenuPage();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
