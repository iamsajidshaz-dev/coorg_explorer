import '../../../../core/constants/asset_constants.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/place_model.dart';
import '../models/destination_model.dart';

abstract class PlacesLocalDataSource {
  Future<List<PlaceModel>> getAllPlaces();
  Future<List<PlaceModel>> getPlacesByCategory(String category);
  Future<List<PlaceModel>> searchPlaces(String query);
  Future<PlaceModel> getPlaceById(String id);
  Future<List<DestinationModel>> getAllDestinations();
  Future<DestinationModel> getDestinationById(String id);
}

class PlacesLocalDataSourceImpl implements PlacesLocalDataSource {
  // All places data
  static final List<PlaceModel> _allPlaces = [
    const PlaceModel(
      id: 'place_1',
      title: 'Raja Seat',
      subtitle: 'Madikeri',
      mainImage: AssetConstants.rajasSeat,
      imageOne: AssetConstants.rajasSeat1,
      imageTwo: AssetConstants.rajasSeat2,
      imageThree: AssetConstants.rajasSeat3,
      latitude: '12.41480835424861',
      longitude: '75.73711209697447',
      description:
          "One of the popular tourist spots, Raja seat literally means \"Seat of the Kings\". Located in the town of Madikeri, it is a beautiful place presenting a refreshing setting and soothing environment.\n\nThe place is called as Raja's Seat because it was the place where Coorg's kings used to visit and enjoy the scenic beauty around. The sunset and sunrise make for a mesmerising view which is worth captivating in your cameras.\n\nIt is the perfect setting to relax and admire the breathtaking view of the surrounding areas. Lush greenery with a calm environment and golden streams of sunlight makes for a picture perfect setting.",
      category: AppConstants.categoryViewpoint,
    ),
    const PlaceModel(
      id: 'place_2',
      title: 'Abbey Falls',
      subtitle: 'Madikeri',
      mainImage: AssetConstants.abbeyFalls,
      imageOne: AssetConstants.abbeyFalls,
      imageTwo: AssetConstants.abbeyFalls,
      imageThree: AssetConstants.abbeyFalls,
      latitude: '12.458413130905688',
      longitude: '75.71952492319419',
      description:
          "Abbey Falls (also referred to as Abbi Falls) is a popular waterfall in Kodagu district. River Kaveri drops for about 70 ft over wide rocks creating a spectacular view.",
      category: AppConstants.categoryWaterfall,
    ),
    const PlaceModel(
      id: 'place_3',
      title: 'Madikeri Fort',
      subtitle: 'Madikeri',
      mainImage: AssetConstants.madikeriFort,
      imageOne: AssetConstants.madikeriFort1,
      imageTwo: AssetConstants.madikeriFort2,
      imageThree: AssetConstants.madikeriFort3,
      latitude: '12.421236986559824',
      longitude: '75.73871630970048',
      description:
          "Situated about 500m from the Madikeri bus stand, the imposing fort was built by Mudduraja in 1681.",
      category: AppConstants.categoryViewpoint,
    ),
    const PlaceModel(
      id: 'place_4',
      title: 'Mallalli Falls',
      subtitle: 'Somwarpete',
      mainImage: AssetConstants.mallalliFalls,
      imageOne: AssetConstants.mallalliFalls,
      imageTwo: AssetConstants.mallalliFalls,
      imageThree: AssetConstants.mallalliFalls,
      latitude: '12.680904666142025',
      longitude: '75.72365626552671',
      description:
          "Located in the Pushpagiri Hills, Mallali Falls is one of the most beautiful falls in Coorg.",
      category: AppConstants.categoryWaterfall,
    ),
    const PlaceModel(
      id: 'place_5',
      title: 'Golden Temple',
      subtitle: 'Kushalnagara',
      mainImage: AssetConstants.goldenTemple,
      imageOne: AssetConstants.goldenTemple,
      imageTwo: AssetConstants.goldenTemple,
      imageThree: AssetConstants.goldenTemple,
      latitude: '12.430267934693957',
      longitude: '75.96771875202938',
      description:
          "The Namdroling Monastery, popularly referred to as 'The Golden Temple' is one of the largest Tibetan settlements in India.",
      category: AppConstants.categoryTemple,
    ),
    const PlaceModel(
      id: 'place_6',
      title: 'Harangi Dam',
      subtitle: 'Kushalnagara',
      mainImage: AssetConstants.harangiDam,
      imageOne: AssetConstants.harangiDam,
      imageTwo: AssetConstants.harangiDam,
      imageThree: AssetConstants.harangiDam,
      latitude: '12.491918384243752',
      longitude: '75.90555599435915',
      description:
          "Located near Kushalnagar, Harangi dam is a popular picnic spot with mesmerising natural setting.",
      category: AppConstants.categoryDam,
    ),
    const PlaceModel(
      id: 'place_7',
      title: 'Mandalpatti Peak',
      subtitle: 'Madikeri',
      mainImage: AssetConstants.mandalpatti,
      imageOne: AssetConstants.mandalpatti1,
      imageTwo: AssetConstants.mandalpatti2,
      imageThree: AssetConstants.mandalpatti3,
      latitude: '12.545597032138263',
      longitude: '75.70113696815378',
      description:
          "A lush green mesmerising place, Mandalpatti offers seclusion and is perfect for trekking.",
      category: AppConstants.categoryViewpoint,
    ),
    const PlaceModel(
      id: 'place_8',
      title: 'Harangi Backwater',
      subtitle: 'Kushalnagara',
      mainImage: AssetConstants.backwater,
      imageOne: AssetConstants.backwater,
      imageTwo: AssetConstants.backwater,
      imageThree: AssetConstants.backwater,
      latitude: '12.496091654928701',
      longitude: '75.8594259600121',
      description: "Perfect place for disconnecting and destressing.",
      category: AppConstants.categoryDam,
    ),
    const PlaceModel(
      id: 'place_9',
      title: 'Irpu Falls',
      subtitle: 'Madikeri',
      mainImage: AssetConstants.irpu,
      imageOne: AssetConstants.irpu,
      imageTwo: AssetConstants.irpu,
      imageThree: AssetConstants.irpu,
      latitude: '11.966302006557543',
      longitude: '75.98336138085732',
      description:
          "Located in the Brahmagiri Range, Irupu Falls is a major tourist attraction and pilgrimage spot.",
      category: AppConstants.categoryWaterfall,
    ),
    const PlaceModel(
      id: 'place_10',
      title: 'Kotebetta Peak',
      subtitle: 'Madapura',
      mainImage: AssetConstants.kotebetta,
      imageOne: AssetConstants.kotebetta1,
      imageTwo: AssetConstants.kotebetta2,
      imageThree: AssetConstants.kotebetta3,
      latitude: '12.543998733466546',
      longitude: '75.75393662319561',
      description:
          "One of the highest peaks with an elevation of 1620 meters, perfect for trekking.",
      category: AppConstants.categoryViewpoint,
    ),
    const PlaceModel(
      id: 'place_11',
      title: "Raja's Tomb",
      subtitle: 'Madikeri',
      mainImage: AssetConstants.rajasTomb,
      imageOne: AssetConstants.rajasTomb1,
      imageTwo: AssetConstants.rajasTomb2,
      imageThree: AssetConstants.rajasTomb3,
      latitude: '12.433563709247595',
      longitude: '75.73999315202948',
      description:
          "Gaddige, also known as Raja's tomb, depicts Indo-Sarcenic building style.",
      category: AppConstants.categoryViewpoint,
    ),
    const PlaceModel(
      id: 'place_12',
      title: 'Talakaveri',
      subtitle: 'Bhagamandala',
      mainImage: AssetConstants.talakaveri,
      imageOne: AssetConstants.talakaveri,
      imageTwo: AssetConstants.talakaveri,
      imageThree: AssetConstants.talakaveri,
      latitude: '12.385534533294727',
      longitude: '75.49092186552163',
      description:
          "The birthplace of River Cauvery, a holy pilgrimage for many Hindus.",
      category: AppConstants.categoryTemple,
    ),
    const PlaceModel(
      id: 'place_13',
      title: 'Kotte Abbi Falls',
      subtitle: 'Madikeri',
      mainImage: AssetConstants.kotteAbbiFalls,
      imageOne: AssetConstants.kotteAbbiFalls,
      imageTwo: AssetConstants.kotteAbbiFalls,
      imageThree: AssetConstants.kotteAbbiFalls,
      latitude: '12.52298094809942',
      longitude: '75.73951230293738',
      description: "A hidden waterfall among the best Coorg tourist places.",
      category: AppConstants.categoryWaterfall,
    ),
    const PlaceModel(
      id: 'place_14',
      title: 'Dubare Elephant Camp',
      subtitle: 'Kushalnagara',
      mainImage: AssetConstants.dubare,
      imageOne: AssetConstants.dubare1,
      imageTwo: AssetConstants.dubare2,
      imageThree: AssetConstants.dubare3,
      latitude: '12.37134918355973',
      longitude: '75.90510896552145',
      description:
          "A forest camp on the banks of river Kaveri, home to elephant training.",
      category: AppConstants.categoryViewpoint,
    ),
    const PlaceModel(
      id: 'place_15',
      title: 'Kaveri Nisargadhama',
      subtitle: 'Kushalnagara',
      mainImage: AssetConstants.nisargadhama,
      imageOne: AssetConstants.nisargadhama1,
      imageTwo: AssetConstants.nisargadhama2,
      imageThree: AssetConstants.nisargadhama3,
      latitude: '12.447139187519078',
      longitude: '75.93697656814251',
      description:
          "A beautiful forest resort on an island formed by River Kaveri.",
      category: AppConstants.categoryViewpoint,
    ),
    const PlaceModel(
      id: 'place_16',
      title: 'Omkareshwara Temple',
      subtitle: 'Madikeri',
      mainImage: AssetConstants.omkareshwaraTemple,
      imageOne: AssetConstants.omkareshwaraTemple,
      imageTwo: AssetConstants.omkareshwaraTemple,
      imageThree: AssetConstants.omkareshwaraTemple,
      latitude: '12.420697873279707',
      longitude: '75.74277136628',
      description:
          "An ancient shrine dedicated to Lord Shiva with Gothic and Islamic architectural styles.",
      category: AppConstants.categoryTemple,
    ),
    const PlaceModel(
      id: 'place_17',
      title: 'Chiklihole Dam',
      subtitle: 'Suntikoppa',
      mainImage: AssetConstants.chiklihole,
      imageOne: AssetConstants.chiklihole,
      imageTwo: AssetConstants.chiklihole,
      imageThree: AssetConstants.chiklihole,
      latitude: '12.396507749941751',
      longitude: '75.8787042546437',
      description: "A popular place to visit between Madikeri and Kushalnagar.",
      category: AppConstants.categoryDam,
    ),
  ];

