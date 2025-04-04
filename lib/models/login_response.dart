class LoginResponse {
  final String? status;
  final String? message;
  final Data? data;
  final dynamic errors;
  const LoginResponse({this.status, this.message, this.data, this.errors});
  LoginResponse copyWith(
      {String? status, String? message, Data? data, dynamic? errors}) {
    return LoginResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        errors: errors ?? this.errors);
  }

  Map<String, Object?> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
      'errors': errors
    };
  }

  static LoginResponse fromJson(Map<String, Object?> json) {
    return LoginResponse(
        status: json['status'] == null ? null : json['status'] as String,
        message: json['message'] == null ? null : json['message'] as String,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, Object?>),
        errors: json['errors'] as dynamic);
  }

  @override
  String toString() {
    return '''LoginResponse(
                status:$status,
message:$message,
data:${data.toString()},
errors:$errors
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is LoginResponse &&
        other.runtimeType == runtimeType &&
        other.status == status &&
        other.message == message &&
        other.data == data &&
        other.errors == errors;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, status, message, data, errors);
  }
}

class Data {
  final User? user;
  final String? token;
  const Data({this.user, this.token});
  Data copyWith({User? user, String? token}) {
    return Data(user: user ?? this.user, token: token ?? this.token);
  }

  Map<String, Object?> toJson() {
    return {'user': user?.toJson(), 'token': token};
  }

  static Data fromJson(Map<String, Object?> json) {
    return Data(
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, Object?>),
        token: json['token'] == null ? null : json['token'] as String);
  }

  @override
  String toString() {
    return '''Data(
                user:${user.toString()},
token:$token
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is Data &&
        other.runtimeType == runtimeType &&
        other.user == user &&
        other.token == token;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, user, token);
  }
}

class User {
  final int? id;
  final String? user;
  final String? phone;
  final String? address;
  final String? region;
  final dynamic image;
  final String? role;
  final String? status;
  final num? lat;
  final num? lon;
  final bool? isVerified;
  final String? createdAt;
  final String? updatedAt;
  const User(
      {this.id,
      this.user,
      this.phone,
      this.address,
      this.region,
      this.image,
      this.role,
      this.status,
      this.lat,
      this.lon,
      this.isVerified,
      this.createdAt,
      this.updatedAt});
  User copyWith(
      {int? id,
      String? user,
      String? phone,
      String? address,
      String? region,
      dynamic? image,
      String? role,
      String? status,
      double? lat,
      double? lon,
      bool? isVerified,
      String? createdAt,
      String? updatedAt}) {
    return User(
        id: id ?? this.id,
        user: user ?? this.user,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        region: region ?? this.region,
        image: image ?? this.image,
        role: role ?? this.role,
        status: status ?? this.status,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        isVerified: isVerified ?? this.isVerified,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'user': user,
      'phone': phone,
      'address': address,
      'region': region,
      'image': image,
      'role': role,
      'status': status,
      'lat': lat,
      'lon': lon,
      'is_verified': isVerified,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }

  static User fromJson(Map<String, Object?> json) {
    return User(
        id: json['id'] == null ? null : json['id'] as int,
        user: json['user'] == null ? null : json['user'] as String,
        phone: json['phone'] == null ? null : json['phone'] as String,
        address: json['address'] == null ? null : json['address'] as String,
        region: json['region'] == null ? null : json['region'] as String,
        image: json['image'] as dynamic,
        role: json['role'] == null ? null : json['role'] as String,
        status: json['status'] == null ? null : json['status'] as String,
        lat: json['lat'] == null ? null : json['lat'] as num,
        lon: json['lon'] == null ? null : json['lon'] as num,
        isVerified:
            json['is_verified'] == null ? null : json['is_verified'] as bool,
        createdAt:
            json['createdAt'] == null ? null : json['createdAt'] as String,
        updatedAt:
            json['updatedAt'] == null ? null : json['updatedAt'] as String);
  }

  @override
  String toString() {
    return '''User(
                id:$id,
user:$user,
phone:$phone,
address:$address,
region:$region,
image:$image,
role:$role,
status:$status,
lat:$lat,
lon:$lon,
isVerified:$isVerified,
createdAt:$createdAt,
updatedAt:$updatedAt
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is User &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.user == user &&
        other.phone == phone &&
        other.address == address &&
        other.region == region &&
        other.image == image &&
        other.role == role &&
        other.status == status &&
        other.lat == lat &&
        other.lon == lon &&
        other.isVerified == isVerified &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id, user, phone, address, region, image,
        role, status, lat, lon, isVerified, createdAt, updatedAt);
  }
}
