import 'package:flutter/material.dart';
import '../../domain/entities/place_entity.dart';
import '../../domain/usecases/search_places.dart';

enum SearchState { initial, loading, loaded, error, empty }

class SearchProvider extends ChangeNotifier {
  final SearchPlaces searchPlaces;

  SearchProvider({required this.searchPlaces});

  SearchState _state = SearchState.initial;
  List<PlaceEntity> _searchResults = [];
  String _query = '';
  String? _errorMessage;

  SearchState get state => _state;
  List<PlaceEntity> get searchResults => _searchResults;
  String get query => _query;
  String? get errorMessage => _errorMessage;

  /// Search for places
  Future<void> search(String query) async {
    _query = query;

    if (query.isEmpty) {
      _state = SearchState.initial;
      _searchResults = [];
      notifyListeners();
      return;
    }

    _state = SearchState.loading;
    notifyListeners();

    final result = await searchPlaces(query);

    result.fold(
      (failure) {
        _state = SearchState.error;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (places) {
        _searchResults = places;
        _state = places.isEmpty ? SearchState.empty : SearchState.loaded;
        notifyListeners();
      },
    );
  }

  /// Clear search
  void clearSearch() {
    _query = '';
    _searchResults = [];
    _state = SearchState.initial;
    notifyListeners();
  }
}