import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo/shared/Cubit/mode_cubit.dart';
import 'package:todo/shared/components/components.dart';
import 'package:todo/shared/components/sized_box.dart';
import 'package:todo/shared/cubit/todo_cubit.dart';
import 'package:todo/shared/cubit/todo_states.dart';
import 'package:todo/shared/enum/enum.dart';
import 'package:todo/styles/themes.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    var formKey = GlobalKey<FormState>();
    var titleController = TextEditingController();
    var descriptionController = TextEditingController();
    var timeController = TextEditingController();
    var dateController = TextEditingController();

    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, state) {
          var textLightTheme = getThemeData[AppTheme.lightTheme]!.textTheme;
          var textDarkTheme = getThemeData[AppTheme.darkTheme]!.textTheme;
          ModeCubit modeCubit = ModeCubit.get(context);
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
                style: modeCubit.isDark
                    ? textLightTheme.titleLarge
                    : textDarkTheme.titleLarge,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0).r,
                  child: CircleAvatar(
                    child: IconButton(
                      onPressed: () {
                        ModeCubit.get(context).changeAppMode();
                      },
                      icon: const Icon(Icons.dark_mode_outlined),
                    ),
                  ),
                )
              ],
            ),
            body: cubit.screens[cubit.currentIndex],

            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                      title: titleController.text,
                      description: descriptionController.text,
                      time: timeController.text,
                      date: dateController.text,
                    );
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) {
                          return Form(
                            key: formKey,
                            child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.all(
                                20.0,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  DefaultTextFormField(
                                    controller: titleController,
                                    type: TextInputType.text,
                                    maxLength: 10,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'title must not be empty';
                                      }
                                      return null;
                                    },
                                    label: 'Task Title',
                                    prefix: Icons.title,
                                  ),
                                  Space(height: 16.h, width: 0),
                                  DefaultTextFormField(
                                    controller: descriptionController,
                                    maxLength: 200,
                                    type: TextInputType.text,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Description must not be empty';
                                      }
                                      return null;
                                    },
                                    label: 'Task Description',
                                    prefix: Icons.description,
                                  ),
                                  Space(height: 16.h, width: 0),
                                  DefaultTextFormField(
                                    controller: timeController,
                                    type: TextInputType.datetime,
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        timeController.text =
                                            value!.format(context).toString();
                                        if (kDebugMode) {
                                          print(value.format(context));
                                        }
                                      });
                                    },
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'time must not be empty';
                                      }
                                      return null;
                                    },
                                    label: 'Task Time',
                                    prefix: Icons.watch_later_outlined,
                                  ),
                                  Space(height: 16.h, width: 0),
                                  DefaultTextFormField(
                                    controller: dateController,
                                    type: TextInputType.datetime,
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.now().add(
                                          const Duration(days: 365),
                                        ),
                                      ).then((value) {
                                        dateController.text =
                                            DateFormat.yMMMd().format(value!);
                                      });
                                    },
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'date must not be empty';
                                      }
                                      return null;
                                    },
                                    label: 'Task Date',
                                    prefix: Icons.calendar_today,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        elevation: 20.0,
                      )
                      .closed
                      .then(
                        (value) {
                          cubit.changeBottomSheetState(
                            isShow: false,
                            icon: Icons.edit,
                          );
                        },
                      );
                  cubit.changeBottomSheetState(
                    isShow: true,
                    icon: Icons.add,
                  );
                }
              },
              child: Icon(
                cubit.fabIcon,
              ),
            ),

            // Bottom
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                  ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check_circle,
                  ),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_outlined,
                  ),
                  label: 'Archived',
                ),
              ],
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
            ),
          );
        },
      ),
    );
  }
}
