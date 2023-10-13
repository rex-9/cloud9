class Me {
  late final int id;
  late final String name;
  late final String phone;
  late final String? email;
  late final String status;
  late final int point;

  Me({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.status,
    required this.point,
  });

  Me.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    status = json['status'];
    point = json['point'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['status'] = status;
    data['point'] = point;
    return data;
  }
}
