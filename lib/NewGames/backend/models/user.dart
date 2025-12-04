import 'dart:convert';

class User {
  int id;
  String name;
  String email;
  String phone;
  String password;
  String username;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.username,
  });

  // Factory method to create an instance from JSON
  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['Name'],
      email: json['Email'],
      phone: json['Phone'],
      password: json['Password'],
      username: json['Username'],
    );
  }

  // Method to convert an instance to JSON map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Name': name,
      'Email': email,
      'Phone': phone,
      'Password': password,
      'Username': username,
    };
  }

  // Method to parse a list of users from JSON string
  static List<User> getUserFromMap(String str) {
    return List<User>.from(json.decode(str).map((x) => User.fromMap(x)));
  }

  // Method to convert a list of User objects to JSON string
  static String getUserToMap(List<User> data) {
    return json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
  }
}
