// ============================================================================
// FILE: lib/features/places/presentation/pages/place_detail_page.dart
// (FULL VERSION - Replaces placeholder)
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:readmore/readmore.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/cached_image_widget.dart';

class PlaceDetailPage extends StatelessWidget {
  final PlaceDetailArguments arguments;

  const PlaceDetailPage({
    super.key,
    required this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width.w,
        height: MediaQuery.of(context).size.height.h,
        child: Stack(
          children: [
            // Main Image
            Positioned(
              left: 0,
              right: 0,
              child: Hero(
                tag: arguments.imageUrl,
                child: GestureDetector(
                  onTap: () => _viewImage(context, arguments.imageUrl),
                  child: CachedImageWidget(
                    imageUrl: arguments.imageUrl,
                    width: 360.w,
                    height: MediaQuery.of(context).size.height / 2.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Back & Favorite Buttons
            Positioned(
              left: 2.w,
              right: 2.w,
              top: 50.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCircleButton(
                    icon: Icons.arrow_back_ios,
                    onPressed: () => Navigator.pop(context),
                  ),
                  _buildCircleButton(
                    icon: Icons.favorite_outline,
                    iconColor: AppColors.favorite,
                    onPressed: () {
                      // TODO: Add to favorites
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Favorites feature coming soon!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Content Card
            Positioned(
              top: 320.h,
              child: Container(
                padding: EdgeInsets.only(top: 30.h, right: 20.w, left: 20.w),
                width: 360.w,
                height: 690.h - 320.h,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title & Location
                      _buildTitleSection(),
                      SizedBox(height: 10.h),
                      Divider(
                        color: AppColors.grey500,
                        thickness: 1.w,
                      ),
                      SizedBox(height: 20.h),

                      // Facilities
                      _buildFacilitiesSection(),
                      SizedBox(height: 20.h),

                      // Description
                      _buildDescriptionSection(),
                      SizedBox(height: 20.h),

                      // Gallery
                      _buildGallerySection(context),
                      SizedBox(height: 30.h),

                      // Get Location Button
                      _buildLocationButton(context),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onPressed,
    Color? iconColor,
  }) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 2.0,
      fillColor: AppColors.white,
      shape: const CircleBorder(),
      child: Icon(
        icon,
        size: 20.sp,
        color: iconColor ?? AppColors.black87,
      ),
    );
  }

  Widget _buildTitleSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            '${arguments.title}, ${arguments.subtitle}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
        ),
        Icon(
          Icons.place,
          color: AppColors.error,
          size: 28.sp,
        ),
      ],
    );
  }

  Widget _buildFacilitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Facilities',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildFacilityCard(
              icon: Icons.local_parking,
              label: AppConstants.facilityParking,
              color: AppColors.error,
            ),
            _buildFacilityCard(
              icon: Icons.restaurant,
              label: AppConstants.facilityFood,
              color: AppColors.success,
            ),
            _buildFacilityCard(
              icon: Icons.info,
              label: AppConstants.facilityGuides,
              color: AppColors.info,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFacilityCard({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      height: 70.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: AppColors.grey200,
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28.sp),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 10.h),
        ReadMoreText(
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
      ],
    );
  }

  Widget _buildGallerySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gallery',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildGalleryImage(context, arguments.imageOne),
            _buildGalleryImage(context, arguments.imageTwo),
            _buildGalleryImage(context, arguments.imageThree),
          ],
        ),
      ],
    );
  }

  Widget _buildGalleryImage(BuildContext context, String imageUrl) {
    return GestureDetector(
      onTap: () => _viewImage(context, imageUrl),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        child: CachedImageWidget(
          imageUrl: imageUrl,
          height: 100.h,
          width: 100.w,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLocationButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
        ),
        onPressed: () => _openMap(),
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

  void _viewImage(BuildContext context, String imageUrl) {
    Navigator.of(context).pushNamed(
      RouteConstants.imageViewer,
      arguments: ImageViewerArguments(
        imageUrl: imageUrl,
        imageName: arguments.title,
        isNetworkImage: false,
      ),
    );
  }
}