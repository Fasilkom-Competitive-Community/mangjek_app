class User {
  late String id;
  late String name;
  late String email;
  late String phoneNumber;
  late String nim;
  late DateTime createdAt;
  late DateTime updatedAt;

  User.fromJson(dynamic data) {
    id = data['id'];
    name = data['name'];
    email = data['email'];
    phoneNumber = data['phone_number'];
    nim = data['nim'];
    createdAt = DateTime.parse(data['created_at']);
    updatedAt = DateTime.parse(data['updated_at']);
  }

  toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "nim": nim,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class UserResponse {
  late User user;

  UserResponse.fromJson(dynamic data) {
    user = User.fromJson(data['data']);
  }

  toJson() => {
        "data": user.toJson(),
      };
}
