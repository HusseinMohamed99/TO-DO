// ignore_for_file: import_of_legacy_library_into_null_safe, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/layout/todo_app/todo_layout.dart';
import 'package:todo/network/local/cache_helper.dart';
import 'package:todo/network/remote/dio_helper.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';
import 'package:todo/styles/themes.dart';
import 'bloc_observer.dart';

void main() async {
  // بيتأكد ان كل حاجة خلصت و بعدين يرن
  WidgetsFlutterBinding.ensureInitialized();

  BlocOverrides.runZoned(
    () {},
    blocObserver: MyBlocObserver(),
  );
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');

  runApp(MyApp(
    isDark: isDark,
  ));
}

// Stateless
// Stateful
// class MyApp
class MyApp extends StatelessWidget {
  bool? isDark;

  MyApp({
    required this.isDark,
  });
  // constructor
  // build
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AppCubit()
              ..changeAppMode(
                fromShared: isDark,
              )),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,
            home: Home_Layout(),
          );
        },
      ),
    );
  }
}
