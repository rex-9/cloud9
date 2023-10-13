import 'package:cloud9/models/me.dart';
import 'package:cloud9/models/reward.dart';

class Exchange {
  late final int id;
  late final int customerId;
  late final int rewardId;
  late final String status;
  late final int usedPoint;
  late final String exchangeDate;
  late final Reward reward;
  late final Me customer;

  Exchange({
    required this.id,
    required this.customerId,
    required this.rewardId,
    required this.status,
    required this.usedPoint,
    required this.exchangeDate,
    required this.reward,
    required this.customer,
  });

  Exchange.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    rewardId = json['reward_id'];
    status = json['status'];
    usedPoint = json['used_point'];
    exchangeDate = json['exchange_date'];
    reward = Reward.fromJson(json['reward']);
    customer = Me.fromJson(json['customer']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['reward_id'] = rewardId;
    data['status'] = status;
    data['used_point'] = usedPoint;
    data['exchange_date'] = exchangeDate;
    data['reward'] = reward;
    data['customer'] = customer;
    return data;
  }
}