  // All destinations data
  static final List<DestinationModel> _allDestinations = [
    const DestinationModel(
      id: 'dest_1',
      title: 'Madikeri',
      image: AssetConstants.madikeriTown,
      latitude: '12.4246378988192',
      longitude: '75.73856026347143',
      description:
          "Madikeri is a hill town in southern India. Framed by the Western Ghats mountain range, it's known for the Raja's Seat, a simple monument overlooking forests and rice paddies.",
    ),
    const DestinationModel(
      id: 'dest_2',
      title: 'Virajpete',
      image: AssetConstants.virajpeteTown,
      latitude: '12.19415979981644',
      longitude: '75.80488485512974',
      description:
          "The town of Virajpet is in the Kodagu district, south of the district, and borders Kerala State.",
    ),
    const DestinationModel(
      id: 'dest_3',
      title: 'Kushalnagara',
      image: AssetConstants.kushalnagarTown,
      latitude: '12.456355359397477',
      longitude: '75.95719497223382',
      description:
          "Kushalnagar is a town on the Kaveri River, known for the Buddhist Namdroling Monastery.",
    ),
    const DestinationModel(
      id: 'dest_4',
      title: 'Somwarpete',
      image: AssetConstants.somwarpeteTown,
      latitude: '12.594491002802148',
      longitude: '75.85046757530343',
      description:
          "Somwarpet is the main town of Somwarpet taluk, 2nd highest administrative town in Karnataka.",
    ),
  ];

