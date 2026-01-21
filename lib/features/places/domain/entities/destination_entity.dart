import 'package:equatable/equatable.dart';

class DestinationEntity extends Equatable {
  final String id;
  final String title;
  final String image;
  final String latitude;
  final String longitude;
  final String description;

  const DestinationEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.latitude,
    required this.longitude,
    required this.description,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        image,
        latitude,
        longitude,
        description,
      ];
}