import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/image_utils.dart';

class CachedImageWidget extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BorderRadius? borderRadius;
  
  const CachedImageWidget({
    super.key,
    required this.imageUrl,
    this.fit,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    // Check if it's a network image or asset
    final isNetworkImage = ImageUtils.isNetworkImage(imageUrl);
    final imagePath = ImageUtils.getImagePath(imageUrl);
    
    if (!isNetworkImage) {
      // Return asset image
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Image.asset(
          imagePath,
          fit: fit ?? BoxFit.cover,
          width: width,
          height: height,
          errorBuilder: (context, error, stackTrace) {
            return _buildErrorWidget();
          },
        ),
      );
    }
    
    // Return cached network image
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        imageUrl: imagePath,
        fit: fit ?? BoxFit.cover,
        width: width,
        height: height,
        placeholder: (context, url) {
          return placeholder ?? _buildPlaceholder();
        },
        errorWidget: (context, url, error) {
          return errorWidget ?? _buildErrorWidget();
        },
      ),
    );
  }
  
  Widget _buildPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: AppColors.grey200,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  
  Widget _buildErrorWidget() {
    return Container(
      width: width,
      height: height,
      color: AppColors.grey200,
      child: const Icon(
        Icons.broken_image,
        color: AppColors.grey500,
        size: 48,
      ),
    );
  }
}