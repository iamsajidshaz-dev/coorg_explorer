import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/asset_constants.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_widget.dart';
import '../providers/places_provider.dart';
import '../widgets/category_tabs_widget.dart';
import '../widgets/destination_card.dart';

class HomeNavigationPage extends StatefulWidget {
  const HomeNavigationPage({super.key});

  @override
  State<HomeNavigationPage> createState() => _HomeNavigationPageState();
}

class _HomeNavigationPageState extends State<HomeNavigationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PlacesProvider>().loadAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          AppConstants.appName,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: Image.asset(AssetConstants.appLogo),
        ),
      ),
      body: Consumer<PlacesProvider>(
        builder: (context, provider, child) {
          if (provider.state == PlacesState.loading) {
            return const LoadingWidget(message: 'Loading places...');
          }

          if (provider.state == PlacesState.error) {
            return CustomErrorWidget(
              message: provider.errorMessage ?? 'Failed to load places',
              onRetry: _loadData,
            );
          }

          return ListView(
            children: [
              // Search Bar
              _buildSearchBar(context),

              // Category Header
              _buildSectionHeader(
                context,
                title: 'Category',
                onViewAll: () => _navigateToSearch(context),
              ),

              // Category Tabs
              CategoryTabsWidget(
                tabController: _tabController,
                places: provider.places,
              ),

              // Popular Destinations Header
              _buildSectionHeader(
                context,
                title: 'Popular Destination',
                onViewAll: () => _navigateToSearch(context),
              ),

              // Destinations List
              ...provider.destinations.map((destination) {
                return DestinationCard(destination: destination);
              }),

              // Footer
              _buildFooter(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(RouteConstants.search),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: const Color(0xfff4f6fd),
            border: Border.all(
              color: const Color.fromARGB(255, 173, 174, 177),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: AppColors.primary,
                size: 24.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Where do you want to go...',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    VoidCallback? onViewAll,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 36.h, left: 25.w, right: 25.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (onViewAll != null)
            InkWell(
              onTap: onViewAll,
              child: Text(
                'View all',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.secondary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: EdgeInsets.all(25.w),
      child: Center(
        child: Text(
          AppConstants.madeBy,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  void _navigateToSearch(BuildContext context) {
    Navigator.of(context).pushNamed(RouteConstants.search);
  }
}