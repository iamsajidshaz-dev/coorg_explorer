import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/destination_entity.dart';
import '../repositories/places_repository.dart';

class GetDestinationById {
  final PlacesRepository repository;

  GetDestinationById(this.repository);

  Future<Either<Failure, DestinationEntity>> call(String id) async {
    return await repository.getDestinationById(id);
  }
}