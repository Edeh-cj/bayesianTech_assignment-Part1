
import 'package:bayesiantech_assignment_part1/addcard/addcardpage.dart';
import 'package:bayesiantech_assignment_part1/addcard/cardbloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardBloc(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AddCardPage(),
      ),
    );
  }
}