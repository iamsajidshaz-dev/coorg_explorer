import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/place_entity.dart';
import 'place_card.dart';

class CategoryTabsWidget extends StatelessWidget {
  final TabController tabController;
  final List<PlaceEntity> places;

  const CategoryTabsWidget({
    super.key,
    required this.tabController,
    required this.places,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tab Bar
        Padding(
          padding: EdgeInsets.only(left: 5.w, top: 25.h),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.grey500,
              splashBorderRadius: BorderRadius.circular(12.r),
              tabAlignment: TabAlignment.start,
              indicatorPadding: EdgeInsets.zero,
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              isScrollable: true,
              tabs: [
                _buildTab('View Points'),
                _buildTab('Waterfall'),
                _buildTab('Temple'),
                _buildTab('River/Dam'),
              ],
            ),
          ),
        ),

        // Tab Views
        Padding(
          padding: EdgeInsets.only(left: 20.w, top: 25.h),
          child: SizedBox(
            width: double.infinity,
            height: 150.h,
            child: TabBarView(
              controller: tabController,
              children: [
                _buildCategoryList(AppConstants.categoryViewpoint),
                _buildCategoryList(AppConstants.categoryWaterfall),
                _buildCategoryList(AppConstants.categoryTemple),
                _buildCategoryList(AppConstants.categoryDam),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTab(String label) {
    return Container(
      height: 40.h,
      width: 100.w,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.black),
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Tab(
        text: label,
        height: 100.h,
      ),
    );
  }

  Widget _buildCategoryList(String category) {
    final filteredPlaces =
        places.where((place) => place.category == category).toList();

    if (filteredPlaces.isEmpty) {
      return Center(
        child: Text(
          'No places found',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: filteredPlaces.length,
      itemBuilder: (context, index) {
        return PlaceCard(place: filteredPlaces[index]);
      },
    );
  }
}