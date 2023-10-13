class Shop {
  late final String id;
  late final int retailerId;
  late final String name;
  late final String phone;
  late final String address;
  late final String latitude;
  late final String longitude;
  late final String shopQr;
  late final String image;
  late final String openHour;
  late final String closeHour;
  late final int createdBy;
  late final String createdAt;
  late final String updatedAt;

  Shop({
    required this.id,
    required this.retailerId,
    required this.name,
    required this.phone,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.shopQr,
    required this.image,
    required this.openHour,
    required this.closeHour,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    retailerId = json['retailer_id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    shopQr = json['shop_qr'];
    image = json['image'];
    openHour = json['open_hour'];
    closeHour = json['close_hour'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['retailer_id'] = retailerId;
    data['name'] = name;
    data['phone'] = phone;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['shop_qr'] = shopQr;
    data['image'] = image;
    data['open_hour'] = openHour;
    data['close_hour'] = closeHour;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
