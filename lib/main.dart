import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/injection.dart';
import 'package:shop_app/nav.dart';
import 'package:shop_app/presentation/bloc/cart_bloc.dart';
import 'package:shop_app/presentation/bloc/home_bloc.dart';
import 'package:shop_app/presentation/bloc/product_detail_bloc.dart';
import 'package:shop_app/presentation/bloc/saved_bloc.dart';

void main() {
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
          create: (_) => locator<HomeBloc>(),
        ),
        BlocProvider(
          create: (_) => locator<ProductDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => locator<SavedBloc>(),
        ),
        BlocProvider(
          create: (_) => locator<CartBloc>(),
        )
      ],
      child: MaterialApp(
        home: Nav(),
      ),
    );
  }
}
