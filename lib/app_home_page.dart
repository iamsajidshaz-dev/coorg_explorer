import 'package:coorgtheexplorer/features/places/presentation/pages/about_page.dart';
import 'package:coorgtheexplorer/features/places/presentation/pages/gallery_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/app_colors.dart';
import 'features/places/presentation/pages/home_navigation_page.dart';


class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeNavigationPage(),
    GalleryPage(),
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: AppColors.white,
        elevation: 8,
        height: 65.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              icon: Icons.home_outlined,
              selectedIcon: Icons.home,
              index: 0,
              label: 'Home',
            ),
            _buildNavItem(
              icon: Icons.camera_alt_outlined,
              selectedIcon: Icons.camera_alt,
              index: 1,
              label: 'Gallery',
            ),
            _buildNavItem(
              icon: Icons.account_circle_outlined,
              selectedIcon: Icons.account_circle,
              index: 2,
              label: 'About',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData selectedIcon,
    required int index,
    required String label,
  }) {
    final isSelected = _currentIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? selectedIcon : icon,
            size: isSelected ? 28.sp : 24.sp,
            color: isSelected ? AppColors.primary : AppColors.grey500,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: isSelected ? AppColors.primary : AppColors.grey500,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}