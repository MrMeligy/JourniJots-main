class Activity {
  int? id;
  String? name;
  int? rating;
  int? ratingCount;
  int? latitude;
  int? longitude;

  Activity({
    this.id,
    this.name,
    this.rating,
    this.ratingCount,
    this.latitude,
    this.longitude,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json['id'] as int?,
        name: json['name'] as String?,
        rating: json['rating'] as int?,
        ratingCount: json['ratingCount'] as int?,
        latitude: json['latitude'] as int?,
        longitude: json['longitude'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'rating': rating,
        'ratingCount': ratingCount,
        'latitude': latitude,
        'longitude': longitude,
      };
}
