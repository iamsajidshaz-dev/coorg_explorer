import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/place_entity.dart';
import '../entities/destination_entity.dart';

abstract class PlacesRepository {
  /// Get all places
  Future<Either<Failure, List<PlaceEntity>>> getAllPlaces();

  /// Get places by category
  Future<Either<Failure, List<PlaceEntity>>> getPlacesByCategory(String category);

  /// Search places
  Future<Either<Failure, List<PlaceEntity>>> searchPlaces(String query);

  /// Get place by id
  Future<Either<Failure, PlaceEntity>> getPlaceById(String id);

  /// Get all destinations
  Future<Either<Failure, List<DestinationEntity>>> getAllDestinations();

  /// Get destination by id
  Future<Either<Failure, DestinationEntity>> getDestinationById(String id);
}