import 'package:equatable/equatable.dart';

class PlaceEntity extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String mainImage;
  final String imageOne;
  final String imageTwo;
  final String imageThree;
  final String latitude;
  final String longitude;
  final String description;
  final String category;

  const PlaceEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.mainImage,
    required this.imageOne,
    required this.imageTwo,
    required this.imageThree,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.category,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        mainImage,
        imageOne,
        imageTwo,
        imageThree,
        latitude,
        longitude,
        description,
        category,
      ];
}
