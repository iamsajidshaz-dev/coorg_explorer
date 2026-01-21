import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/cached_image_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/empty_widget.dart';
import '../providers/search_provider.dart';
import '../providers/places_provider.dart';
import '../../domain/entities/place_entity.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'EXPLORE COORG',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
      ),
      body: Column(
        children: [
          // Search Bar
          _buildSearchBar(),

          // Results
          Expanded(
            child: Consumer<SearchProvider>(
              builder: (context, searchProvider, child) {
                // Initial state - show all places
                if (searchProvider.state == SearchState.initial) {
                  return _buildAllPlacesList();
                }

                // Loading state
                if (searchProvider.state == SearchState.loading) {
                  return const LoadingWidget(message: 'Searching...');
                }

                // Empty state
                if (searchProvider.state == SearchState.empty) {
                  return EmptyWidget(
                    message: 'No places found for "${searchProvider.query}"',
                    icon: Icons.search_off,
                  );
                }

                // Error state
                if (searchProvider.state == SearchState.error) {
                  return EmptyWidget(
                    message: searchProvider.errorMessage ?? 'Search failed',
                    icon: Icons.error_outline,
                  );
                }

                // Results state
                return _buildSearchResults(searchProvider.searchResults);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            size: 24.sp,
            color: AppColors.primary,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    size: 20.sp,
                  ),
                  onPressed: () {
                    _searchController.clear();
                    context.read<SearchProvider>().clearSearch();
                  },
                )
              : null,
          hintText: 'Where do you want to go...',
          hintStyle: TextStyle(fontSize: 14.sp),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
        onChanged: (query) {
          setState(() {}); // Update suffix icon
          context.read<SearchProvider>().search(query);
        },
      ),
    );
  }

  Widget _buildAllPlacesList() {
    return Consumer<PlacesProvider>(
      builder: (context, placesProvider, child) {
        final places = placesProvider.places;

        if (places.isEmpty) {
          return const EmptyWidget(
            message: 'No places available',
            icon: Icons.place_outlined,
          );
        }

        return ListView.builder(
          itemCount: places.length,
          itemBuilder: (context, index) {
            return _buildPlaceListItem(places[index]);
          },
        );
      },
    );
  }

  Widget _buildSearchResults(List<PlaceEntity> results) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return _buildPlaceListItem(results[index]);
      },
    );
  }

  Widget _buildPlaceListItem(PlaceEntity place) {
    return GestureDetector(
      onTap: () => _navigateToDetail(place),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        height: 100.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.white,
          border: Border.all(
            color: AppColors.border,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black12,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                bottomLeft: Radius.circular(12.r),
              ),
              child: CachedImageWidget(
                imageUrl: place.mainImage,
                width: 120.w,
                height: 100.h,
                fit: BoxFit.cover,
              ),
            ),

            // Info
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      place.subtitle,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(place.category),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        _getCategoryLabel(place.category),
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Arrow
            Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: AppColors.grey400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'viewpoint':
        return AppColors.categoryViewpoint;
      case 'waterfall':
        return AppColors.categoryWaterfall;
      case 'temple':
        return AppColors.categoryTemple;
      case 'dam':
        return AppColors.categoryDam;
      default:
        return AppColors.grey500;
    }
  }

  String _getCategoryLabel(String category) {
    switch (category) {
      case 'viewpoint':
        return 'Viewpoint';
      case 'waterfall':
        return 'Waterfall';
      case 'temple':
        return 'Temple';
      case 'dam':
        return 'River/Dam';
      default:
        return category;
    }
  }

  void _navigateToDetail(PlaceEntity place) {
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