import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stroke_text/stroke_text.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/cached_image_widget.dart';
import '../../domain/entities/destination_entity.dart';

class DestinationCard extends StatelessWidget {
  final DestinationEntity destination;

  const DestinationCard({
    super.key,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h),
        height: 125.h,
        width: 325.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: AppColors.grey300,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(5.w),
          child: Stack(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: CachedImageWidget(
                  imageUrl: destination.image,
                  width: double.infinity,
                  height: 125.h,
                  fit: BoxFit.cover,
                ),
              ),

              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),

              // Destination info
              Positioned(
                bottom: 10.h,
                left: 10.w,
                right: 10.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StrokeText(
                      text: destination.title,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                      strokeColor: Colors.black,
                      strokeWidth: 2,
                    ),
                    SizedBox(height: 4.h),
                    StrokeText(
                      text: AppConstants.coorgLocation,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                      strokeColor: Colors.black,
                      strokeWidth: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context) {
    Navigator.of(context).pushNamed(
      RouteConstants.destinationDetail,
      arguments: DestinationDetailArguments(
        title: destination.title,
        imageUrl: destination.image,
        description: destination.description,
        latitude: destination.latitude,
        longitude: destination.longitude,
      ),
    );
  }
}