  @override
  Future<List<PlaceModel>> getAllPlaces() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      return _allPlaces;
    } catch (e) {
      throw CacheException('Failed to get places: $e');
    }
  }

  @override
  Future<List<PlaceModel>> getPlacesByCategory(String category) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      return _allPlaces.where((place) => place.category == category).toList();
    } catch (e) {
      throw CacheException('Failed to get places by category: $e');
    }
  }

  @override
  Future<List<PlaceModel>> searchPlaces(String query) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final lowerQuery = query.toLowerCase();
      return _allPlaces
          .where((place) =>
              place.title.toLowerCase().contains(lowerQuery) ||
              place.subtitle.toLowerCase().contains(lowerQuery))
          .toList();
    } catch (e) {
      throw CacheException('Failed to search places: $e');
    }
  }

  @override
  Future<PlaceModel> getPlaceById(String id) async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      return _allPlaces.firstWhere((place) => place.id == id);
    } catch (e) {
      throw NotFoundException('Place not found with id: $id');
    }
  }

  @override
  Future<List<DestinationModel>> getAllDestinations() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      return _allDestinations;
    } catch (e) {
      throw CacheException('Failed to get destinations: $e');
    }
  }

  @override
  Future<DestinationModel> getDestinationById(String id) async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      return _allDestinations.firstWhere((dest) => dest.id == id);
    } catch (e) {
      throw NotFoundException('Destination not found with id: $id');
    }
  }
}
