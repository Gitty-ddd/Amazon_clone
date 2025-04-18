import 'dart:convert';

class User {
  final String id;
  final String email;
  final String name;
  final String password;
  final String address;
  final String type;
  final String stamp;
  List<dynamic> cart;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.password,
    required this.address,
    required this.type,
    required this.stamp,
    required this.cart,
  });

  Map<String, dynamic> fromAppToDB() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'password': password,
      'address': address,
      'type': type,
      'stamp': stamp,
      'cart': cart,
    };
  }

  String toJson() => json.encode(fromAppToDB());
  factory User.fromDBtoApp(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      stamp: map['stamp'] ?? '',
      cart: List<Map<String, dynamic>>.from(
        map['cart'].map((x) => Map<String, dynamic>.from(x)),
      ),
    );
  }

  factory User.fromJson(String source) => User.fromDBtoApp(jsonDecode(source));

  User copyWith({
    String? id,
    String? email,
    String? password,
    String? name,
    String? address,
    String? type,
    String? stamp,
    List<dynamic>? cart,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
      password: password ?? this.password,
      address: address ?? this.address,
      type: address ?? this.type,
      stamp: stamp ?? this.stamp,
      cart: cart ?? this.cart,
    );
  }
}
