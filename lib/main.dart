import 'package:flutter/material.dart';
import 'package:moto_pay_test/business/recipe_list/pagination_bloc.dart';
import 'package:moto_pay_test/business/recipe_details/reciepe_details_bloc.dart';
import 'package:moto_pay_test/presentation/list_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business/observer/simple_observer.dart';

void main() {
  Bloc.observer = const SimpleBlocObserver();//Observer Bloc
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PaginationBloc(),
        ),
        BlocProvider(
          create: (context) => RecipeDetailsBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Moto pay test',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ListPage(),
      ),
    );
  }
}
