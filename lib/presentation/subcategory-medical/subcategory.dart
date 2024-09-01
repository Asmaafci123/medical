import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/themes/app_colors.dart';
import '../../data/models/category-model.dart';
import '../more4u_home/cubits/more4u_home_cubit.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/utils/app_bar.dart';
import 'subcategory-widget.dart';

class SubCategory extends StatelessWidget {
  static const routeName = 'SubCategory';
  final List<CategoryModel> subCategory;
  const SubCategory({Key? key,required this.subCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<More4uHomeCubit, More4uHomeState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
            appBar: myAppBarMedicalIos(),
            drawer: const DrawerWidget(),
            body: SafeArea(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MyAppBar(),
                          Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: AutoSizeText(
                              subCategory[0].categoryName!,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 24.sp,
                                  fontFamily: 'Joti',
                                  color: AppColors.redColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Expanded(
                              child:SubCategoryWidget(
                            subCategory:subCategory))
                        ]))
            )
        );
      },
    );
  }
}
