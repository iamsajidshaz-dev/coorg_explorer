import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/asset_constants.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../config/dependency_injection/injection_container.dart';
import '../../domain/entities/onboarding_entity.dart';
import '../widgets/onboarding_card.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingEntity> _pages = const [
    OnboardingEntity(
      title: 'Discover Coorg\'s Hidden Gems',
      description:
          'Explore the best tourist spots in Coorg, from famous landmarks to offbeat destinations, all in one app',
      image: AssetConstants.onboarding0,
      bgColor: 0xFF3F51B5, // Indigo
    ),
    OnboardingEntity(
      title: 'Navigate with Ease',
      description:
          "Get precise Google Map locations for every destination. Whether it's a waterfall, a coffee plantation, or a viewpoint, we'll guide you effortlessly with turn-by-turn navigation.",
      image: AssetConstants.onboarding1,
      bgColor: 0xFF1EB090, // Teal
    ),
    OnboardingEntity(
      title: 'Find What Interests You',
      description:
          "Looking for adventure, history, or relaxation? Our app categorizes places based on your preferences. Choose from categories like nature, culture, and more to tailor your experience.",
      image: AssetConstants.onboarding2,
      bgColor: 0xFFFEAE4F, // Orange
    ),
    OnboardingEntity(
      title: 'Visualize Your Journey',
      description:
          "Get a sneak peek of each location with rich images. Visual references help you decide where to go next and inspire your adventure around Coorg",
      image: AssetConstants.onboarding3,
      bgColor: 0xFF9C27B0, // Purple
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _onSkip() async {
    await _setOnboardingComplete();
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(RouteConstants.login);
  }

  void _onNext() {
    if (_currentPage == _pages.length - 1) {
      _onSkip();
    } else {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _setOnboardingComplete() async {
    final prefs = InjectionContainer().sharedPreferences;
    await prefs.setBool(AppConstants.keyIsFirstTime, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: Color(_pages[_currentPage].bgColor),
        child: SafeArea(
          child: Column(
            children: [
              // PageView
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return OnboardingCard(
                      onboarding: _pages[index],
                    );
                  },
                ),
              ),

              // Page Indicator
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: _currentPage == index ? 24.w : 8.w,
                      height: 8.h,
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                ),
              ),

              // Bottom Buttons
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Skip Button
                    TextButton(
                      onPressed: _onSkip,
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    // Next/Finish Button
                    ElevatedButton(
                      onPressed: _onNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        foregroundColor: Color(_pages[_currentPage].bgColor),
                        padding: EdgeInsets.symmetric(
                          horizontal: 32.w,
                          vertical: 12.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                      ),
                      child: Text(
                        _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
}