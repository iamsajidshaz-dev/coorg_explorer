import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/asset_constants.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../config/dependency_injection/injection_container.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    print('🚀 Starting app navigation...');
    
    // Wait for splash duration
    await Future.delayed(Duration(seconds: AppConstants.splashDuration));

    if (!mounted) return;

    // Check if first time
    final prefs = InjectionContainer().sharedPreferences;
    final isFirstTime = prefs.getBool(AppConstants.keyIsFirstTime) ?? true;

    print('📱 Is first time: $isFirstTime');

    if (isFirstTime) {
      print('➡️ Navigating to onboarding');
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(RouteConstants.onboarding);
      }
      return;
    }

    // Not first time - check authentication
    print('🔐 Checking authentication status...');
    
    if (!mounted) return;
    
    final authProvider = context.read<AuthProvider>();
    await authProvider.checkAuthStatus();

    if (!mounted) return;

    print('✅ Auth check complete. Authenticated: ${authProvider.isAuthenticated}');

    if (authProvider.isAuthenticated) {
      print('➡️ User authenticated, navigating to home');
      Navigator.of(context).pushReplacementNamed(RouteConstants.home);
    } else {
      print('➡️ User not authenticated, navigating to login');
      Navigator.of(context).pushReplacementNamed(RouteConstants.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AssetConstants.appLogo,
              height: 200.h,
              width: 200.w,
            ),
            SizedBox(height: 24.h),
            Text(
              AppConstants.appName,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 34.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              AppConstants.appTagline,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 48.h),
            const CircularProgressIndicator(
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}