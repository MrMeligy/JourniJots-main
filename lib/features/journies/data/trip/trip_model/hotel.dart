class Hotel {
  int? id;
  String? name;
  int? rating;
  int? ratingCount;

  Hotel({this.id, this.name, this.rating, this.ratingCount});

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        rating: json['rating'] as int?,
        ratingCount: json['ratingCount'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'rating': rating,
        'ratingCount': ratingCount,
      };
}
