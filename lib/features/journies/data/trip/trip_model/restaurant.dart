class Restaurant {
  int? id;
  String? name;
  String? category;
  int? rating;
  int? ratingCount;

  Restaurant({
    this.id,
    this.name,
    this.category,
    this.rating,
    this.ratingCount,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json['id'] as int?,
        name: json['name'] as String?,
        category: json['category'] as String?,
        rating: json['rating'] as int?,
        ratingCount: json['ratingCount'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'rating': rating,
        'ratingCount': ratingCount,
      };
}
