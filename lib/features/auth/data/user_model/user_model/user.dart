class User {
  int? id;
  dynamic profilePicture;
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? userName;
  String? dateOfBirth;
  String? city;
  String? favFood;
  List<dynamic>? intersts;
  List<dynamic>? follow;
  List<dynamic>? followed;
  List<dynamic>? posts;
  List<dynamic>? likes;
  List<dynamic>? comments;
  List<dynamic>? trips;

  User({
    this.id,
    this.profilePicture,
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.userName,
    this.dateOfBirth,
    this.city,
    this.favFood,
    this.intersts,
    this.follow,
    this.followed,
    this.posts,
    this.likes,
    this.comments,
    this.trips,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int?,
        profilePicture: json['profilePicture'] as dynamic,
        email: json['email'] as String?,
        password: json['password'] as String?,
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        userName: json['userName'] as String?,
        dateOfBirth: json['dateOfBirth'] as String?,
        city: json['city'] as String?,
        favFood: json['favFood'] as String?,
        intersts: json['intersts'] as List<dynamic>?,
        follow: json['follow'] as List<dynamic>?,
        followed: json['followed'] as List<dynamic>?,
        posts: json['posts'] as List<dynamic>?,
        likes: json['likes'] as List<dynamic>?,
        comments: json['comments'] as List<dynamic>?,
        trips: json['trips'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'profilePicture': profilePicture,
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'userName': userName,
        'dateOfBirth': dateOfBirth,
        'city': city,
        'favFood': favFood,
        'intersts': intersts,
        'follow': follow,
        'followed': followed,
        'posts': posts,
        'likes': likes,
        'comments': comments,
        'trips': trips,
      };
}
