class Address {
  final String firstName;
  final String lastName;
  final String fromAddress;
  final String fromLocality;
  final String fromCity;
  final String fromState;
  final String pincode;

  Address({
    required this.firstName,
    required this.lastName,
    required this.fromAddress,
    required this.fromLocality,
    required this.fromCity,
    required this.fromState,
    required this.pincode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      fromAddress: json['fromAddress'] ?? '',
      fromLocality: json['fromLocality'] ?? '',
      fromCity: json['fromCity'] ?? '',
      fromState: json['fromState'] ?? '',
      pincode: json['pincode'] ?? '',
    );
  }
}

class Estimate {
  final String estimateId;
  final String userId;
  final String movingFrom;
  final String movingTo;
  final String movingOn;
  final String distance;
  final String propertySize;
  final String oldFloorNo;
  final String newFloorNo;
  final String oldElevatorAvailability;
  final String newElevatorAvailability;
  final String oldParkingDistance;
  final String newParkingDistance;
  final String unpackingService;
  final String packingService;
  final Map<String, dynamic> items;
  final String oldHouseAdditionalInfo;
  final String newHouseAdditionalInfo;
  final String totalItems;
  final String status;
  final String orderDate;
  final String estimateStatus;
  final String customStatus;
  final Address fromAddress;
  final Address toAddress;
  final String serviceType;
  final dynamic storageItems;

  Estimate({
    required this.estimateId,
    required this.userId,
    required this.movingFrom,
    required this.movingTo,
    required this.movingOn,
    required this.distance,
    required this.propertySize,
    required this.oldFloorNo,
    required this.newFloorNo,
    required this.oldElevatorAvailability,
    required this.newElevatorAvailability,
    required this.oldParkingDistance,
    required this.newParkingDistance,
    required this.unpackingService,
    required this.packingService,
    required this.items,
    required this.oldHouseAdditionalInfo,
    required this.newHouseAdditionalInfo,
    required this.totalItems,
    required this.status,
    required this.orderDate,
    required this.estimateStatus,
    required this.customStatus,
    required this.fromAddress,
    required this.toAddress,
    required this.serviceType,
    required this.storageItems,
  });

  factory Estimate.fromJson(Map<String, dynamic> json) {
    return Estimate(
      estimateId: json['estimate_id'],
      userId: json['user_id'],
      movingFrom: json['moving_from'],
      movingTo: json['moving_to'],
      movingOn: json['moving_on'],
      distance: json['distance'],
      propertySize: json['property_size'],
      oldFloorNo: json['old_floor_no'],
      newFloorNo: json['new_floor_no'],
      oldElevatorAvailability: json['old_elevator_availability'],
      newElevatorAvailability: json['new_elevator_availability'],
      oldParkingDistance: json['old_parking_distance'],
      newParkingDistance: json['new_parking_distance'],
      unpackingService: json['unpacking_service'],
      packingService: json['packing_service'],
      items: json['items'],
      oldHouseAdditionalInfo: json['old_house_additional_info'],
      newHouseAdditionalInfo: json['new_house_additional_info'],
      totalItems: json['total_items'],
      status: json['status'],
      orderDate: json['order_date'],
      estimateStatus: json['estimate_status'],
      customStatus: json['custom_status'],
      fromAddress: Address.fromJson(json['from_address']),
      toAddress: Address.fromJson(json['to_address']),
      serviceType: json['service_type'],
      storageItems: json['storage_items'],
    );
  }
}
