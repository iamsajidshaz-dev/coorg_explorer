import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import '../../../../config/routes/app_routes.dart';

class ImageViewerPage extends StatelessWidget {
  final ImageViewerArguments arguments;

  const ImageViewerPage({
    super.key,
    required this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          arguments.imageName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: arguments.isNetworkImage
          ? PhotoView(
              imageProvider: NetworkImage(arguments.imageUrl),
              backgroundDecoration: const BoxDecoration(
                color: Colors.black,
              ),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
            )
          : PhotoView(
              imageProvider: AssetImage(arguments.imageUrl),
              backgroundDecoration: const BoxDecoration(
                color: Colors.black,
              ),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
            ),
    );
  }
}