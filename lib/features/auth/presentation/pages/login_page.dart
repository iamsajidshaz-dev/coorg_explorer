import 'package:coorgtheexplorer/features/auth/presentation/providers/widgets/google_sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/asset_constants.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to avoid calling setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthStatus();
    });
  }

  Future<void> _checkAuthStatus() async {
    if (!mounted) return;
    
    final authProvider = context.read<AuthProvider>();
    await authProvider.checkAuthStatus();
    
    if (!mounted) return;
    
    if (authProvider.isAuthenticated) {
      Navigator.of(context).pushReplacementNamed(RouteConstants.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo
                Image.asset(
                  AssetConstants.appLogo,
                  height: 200.h,
                  width: 200.w,
                ),
                SizedBox(height: 24.h),

                // App Name
                Text(
                  AppConstants.appName,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 34.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),

                // Tagline
                Text(
                  AppConstants.appTagline,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 60.h),

                // Welcome Text
                Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 12.h),

                // Description
                Text(
                  'Sign in to explore the beautiful\nplaces of Coorg',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 48.h),

                // Google Sign In Button
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return GoogleSignInButton(
                      onPressed: () => _handleGoogleSignIn(authProvider),
                      isLoading: authProvider.isLoading,
                    );
                  },
                ),
                SizedBox(height: 24.h),

                // Skip Button (Optional)
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(RouteConstants.home);
                  },
                  child: Text(
                    'Continue as Guest',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                SizedBox(height: 48.h),

                // Terms and Privacy
                Text(
                  'By signing in, you agree to our\nTerms of Service and Privacy Policy',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleGoogleSignIn(AuthProvider authProvider) async {
    final success = await authProvider.signInWithGoogleAccount();

    if (!mounted) return;

    if (success) {
      SnackBarUtils.showSuccess(
        context,
        'Welcome ${authProvider.user?.displayName ?? ""}!',
      );
      Navigator.of(context).pushReplacementNamed(RouteConstants.home);
    } else {
      SnackBarUtils.showError(
        context,
        authProvider.errorMessage ?? 'Failed to sign in',
      );
    }
  }
}