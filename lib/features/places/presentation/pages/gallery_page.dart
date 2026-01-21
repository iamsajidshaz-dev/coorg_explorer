import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/asset_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/gallery_item.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  final List<String> _galleryImages = const [
    AssetConstants.rajasSeat,
    AssetConstants.abbeyFalls,
    AssetConstants.madikeriFort,
    AssetConstants.mallalliFalls,
    AssetConstants.goldenTemple,
    AssetConstants.harangiDam,
    AssetConstants.mandalpatti,
    AssetConstants.backwater,
    AssetConstants.irpu,
    AssetConstants.kotebetta,
    AssetConstants.rajasTomb,
    AssetConstants.talakaveri,
    AssetConstants.kotteAbbiFalls,
    AssetConstants.dubare,
    AssetConstants.nisargadhama,
    AssetConstants.omkareshwaraTemple,
    AssetConstants.chiklihole,
  ];

  final List<String> _placesList = const [
    'Raja Seat',
    'Abbey Falls',
    'Madikeri Fort',
    'Mallalli Falls',
    'Golden Temple',
    'Harangi Dam',
    'Mandalpatti Peak',
    'Harangi Backwater',
    'Irpu Falls',
    'Kotebetta Peak',
    "Raja's Tomb",
    'Talakaveri',
    'Kotte Abbi Falls',
    'Dubare Elephant Camp',
    'Kaveri Nisargadhama',
    'Omkareshwara Temple',
    'Chiklihole Dam',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          'COORG GALLERY',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 8.h,
        ),
        itemCount: _galleryImages.length,
        itemBuilder: (BuildContext context, int index) {
          return GalleryItem(
            image: _galleryImages[index],
            imagePlace: _placesList[index],
          );
        },
      ),
    );
  }
}