import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/injection.dart';
import 'package:shop_app/presentation/doing/bloc/doing_bloc.dart';
import 'package:shop_app/presentation/done/bloc/done_bloc.dart';
import 'package:shop_app/presentation/home/home_page.dart';
import 'package:shop_app/presentation/todo/bloc/todo_bloc.dart';

Future<void> main() async {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<TodoBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<DoingBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<DoneBloc>(),
        ),
      ],
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
