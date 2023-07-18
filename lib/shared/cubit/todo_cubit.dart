import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/modules/todo_app/newArchived/new_archived_screen.dart';
import 'package:todo/modules/todo_app/newDone/new_done_screen.dart';
import 'package:todo/modules/todo_app/newTasks/new_tasks_screen.dart';
import 'package:todo/network/local/cache_helper.dart';
import 'package:todo/shared/cubit/todo_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const NewTasksScreen(),
    const NewDoneScreen(),
    const NewArchivedScreen(),
  ];
  List<String> titles = [
    'New Tasks ✨',
    'Done Tasks ✔',
    'Archived Tasks ⏳',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  // Create Database ()
  void createDatabase() {
    openDatabase(
      'Todo.db',
      version: 2,
      onCreate: (database, version) async {
        if (kDebugMode) {
          print('Database Created ');
        }
        await database
            .execute(
                'CREATE TABLE TASKS (id INTEGER PRIMARY KEY , title TEXT , description TEXT , date TEXT, time TEXT, status TEXT)')
            .then((value) {
          if (kDebugMode) {
            print('table created');
          }
        }).catchError((error) {
          if (kDebugMode) {
            print('Error when to creating table ${error.toString()}');
          }
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);

        if (kDebugMode) {
          print('Database Opened ');
        }
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  // Insert Into Database ()
  insertToDatabase({
    required String title,
    required String description,
    required String time,
    required String date,
  }) async {
    await database?.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO TASKS (title,description,date,time,status) Values ("$title","$description","$date","$time","new")')
          .then((value) {
        if (kDebugMode) {
          print('$value inserted successfully');
        }
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        if (kDebugMode) {
          print('Error when to inserting New Record  ${error.toString()}');
        }
      });
    });
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });

      emit(AppGetDatabaseState());
    });
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

  void updateData({
    required String status,
    required int id,
  }) {
    database!.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      [status, id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({
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
