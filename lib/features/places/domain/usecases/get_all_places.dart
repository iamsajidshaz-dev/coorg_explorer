import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/place_entity.dart';
import '../repositories/places_repository.dart';

class GetAllPlaces {
  final PlacesRepository repository;

  GetAllPlaces(this.repository);

  Future<Either<Failure, List<PlaceEntity>>> call() async {
    return await repository.getAllPlaces();
  }
}