// ============================================================================
// FILE: lib/features/about/presentation/pages/about_page.dart
// (FULL VERSION - Replaces placeholder)
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/asset_constants.dart';
import '../../../../core/theme/app_colors.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          'ABOUT COORG',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // App Logo
            Center(
              child: Image.asset(
                AssetConstants.appLogo,
                height: 200.h,
                width: 200.w,
              ),
            ),
            SizedBox(height: 24.h),

            // App Name
            Center(
              child: Text(
                AppConstants.appName,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            SizedBox(height: 8.h),

            // Tagline
            Center(
              child: Text(
                AppConstants.appTagline,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            SizedBox(height: 32.h),

            // Coorg Title
            Center(
              child: Text(
                AppConstants.coorgTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Description 1
            Text(
              AppConstants.coorgDescription1,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textPrimary,
                height: 1.6,
              ),
            ),
            SizedBox(height: 16.h),

            // Description 2
            Text(
              AppConstants.coorgDescription2,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textPrimary,
                height: 1.6,
              ),
            ),
            SizedBox(height: 24.h),

            // Divider
            const Divider(thickness: 1),
            SizedBox(height: 24.h),

            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                AssetConstants.rajasSeat,
                height: 200.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 32.h),

            // Contact Section
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColors.grey100,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.mail_outline,
                    size: 48.sp,
                    color: AppColors.primary,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'For feedback or business queries,',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Reach out to',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    AppConstants.contactEmail,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),

            // Divider
            const Divider(thickness: 1),
            SizedBox(height: 16.h),

            // Made by
            Center(
              child: Text(
                AppConstants.madeBy,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  color: AppColors.primary,
                ),
              ),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}