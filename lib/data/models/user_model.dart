class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String mobile;
  final String photo;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.photo,
  });

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      id: data['_id'],
      email: data['email'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      mobile: data['mobile'],
      photo: data['photo'],
    );
  }
  static Map<String, dynamic> toJson(UserModel model) {
    return {
      '_id': model.id,
      "email": model.email,
      "firstName": model.firstName,
      "lastName": model.lastName,
      "mobile": model.mobile,
      "photo": model.photo,
    };
  }
}

  // _id":"68d1374eb4f34e7d4b4293e0","email":"tt@tt.tt","firstName":"ttt","lastName":"trrrr","mobile":"12121212","createdDate":"2025-07-16T06:07:55.534Z"},"token":"eyJhbGciOi