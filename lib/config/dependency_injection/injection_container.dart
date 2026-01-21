import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Auth
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/sign_in_with_google.dart';
import '../../features/auth/domain/usecases/sign_out.dart';
import '../../features/auth/domain/usecases/get_current_user.dart';
import '../../features/auth/domain/usecases/is_signed_in.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';

// Places
import '../../features/places/data/datasources/places_local_datasource.dart';
import '../../features/places/data/repositories/places_repository_impl.dart';
import '../../features/places/domain/repositories/places_repository.dart';
import '../../features/places/domain/usecases/get_all_places.dart';
import '../../features/places/domain/usecases/get_places_by_category.dart';
import '../../features/places/domain/usecases/search_places.dart';
import '../../features/places/domain/usecases/get_place_by_id.dart';
import '../../features/places/domain/usecases/get_all_destinations.dart';
import '../../features/places/domain/usecases/get_destination_by_id.dart';
import '../../features/places/presentation/providers/places_provider.dart';
import '../../features/places/presentation/providers/search_provider.dart';

class InjectionContainer {
  // Singleton instance
  static final InjectionContainer _instance = InjectionContainer._internal();
  factory InjectionContainer() => _instance;
  InjectionContainer._internal();

  // Storage
  late final SharedPreferences _sharedPreferences;
  late final FirebaseAuth _firebaseAuth;
  late final FirebaseFirestore _firestore;
  late final GoogleSignIn _googleSignIn;

  // Auth
  late final AuthRemoteDataSource _authRemoteDataSource;
  late final AuthRepository _authRepository;
  late final SignInWithGoogle _signInWithGoogle;
  late final SignOut _signOut;
  late final GetCurrentUser _getCurrentUser;
  late final IsSignedIn _isSignedIn;
  late final AuthProvider _authProvider;

  // Places
  late final PlacesLocalDataSource _placesLocalDataSource;
  late final PlacesRepository _placesRepository;
  late final GetAllPlaces _getAllPlaces;
  late final GetPlacesByCategory _getPlacesByCategory;
  late final SearchPlaces _searchPlaces;
  late final GetPlaceById _getPlaceById;
  late final GetAllDestinations _getAllDestinations;
  late final GetDestinationById _getDestinationById;
  late final PlacesProvider _placesProvider;
  late final SearchProvider _searchProvider;

  /// Initialize all dependencies
  Future<void> init() async {
    // External Dependencies
    _sharedPreferences = await SharedPreferences.getInstance();
    _firebaseAuth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
    _googleSignIn = GoogleSignIn(
      scopes: ['email', 'profile'],
    );

    // Features
    _initAuth();
    _initPlaces();
  }

  void _initAuth() {
    // Data sources
    _authRemoteDataSource = AuthRemoteDataSourceImpl(
      firebaseAuth: _firebaseAuth,
      googleSignIn: _googleSignIn,
      firestore: _firestore,
    );

    // Repository
    _authRepository = AuthRepositoryImpl(
      remoteDataSource: _authRemoteDataSource,
    );

    // Use cases
    _signInWithGoogle = SignInWithGoogle(_authRepository);
    _signOut = SignOut(_authRepository);
    _getCurrentUser = GetCurrentUser(_authRepository);
    _isSignedIn = IsSignedIn(_authRepository);

    // Provider
    _authProvider = AuthProvider(
      signInWithGoogle: _signInWithGoogle,
      signOut: _signOut,
      getCurrentUser: _getCurrentUser,
      isSignedIn: _isSignedIn,
    );
  }

  void _initPlaces() {
    // Data sources
    _placesLocalDataSource = PlacesLocalDataSourceImpl();

    // Repository
    _placesRepository = PlacesRepositoryImpl(
      localDataSource: _placesLocalDataSource,
    );

    // Use cases
    _getAllPlaces = GetAllPlaces(_placesRepository);
    _getPlacesByCategory = GetPlacesByCategory(_placesRepository);
    _searchPlaces = SearchPlaces(_placesRepository);
    _getPlaceById = GetPlaceById(_placesRepository);
    _getAllDestinations = GetAllDestinations(_placesRepository);
    _getDestinationById = GetDestinationById(_placesRepository);

    // Providers
    _placesProvider = PlacesProvider(
      getAllPlaces: _getAllPlaces,
      getPlacesByCategory: _getPlacesByCategory,
      getAllDestinations: _getAllDestinations,
    );

    _searchProvider = SearchProvider(
      searchPlaces: _searchPlaces,
    );
  }

  // Getters
  SharedPreferences get sharedPreferences => _sharedPreferences;
  FirebaseAuth get firebaseAuth => _firebaseAuth;
  FirebaseFirestore get firestore => _firestore;
  GoogleSignIn get googleSignIn => _googleSignIn;

  // Auth getters
  AuthProvider get authProvider => _authProvider;

  // Places getters
  PlacesProvider get placesProvider => _placesProvider;
  SearchProvider get searchProvider => _searchProvider;
}