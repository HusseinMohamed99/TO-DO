// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, avoid_types_as_parameter_names, sort_child_properties_last, body_might_complete_normally_nullable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/styles/colors.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(text.toUpperCase()),
    );

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  String Function(String?)? onSubmit,
  Function(String)? onChange,
  Function()? onTap,
  required Function validate,
  required String label,
  required IconData prefix,
  bool isPassword = false,
  bool isClickable = true,
  IconData? suffix,
  Function? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      enabled: isClickable,
      onTap: onTap,
      validator: (v) {
        validate(v);
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Card(
        elevation: 20.0,
        color: Colors.grey[200],
        margin: EdgeInsetsDirectional.all(20),
        child: SizedBox(
          height: 110,
          child: Row(
            children: [
              CircleAvatar(
                radius: 40.0,
                child: Text(
                  '${model['time']}',
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model['title']}',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${model['date']}',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              IconButton(
                onPressed: () {
                  AppCubit.get(context).UpdateData(
                    status: 'done',
                    id: model['id'],
                  );
                },
                icon: Icon(
                  Icons.check_box,
                  color: Colors.green,
                ),
              ),
              IconButton(
                onPressed: () {
                  AppCubit.get(context).UpdateData(
                    status: 'archive',
                    id: model['id'],
                  );
                },
                icon: Icon(
                  Icons.archive,
                  color: Colors.black38,
                ),
              ),
            ],
          ),
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).DeleteData(
          id: model['id'],
        );
      },
    );

Widget tasksBuilder({required List<Map> tasks}) => ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.menu,
            size: 150.0,
            color: Colors.grey,
          ),
          Text(
            'No Tasks Yet, please Add Some',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ]),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: defaultColor,
      ),
    );

void navigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );
