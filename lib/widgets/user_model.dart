class UserModel {
  String? status;
  String? message;
  Data? data;
  String? errors;

  UserModel({this.status, this.message, this.data, this.errors});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['errors'] = this.errors;
    return data;
  }
}

class Data {
  bool? isVerified;
  int? id;
  String? user;
  String? phone;
  String? image;
  String? address;
  String? updatedAt;
  String? createdAt;

  Data(
      {this.isVerified,
      this.id,
      this.image,
      this.user,
      this.phone,
      this.address,
      this.updatedAt,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    isVerified = json['is_verified'];
    id = json['id'];
    user = json['user'];
    phone = json['phone'];
    image = json['image'];
    address = json['address'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_verified'] = this.isVerified;
    data['id'] = this.id;
    data['user'] = this.user;
    data['image'] = this.image;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
