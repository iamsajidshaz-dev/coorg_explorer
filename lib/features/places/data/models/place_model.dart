import '../../domain/entities/place_entity.dart';

class PlaceModel extends PlaceEntity {
  const PlaceModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.mainImage,
    required super.imageOne,
    required super.imageTwo,
    required super.imageThree,
    required super.latitude,
    required super.longitude,
    required super.description,
    required super.category,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      mainImage: json['mainImage'] as String,
      imageOne: json['imageOne'] as String,
      imageTwo: json['imageTwo'] as String,
      imageThree: json['imageThree'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'mainImage': mainImage,
      'imageOne': imageOne,
      'imageTwo': imageTwo,
      'imageThree': imageThree,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
      'category': category,
    };
  }

  factory PlaceModel.fromEntity(PlaceEntity entity) {
    return PlaceModel(
      id: entity.id,
      title: entity.title,
      subtitle: entity.subtitle,
      mainImage: entity.mainImage,
      imageOne: entity.imageOne,
      imageTwo: entity.imageTwo,
      imageThree: entity.imageThree,
      latitude: entity.latitude,
      longitude: entity.longitude,
      description: entity.description,
      category: entity.category,
    );
  }
}