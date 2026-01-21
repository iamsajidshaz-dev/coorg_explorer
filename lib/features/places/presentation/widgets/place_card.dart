import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stroke_text/stroke_text.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/widgets/cached_image_widget.dart';
import '../../domain/entities/place_entity.dart';

class PlaceCard extends StatelessWidget {
  final PlaceEntity place;

  const PlaceCard({
    super.key,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context),
      child: Hero(
        tag: place.mainImage,
        child: Container(
          margin: EdgeInsets.only(right: 20.w),
          width: 250.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Stack(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: CachedImageWidget(
                  imageUrl: place.mainImage,
                  width: 250.w,
                  height: 150.h,
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

              // Place info
              Positioned(
                bottom: 10.h,
                left: 10.w,
                right: 10.w,
                child: StrokeText(
                  text: '${place.title}, ${place.subtitle}',
                  textStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  strokeColor: Colors.black,
                  strokeWidth: 2,
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
      RouteConstants.placeDetail,
      arguments: PlaceDetailArguments(
        placeId: place.id,
        title: place.title,
        subtitle: place.subtitle,
        imageUrl: place.mainImage,
        imageOne: place.imageOne,
        imageTwo: place.imageTwo,
        imageThree: place.imageThree,
        description: place.description,
        latitude: place.latitude,
        longitude: place.longitude,
        category: place.category,
      ),
    );
  }
}