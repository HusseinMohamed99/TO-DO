import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/shared/components/sized_box.dart';
import 'package:todo/shared/cubit/todo_cubit.dart';
import 'package:todo/styles/colors.dart';

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
    AppCubit cubit = AppCubit.get(context);
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
        labelStyle: Theme.of(context).textTheme.titleSmall,
        prefixIcon: Icon(
          prefix,
          size: 24.sp,
          color:
              cubit.isDark ? AppMainColors.greyColor : AppMainColors.blueColor,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                  size: 24.sp,
                  color: cubit.isDark
                      ? AppMainColors.greyColor
                      : AppMainColors.blueColor,
                ),
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

Widget gridTasksItem(Map model, List<Map> tasks, context, index) {
  return Card(
    elevation: 20.0,
    child: Padding(
      padding: const EdgeInsets.all(8.0).r,
      child: Column(
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              showBottomSheetWidget(
                context,
                tasks[index],
              );
              if (kDebugMode) {
                print(index);
              }
            },
            child: Column(
              children: [
                Text(
                  '${model['title']}'.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${model['description']}',
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Space(height: 16.h, width: 0),
                Column(
                  children: [
                    Text(
                      '${model['time']}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      '${model['date']}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                Space(height: 8.h, width: 0),
              ],
            ),
          ),
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
                    icon: Icon(
                      Icons.check_box,
                      color: AppMainColors.greenColor,
                      size: 24.sp,
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
                    icon: Icon(
                      Icons.archive,
                      color: AppMainColors.blueColor,
                      size: 24.sp,
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
                    icon: Icon(
                      Icons.delete_forever_outlined,
                      color: AppMainColors.redColor,
                      size: 24.sp,
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

Widget tasksBuilder({required List<Map> tasks}) {
  return ConditionalBuilder(
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
          (index) => gridTasksItem(
                tasks[index],
                tasks,
                context,
                index,
              )),
    ),
    fallback: (context) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0).r,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset(
              'assets/images/empty.svg',
              fit: BoxFit.fill,
              width: 200.w,
              height: 200.h,
            ),
            Space(height: 20.h, width: 0.w),
            Text(
              'No Tasks Yet, Please Add Some',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ]),
        ),
      );
    },
  );
}

Widget myDivider() => Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8, bottom: 0).r,
      child: Container(
        width: double.infinity,
        height: 4.0,
        color: AppMainColors.dividerColor,
      ),
    );

void showBottomSheetWidget(BuildContext context, Map model) {
  var cubit = AppCubit.get(context);
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: cubit.isDark
        ? AppMainColors.whiteColor
        : AppColorsDark.primaryDarkColor,
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
              color: cubit.isDark
                  ? AppMainColors.whiteColor
                  : AppColorsDark.primaryDarkColor,
              borderRadius: BorderRadius.vertical(
                top: const Radius.circular(20).r,
              ),
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
                      color: cubit.isDark
                          ? AppColorsLight.tealColor
                          : AppColorsDark.primaryDarkColor,
                    ),
                  ),
                ),
                Space(height: 20.h, width: 0.w),
                Padding(
                  padding: const EdgeInsets.all(12.0).r,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '${model['title']}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        myDivider(),
                        Space(height: 15.h, width: 0.w),
                        Text(
                          '${model['description']}',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: AppMainColors.greyColor,
                                  ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
