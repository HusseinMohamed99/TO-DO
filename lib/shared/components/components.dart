import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/shared/Cubit/mode_cubit.dart';
import 'package:todo/shared/components/sized_box.dart';
import 'package:todo/shared/cubit/todo_cubit.dart';
import 'package:todo/shared/enum/enum.dart';
import 'package:todo/styles/colors.dart';
import 'package:todo/styles/themes.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField(
      {required this.controller,
      required this.type,
      required this.validate,
      this.onSubmit,
      this.isPassword,
      this.isClickable,
      this.onTap,
      this.onChanged,
      this.suffix,
      this.suffixPressed,
      this.prefix,
      this.maxLength,
      required this.label,
      super.key});

  final TextEditingController controller;
  final String label;
  final TextInputType type;
  final bool? isPassword;
  final bool? isClickable;
  final String? Function(String?) validate;
  final String Function(String?)? onSubmit;
  final dynamic onTap;
  final dynamic onChanged;
  final IconData? suffix;
  final IconData? prefix;
  final Function? suffixPressed;

  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword ?? false,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      enabled: isClickable ?? true,
      onTap: onTap,
      validator: validate,
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
  }
}

Widget gridTasksItem(Map model, context) {
  var textLightTheme = getThemeData[AppTheme.lightTheme]!.textTheme;
  var textDarkTheme = getThemeData[AppTheme.darkTheme]!.textTheme;
  var cubit = ModeCubit.get(context);
  return Card(
    elevation: 20.0,
    margin: const EdgeInsets.all(6).r,
    child: Padding(
      padding: const EdgeInsets.all(16.0).r,
      child: Column(
        children: [
          Text(
            '${model['title']}'.toUpperCase(),
            style: cubit.isDark
                ? textLightTheme.titleLarge
                : textDarkTheme.titleLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${model['description']}',
            style: cubit.isDark
                ? textLightTheme.titleSmall
                : textDarkTheme.titleSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Space(height: 16.h, width: 0),
          Column(
            children: [
              Text(
                '${model['time']}',
                style: cubit.isDark
                    ? textLightTheme.titleSmall
                    : textDarkTheme.titleSmall,
              ),
              Text(
                '${model['date']}',
                style: cubit.isDark
                    ? textLightTheme.titleSmall
                    : textDarkTheme.titleSmall,
              ),
            ],
          ),
          Space(height: 8.h, width: 0),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      AppCubit.get(context).updateData(
                        status: 'done',
                        id: model['id'],
                      );
                    },
                    icon: const Icon(
                      Icons.check_box,
                      color: Colors.green,
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      AppCubit.get(context).updateData(
                        status: 'archive',
                        id: model['id'],
                      );
                    },
                    icon: const Icon(
                      Icons.archive,
                      color: Colors.black38,
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      AppCubit.get(context).deleteData(
                        id: model['id'],
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.black38,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget tasksBuilder({required List<Map> tasks}) => ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) => GridView.count(
        padding: const EdgeInsets.all(0).r,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 1.w,
        mainAxisSpacing: 2.h,
        childAspectRatio: 1.h / 1.h,
        children: List.generate(
            tasks.length,
            (index) => InkWell(
                onTap: () {
                  showBottomSheetWidget(context, tasks[index]);
                  if (kDebugMode) {
                    print(index);
                  }
                },
                child: gridTasksItem(tasks[index], context))),
      ),
      fallback: (context) => const Center(
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
        color: AppColorsDark.primaryRedColor,
      ),
    );

void showBottomSheetWidget(BuildContext context, Map model) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: AppColorsDark.primaryGreenColor,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: const Radius.circular(25.0).r,
      ),
    ),
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.3.sp,
      minChildSize: 0.2.spMin,
      maxChildSize: 0.62.spMax,
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            decoration: BoxDecoration(
              color: AppColorsDark.primaryDarkColor,
              borderRadius:
                  BorderRadius.vertical(top: const Radius.circular(20).r),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10).r,
            margin: const EdgeInsets.symmetric(horizontal: 10).r,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -20.h,
                  child: Container(
                    width: 50.w,
                    height: 6.h,
                    margin: const EdgeInsets.only(bottom: 20).r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.5).r,
                      color: AppColorsDark.primaryGreenColor,
                    ),
                  ),
                ),
                Space(height: 20.h, width: 0.w),
                Column(children: [
                  Row(
                    children: [
                      Text(
                        '${model['title']}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                  const Divider(),
                  Space(height: 15.h, width: 0.w),
                  Text(
                    '${model['description']}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColorsDark.primaryGreenColor,
                        ),
                  ),
                ]),
              ],
            ),
          ),
        );
      },
    ),
  );
}
