import 'package:flutter/material.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/widgets/cached_image_widget.dart';

class GalleryItem extends StatelessWidget {
  final String image;
  final String imagePlace;

  const GalleryItem({
    super.key,
    required this.image,
    required this.imagePlace,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          RouteConstants.imageViewer,
          arguments: ImageViewerArguments(
            imageUrl: image,
            imageName: imagePlace,
            isNetworkImage: false,
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedImageWidget(
          imageUrl: image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}