class OrderResponseModel {
  final String status;
  final String message;
  final OrderData? data;
  final dynamic errors;

  OrderResponseModel({
    required this.status,
    required this.message,
    this.data,
    this.errors,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderResponseModel(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null ? OrderData.fromJson(json['data']) : null,
      errors: json['errors'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
      'errors': errors,
    };
  }
}

class OrderData {
  final int id;
  final int userId;
  final String status;
  final double total;
  final double totalAfterDiscount;
  final double lat;
  final double lon;
  final String region;
  final String createdAt;
  final String updatedAt;
  final int deliveryId;
  final int vendorId;

  OrderData({
    required this.id,
    required this.userId,
    required this.status,
    required this.total,
    required this.totalAfterDiscount,
    required this.lat,
    required this.lon,
    required this.region,
    required this.createdAt,
    required this.updatedAt,
    required this.deliveryId,
    required this.vendorId,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      status: json['status'] ?? '',
      total: (json['total'] ?? 0).toDouble(),
      totalAfterDiscount: (json['total_after_discount'] ?? 0).toDouble(),
      lat: (json['lat'] ?? 0).toDouble(),
      lon: (json['lon'] ?? 0).toDouble(),
      region: json['region'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      deliveryId: json['delivery_id'] ?? 0,
      vendorId: json['vendor_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'status': status,
      'total': total,
      'total_after_discount': totalAfterDiscount,
      'lat': lat,
      'lon': lon,
      'region': region,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'delivery_id': deliveryId,
      'vendor_id': vendorId,
    };
  }
}
