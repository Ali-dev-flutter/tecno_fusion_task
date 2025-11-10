class Location {
  final String city;
  final String country;

  Location({required this.city, required this.country});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      city: json['city'] as String,
      country: json['country'] as String,
    );
  }
}

class HomeScreenData {
  final String id;
  final String title;
  final Location location;
  final String projectType;
  final String buildingType;
  final String projectPrice;
  final int totalUnits;
  final String unitPrice;
  final List<String> coverImageUrls;
  final int unitsSold;
  final String status;

  HomeScreenData({
    required this.id,
    required this.title,
    required this.location,
    required this.projectType,
    required this.buildingType,
    required this.projectPrice,
    required this.totalUnits,
    required this.unitPrice,
    required this.coverImageUrls,
    required this.unitsSold,
    required this.status,
  });

  factory HomeScreenData.fromJson(Map<String, dynamic> json) {
    final unitsSold = json['unitsSold'] == null ? 0 : json['unitsSold'] as int;

    return HomeScreenData(
      id: json['_id'] as String,
      title: json['title'] as String,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      projectType: json['projectType'] as String,
      buildingType: json['buildingType'] as String,
      projectPrice: json['projectPrice'] as String,
      totalUnits: json['totalUnits'] as int,
      unitPrice: json['unitPrice'] as String,
      coverImageUrls: (json['coverImageUrls'] as List).cast<String>(),
      unitsSold: unitsSold,
      status: json['status'] as String,
    );
  }
}
