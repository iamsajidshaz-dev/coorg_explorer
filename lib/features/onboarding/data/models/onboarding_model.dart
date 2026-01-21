import '../../domain/entities/onboarding_entity.dart';

class OnboardingModel extends OnboardingEntity {
  const OnboardingModel({
    required super.title,
    required super.description,
    required super.image,
    required super.bgColor,
  });

  factory OnboardingModel.fromJson(Map<String, dynamic> json) {
    return OnboardingModel(
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      bgColor: json['bgColor'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'image': image,
      'bgColor': bgColor,
    };
  }
}