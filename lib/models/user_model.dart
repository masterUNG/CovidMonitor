import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String gender;
  final String address;
  final String phone;
  final String user;
  final String password;
  UserModel({
    this.id,
    this.name,
    this.gender,
    this.address,
    this.phone,
    this.user,
    this.password,
  });

  UserModel copyWith({
    String id,
    String name,
    String gender,
    String address,
    String phone,
    String user,
    String password,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      user: user ?? this.user,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'address': address,
      'phone': phone,
      'user': user,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      gender: map['gender'],
      address: map['address'],
      phone: map['phone'],
      user: map['user'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, gender: $gender, address: $address, phone: $phone, user: $user, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.id == id &&
      other.name == name &&
      other.gender == gender &&
      other.address == address &&
      other.phone == phone &&
      other.user == user &&
      other.password == password;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      gender.hashCode ^
      address.hashCode ^
      phone.hashCode ^
      user.hashCode ^
      password.hashCode;
  }
}
