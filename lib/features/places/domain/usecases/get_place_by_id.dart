import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/place_entity.dart';
import '../repositories/places_repository.dart';

class GetPlaceById {
  final PlacesRepository repository;

  GetPlaceById(this.repository);

  Future<Either<Failure, PlaceEntity>> call(String id) async {
    return await repository.getPlaceById(id);
  }
}