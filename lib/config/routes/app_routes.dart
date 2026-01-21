import 'package:coorgtheexplorer/features/places/presentation/pages/about_page.dart';
import 'package:coorgtheexplorer/features/places/presentation/pages/destination_detail_page.dart';
import 'package:coorgtheexplorer/features/places/presentation/pages/gallery_page.dart';
import 'package:coorgtheexplorer/features/places/presentation/pages/home_page.dart';
import 'package:coorgtheexplorer/features/places/presentation/pages/image_viewer_page.dart';
import 'package:coorgtheexplorer/features/places/presentation/pages/place_detail_page.dart';
import 'package:coorgtheexplorer/features/places/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import '../../core/constants/route_constants.dart';
import '../../features/onboarding/presentation/pages/splash_screen.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';


class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );

      case RouteConstants.onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingPage(),
          settings: settings,
        );

      case RouteConstants.login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );

      case RouteConstants.home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );

      case RouteConstants.search:
        return MaterialPageRoute(
          builder: (_) => const SearchPage(),
          settings: settings,
        );

      case RouteConstants.placeDetail:
        final args = settings.arguments as PlaceDetailArguments;
        return MaterialPageRoute(
          builder: (_) => PlaceDetailPage(arguments: args),
          settings: settings,
        );

      case RouteConstants.destinationDetail:
        final args = settings.arguments as DestinationDetailArguments;
        return MaterialPageRoute(
          builder: (_) => DestinationDetailPage(arguments: args),
          settings: settings,
        );

      case RouteConstants.gallery:
        return MaterialPageRoute(
          builder: (_) => const GalleryPage(),
          settings: settings,
        );

      case RouteConstants.imageViewer:
        final args = settings.arguments as ImageViewerArguments;
        return MaterialPageRoute(
          builder: (_) => ImageViewerPage(arguments: args),
          settings: settings,
        );

      case RouteConstants.about:
        return MaterialPageRoute(
          builder: (_) => const AboutPage(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

// Route Arguments Classes
class PlaceDetailArguments {
  final String placeId;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String imageOne;
  final String imageTwo;
  final String imageThree;
  final String description;
  final String latitude;
  final String longitude;
  final String category;

  PlaceDetailArguments({
    required this.placeId,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.imageOne,
    required this.imageTwo,
    required this.imageThree,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.category,
  });
}

class DestinationDetailArguments {
  final String title;
  final String imageUrl;
  final String description;
  final String latitude;
  final String longitude;

  DestinationDetailArguments({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.latitude,
    required this.longitude,
  });
}

class ImageViewerArguments {
  final String imageUrl;
  final String imageName;
  final bool isNetworkImage;

  ImageViewerArguments({
    required this.imageUrl,
    required this.imageName,
    this.isNetworkImage = false,
  });
}
