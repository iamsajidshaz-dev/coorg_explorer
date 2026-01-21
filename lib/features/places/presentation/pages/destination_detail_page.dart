import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:readmore/readmore.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/cached_image_widget.dart';

class DestinationDetailPage extends StatelessWidget {
  final DestinationDetailArguments arguments;

  const DestinationDetailPage({
    super.key,
    required this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          arguments.title,
          style: TextStyle(fontSize: 20.sp),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // Image
          Padding(
            padding: EdgeInsets.all(12.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18.r),
              child: CachedImageWidget(
                imageUrl: arguments.imageUrl,
                height: 250.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Description Header
          Padding(
            padding: EdgeInsets.only(left: 18.w, top: 18.h, right: 18.w),
            child: Text(
              'Description',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
          ),

          // Description Text
          Padding(
            padding: EdgeInsets.only(left: 18.w, top: 10.h, right: 18.w),
            child: ReadMoreText(
              arguments.description,
              style: TextStyle(fontSize: 14.sp, height: 1.5),
              trimLines: 4,
              colorClickableText: AppColors.primary,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'show more...',
              trimExpandedText: 'show less',
              moreStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
              lessStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),

          // Info Cards
          _buildInfoCard('Elevation', AppConstants.coorgElevation),
          _buildInfoCard('District', AppConstants.coorgDistrict),
          _buildInfoCard('PIN', AppConstants.coorgPIN),
          _buildInfoCard('Region', AppConstants.coorgRegion),
          _buildInfoCard('Telephone Code', AppConstants.coorgTelephoneCode),

          SizedBox(height: 30.h),

          // Get Location Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: SizedBox(
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                ),
                onPressed: _openMap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, size: 24.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Get Location',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 20.h),

          // Footer
          Center(
            child: Text(
              AppConstants.madeBy,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                color: AppColors.primary,
              ),
            ),
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(left: 18.w, top: 8.h),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  void _openMap() async {
    try {
      final lat = double.parse(arguments.latitude);
      final lng = double.parse(arguments.longitude);

      await MapLauncher.showMarker(
        mapType: MapType.google,
        coords: Coords(lat, lng),
        title: arguments.title,
        description: arguments.description,
      );
    } catch (e) {
      print('Error opening map: $e');
    }
  }
}