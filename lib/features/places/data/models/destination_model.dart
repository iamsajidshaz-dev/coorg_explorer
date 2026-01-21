import '../../domain/entities/destination_entity.dart';

class DestinationModel extends DestinationEntity {
  const DestinationModel({
    required super.id,
    required super.title,
    required super.image,
    required super.latitude,
    required super.longitude,
    required super.description,
  });

  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      image: json['image'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
    };
  }

  factory DestinationModel.fromEntity(DestinationEntity entity) {
    return DestinationModel(
      id: entity.id,
      title: entity.title,
      image: entity.image,
      latitude: entity.latitude,
      longitude: entity.longitude,
      description: entity.description,
    );
  }
}