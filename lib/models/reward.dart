class Reward {
  late final int id;
  late final String title;
  late final int quantity;
  late final int point;
  late final int value;
  late final String image;
  late final String status;
  late final String type;
  late final String? createdAt;
  late final String? updatedAt;

  Reward({
    required this.id,
    required this.title,
    required this.quantity,
    required this.point,
    required this.value,
    required this.image,
    required this.status,
    required this.type,
    this.createdAt,
    this.updatedAt,
  });

  Reward.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    quantity = json['quantity'];
    point = json['point'];
    value = json['value'];
    image = json['image'];
    status = json['status'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['quantity'] = quantity;
    data['point'] = point;
    data['value'] = value;
    data['image'] = image;
    data['status'] = status;
    data['type'] = type;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
