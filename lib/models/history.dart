class History {
  late final int id;
  late final int actionId;
  late final String actionModel;
  late final String title;
  late final String image;
  late final String message;
  late final String type;
  late final int customerId;
  late final String updatedAt;
  late final String createdAt;

  History({
    required this.id,
    required this.actionId,
    required this.actionModel,
    required this.title,
    required this.image,
    required this.message,
    required this.type,
    required this.customerId,
    required this.updatedAt,
    required this.createdAt,
  });

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    actionId = json['action_id'];
    actionModel = json['action_model'];
    title = json['title'];
    image = json['image'];
    message = json['message'];
    type = json['type'];
    customerId = json['customer_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['action_id'] = actionId;
    data['action_model'] = actionModel;
    data['title'] = title;
    data['image'] = image;
    data['message'] = message;
    data['type'] = type;
    data['customer_id'] = customerId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    return data;
  }
}
