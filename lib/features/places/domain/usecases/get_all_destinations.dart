import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/destination_entity.dart';
import '../repositories/places_repository.dart';

class GetAllDestinations {
  final PlacesRepository repository;

  GetAllDestinations(this.repository);

  Future<Either<Failure, List<DestinationEntity>>> call() async {
    return await repository.getAllDestinations();
  }
}