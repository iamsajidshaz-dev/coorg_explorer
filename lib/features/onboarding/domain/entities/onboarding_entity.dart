import 'package:equatable/equatable.dart';

class OnboardingEntity extends Equatable {
  final String title;
  final String description;
  final String image;
  final int bgColor;

  const OnboardingEntity({
    required this.title,
    required this.description,
    required this.image,
    required this.bgColor,
  });

  @override
  List<Object?> get props => [title, description, image, bgColor];
}