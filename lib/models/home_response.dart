class OrderResponse {
  final String status;
  final String message;
  final List<OrderData> data;

  OrderResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null
          ? List<OrderData>.from(
              (json['data'] as List).map((x) => OrderData.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data.map((x) => x.toJson()).toList(),
      };
}

class OrderData {
  final int id;
  final int userId;
  final String status;
  final num total;
  final num totalAfterDiscount;
  final double lat;
  final double lon;
  final String region;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Item> items;
  final Vendor vendor;

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
    required this.items,
    required this.vendor,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      status: json['status'] ?? '',
      total: json['total'] ?? 0,
      totalAfterDiscount: json['total_after_discount'] ?? 0,
      lat: (json['lat'] ?? 0).toDouble(),
      lon: (json['lon'] ?? 0).toDouble(),
      region: json['region'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      items: json['items'] != null
          ? List<Item>.from(
              (json['items'] as List).map((x) => Item.fromJson(x)))
          : [],
      vendor: json['vendor'] != null
          ? Vendor.fromJson(json['vendor'])
          : Vendor.empty(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'status': status,
        'total': total,
        'total_after_discount': totalAfterDiscount,
        'lat': lat,
        'lon': lon,
        'region': region,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'items': items.map((x) => x.toJson()).toList(),
        'vendor': vendor.toJson(),
      };
}

class Item {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final int returnQuantity;
  final num price;
  final num priceAfterDiscount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Product product;

  Item({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.returnQuantity,
    required this.price,
    required this.priceAfterDiscount,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] ?? 0,
      orderId: json['order_id'] ?? 0,
      productId: json['product_id'] ?? 0,
      quantity: json['quantity'] ?? 0,
      returnQuantity: json['return_quantity'] ?? 0,
      price: json['price'] ?? 0,
      priceAfterDiscount: json['price_after_discount'] ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      product: json['product'] != null
          ? Product.fromJson(json['product'])
          : Product.empty(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'order_id': orderId,
        'product_id': productId,
        'quantity': quantity,
        'return_quantity': returnQuantity,
        'price': price,
        'price_after_discount': priceAfterDiscount,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'product': product.toJson(),
      };
}

class Product {
  final int id;
  final String title;
  final num price;
  final int userId;
  final bool isDelivered;
  final List<Tag> tags;
  final List<ImageData> images;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.userId,
    required this.isDelivered,
    required this.tags,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      price: json['price'] ?? 0,
      userId: json['user_id'] ?? 0,
      isDelivered: json['is_delivered'] ?? false,
      tags: json['tags'] != null
          ? List<Tag>.from((json['tags'] as List).map((x) => Tag.fromJson(x)))
          : [],
      images: json['images'] != null
          ? List<ImageData>.from(
              (json['images'] as List).map((x) => ImageData.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'user_id': userId,
        'is_delivered': isDelivered,
        'tags': tags.map((x) => x.toJson()).toList(),
        'images': images.map((x) => x.toJson()).toList(),
      };

  factory Product.empty() => Product(
        id: 0,
        title: '',
        price: 0,
        userId: 0,
        isDelivered: false,
        tags: [],
        images: [],
      );
}

class ImageData {
  final int id;
  final String image;
  final bool isMain;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int productId;

  ImageData({
    required this.id,
    required this.image,
    required this.isMain,
    required this.createdAt,
    required this.updatedAt,
    required this.productId,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
      isMain: json['is_main'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      productId: json['product_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'is_main': isMain,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'product_id': productId,
      };
}

class Tag {
  final int id;
  final String nameEn;
  final String nameAr;

  Tag({
    required this.id,
    required this.nameEn,
    required this.nameAr,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'] ?? 0,
      nameEn: json['name_en'] ?? '',
      nameAr: json['name_ar'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name_en': nameEn,
        'name_ar': nameAr,
      };
}

class Vendor {
  final int id;
  final String user;
  final String phone;
  final String address;
  final String region;
  final String image;
  final int status;
  final double lat;
  final double lon;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;

  Vendor({
    required this.id,
    required this.user,
    required this.phone,
    required this.address,
    required this.region,
    required this.image,
    required this.status,
    required this.lat,
    required this.lon,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'] ?? 0,
      user: json['user'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      region: json['region'] ?? '',
      image: json['image'] ?? '',
      status: json['status'] ?? 0,
      lat: (json['lat'] ?? 0).toDouble(),
      lon: (json['lon'] ?? 0).toDouble(),
      isVerified: json['is_verified'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user,
        'phone': phone,
        'address': address,
        'region': region,
        'image': image,
        'status': status,
        'lat': lat,
        'lon': lon,
        'is_verified': isVerified,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory Vendor.empty() => Vendor(
        id: 0,
        user: '',
        phone: '',
        address: '',
        region: '',
        image: '',
        status: 0,
        lat: 0.0,
        lon: 0.0,
        isVerified: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
}
