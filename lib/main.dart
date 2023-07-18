import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/bloc_observer.dart';
import 'package:todo/layout/todo_app/todo_layout.dart';
import 'package:todo/network/local/cache_helper.dart';
import 'package:todo/shared/cubit/todo_cubit.dart';
import 'package:todo/shared/cubit/todo_states.dart';
import 'package:todo/shared/enum/enum.dart';
import 'package:todo/styles/themes.dart';
import 'package:wakelock/wakelock.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  Wakelock.enable();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getBoolean(key: 'isDark');

  runApp(MyApp(
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  const MyApp({
    Key? key,
    this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()
            ..createDatabase()
            ..changeAppMode(fromShared: isDark),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          return ScreenUtilInit(
              designSize: const Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return MaterialApp(
                  title: 'TO DO',
                  debugShowCheckedModeBanner: false,
                  theme: getThemeData[AppTheme.lightTheme],
                  darkTheme: getThemeData[AppTheme.darkTheme],
                  themeMode: AppCubit.get(context).isDark
                      ? ThemeMode.light
                      : ThemeMode.dark,
                  home: const HomeLayout(),
                );
              });
        },
      ),
    );
  }
}
