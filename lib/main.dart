import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saqar/bloc_observer.dart';
import 'package:saqar/saqar_app.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(const SaqarApp());
}
