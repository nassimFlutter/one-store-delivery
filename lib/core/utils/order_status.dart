enum OrderStatus { deliveryAccept, vendorAccept, pending, delivered }

extension OrderStatusExtension on OrderStatus {
  String toApiString() {
    switch (this) {
      case OrderStatus.delivered:
        return "delivered";
      case OrderStatus.deliveryAccept:
        return "delivery_accept";
      case OrderStatus.vendorAccept:
        return "vendor_accept";
      case OrderStatus.pending:
      default:
        return "pending";
    }
  }
}

// Convert API String to Enum
extension StringToOrderStatus on String {
  OrderStatus toOrderStatus() {
    switch (this) {
      case "delivery_accept":
        return OrderStatus.deliveryAccept;
      case "vendor_accept":
        return OrderStatus.vendorAccept;
      default:
        return OrderStatus.pending;
    }
  }
}
