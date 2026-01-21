import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/onboarding_entity.dart';

class OnboardingCard extends StatelessWidget {
  final OnboardingEntity onboarding;

  const OnboardingCard({
    super.key,
    required this.onboarding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image
          Expanded(
            flex: 3,
            child: Image.asset(
              onboarding.image,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 48.h),

          // Title
          Text(
            onboarding.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 16.h),

          // Description
          Text(
            onboarding.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.white.withOpacity(0.9),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}