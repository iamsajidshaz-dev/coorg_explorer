import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/place_entity.dart';
import '../../domain/entities/destination_entity.dart';
import '../../domain/repositories/places_repository.dart';
import '../datasources/places_local_datasource.dart';

class PlacesRepositoryImpl implements PlacesRepository {
  final PlacesLocalDataSource localDataSource;

  PlacesRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<PlaceEntity>>> getAllPlaces() async {
    try {
      final places = await localDataSource.getAllPlaces();
      return Right(places);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to get places: $e'));
    }
  }

  @override
  Future<Either<Failure, List<PlaceEntity>>> getPlacesByCategory(
      String category) async {
    try {
      final places = await localDataSource.getPlacesByCategory(category);
      return Right(places);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to get places by category: $e'));
    }
  }

  @override
  Future<Either<Failure, List<PlaceEntity>>> searchPlaces(String query) async {
    try {
      final places = await localDataSource.searchPlaces(query);
      return Right(places);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to search places: $e'));
    }
  }

  @override
  Future<Either<Failure, PlaceEntity>> getPlaceById(String id) async {
    try {
      final place = await localDataSource.getPlaceById(id);
      return Right(place);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to get place: $e'));
    }
  }

  @override
  Future<Either<Failure, List<DestinationEntity>>> getAllDestinations() async {
    try {
      final destinations = await localDataSource.getAllDestinations();
      return Right(destinations);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to get destinations: $e'));
    }
  }

  @override
  Future<Either<Failure, DestinationEntity>> getDestinationById(
      String id) async {
    try {
      final destination = await localDataSource.getDestinationById(id);
      return Right(destination);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to get destination: $e'));
    }
  }
}