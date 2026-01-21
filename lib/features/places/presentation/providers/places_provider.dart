import 'package:flutter/material.dart';
import '../../domain/entities/place_entity.dart';
import '../../domain/entities/destination_entity.dart';
import '../../domain/usecases/get_all_places.dart';
import '../../domain/usecases/get_places_by_category.dart';
import '../../domain/usecases/get_all_destinations.dart';

enum PlacesState { initial, loading, loaded, error }

class PlacesProvider extends ChangeNotifier {
  final GetAllPlaces getAllPlaces;
  final GetPlacesByCategory getPlacesByCategory;
  final GetAllDestinations getAllDestinations;

  PlacesProvider({
    required this.getAllPlaces,
    required this.getPlacesByCategory,
    required this.getAllDestinations,
  });

  PlacesState _state = PlacesState.initial;
  List<PlaceEntity> _places = [];
  List<DestinationEntity> _destinations = [];
  String? _errorMessage;

  PlacesState get state => _state;
  List<PlaceEntity> get places => _places;
  List<DestinationEntity> get destinations => _destinations;
  String? get errorMessage => _errorMessage;

  /// Load all places
  Future<void> loadPlaces() async {
    _state = PlacesState.loading;
    notifyListeners();

    final result = await getAllPlaces();

    result.fold(
      (failure) {
        _state = PlacesState.error;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (places) {
        _places = places;
        _state = PlacesState.loaded;
        notifyListeners();
      },
    );
  }

  /// Load all destinations
  Future<void> loadDestinations() async {
    final result = await getAllDestinations();

    result.fold(
      (failure) {
        _errorMessage = failure.message;
      },
      (destinations) {
        _destinations = destinations;
        notifyListeners();
      },
    );
  }

  /// Get places by category
  List<PlaceEntity> getPlacesByCategorySync(String category) {
    return _places.where((place) => place.category == category).toList();
  }

  /// Load both places and destinations
  Future<void> loadAll() async {
    await Future.wait([
      loadPlaces(),
      loadDestinations(),
    ]);
  }
}