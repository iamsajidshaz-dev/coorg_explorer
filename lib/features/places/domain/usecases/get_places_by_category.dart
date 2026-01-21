import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/place_entity.dart';
import '../repositories/places_repository.dart';

class GetPlacesByCategory {
  final PlacesRepository repository;

  GetPlacesByCategory(this.repository);

  Future<Either<Failure, List<PlaceEntity>>> call(String category) async {
    return await repository.getPlacesByCategory(category);
  }
}
