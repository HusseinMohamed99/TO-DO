// ignore_for_file: unnecessary_string_interpolations, non_constant_identifier_names, curly_braces_in_flow_control_structures, empty_statements, avoid_print, null_check_always_fails
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/modules/todo_app/new_Done/New_Done_Screen.dart';
import 'package:todo/modules/todo_app/new_Tasks/New_Tasks_Screen.dart';
import 'package:todo/modules/todo_app/new_archived/New_archived_Screen.dart';
import 'package:todo/network/local/cache_helper.dart';
import 'package:todo/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    New_Tasks_Screen(),
    New_Done_Screen(),
    New_archived_Screen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void ChangeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  Database? database;
  List<Map> NewTasks = [];
  List<Map> DoneTasks = [];
  List<Map> ArchivedTasks = [];

  // Create Database ()
  void createDatabase() {
    openDatabase(
      'Todo.db',
      version: 1,
      onCreate: (database, version) async {
        print('Database Created ');
        await database
            .execute(
                'CREATE TABLE TASKS (id INTEGER PRIMARY KEY , title TEXT , date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error when to creating table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);

        print('Database Opened ');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  // Insert Into Database ()
  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database!.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO TASKS (title,date,time,status) Values ("$title","$date","$time","new")')
          .then((value) {
        print('$value inserted succesfully');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error when to inserting New Record  ${error.toString()}');
      });
    });
  }

  void getDataFromDatabase(database) {
    NewTasks = [];
    DoneTasks = [];
    ArchivedTasks = [];

    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          NewTasks.add(element);
        else if (element['status'] == 'done')
          DoneTasks.add(element);
        else
          ArchivedTasks.add(element);
      });

      emit(AppGetDatabaseState());
    });
    ;
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  void UpdateData({
    required String status,
    required int id,
  }) {
    database!.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void DeleteData({
    required int id,
  }) {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit((AppDeleteDatabaseState()));
    });
  }

  bool isDark = false;
  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
