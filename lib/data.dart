class TableOrder {
  String oId;
  String table;
  String status = 'pending';

  List<Order> orders;
  DateTime timeStamp;

  TableOrder({this.oId, this.table, this.orders, this.timeStamp, this.status});

  TableOrder.fromJson(Map<String, dynamic> json) {
    oId = json['_id']['\$oid'];

    RegExp regExp = new RegExp("[0-9]+");

    table = regExp.firstMatch(json['table']).group(0);

    orders = new List<Order>();
    json['orders'].forEach((v) {
      orders.add(new Order.fromJson(v));
    });

    timeStamp = DateTime.parse(json['timestamp']);
  }
}

class Order {
  String placedby;
  List<FoodItem> foodlist;
  String status = 'pending';

  Order({this.placedby, this.foodlist, this.status});

  Order.fromJson(Map<String, dynamic> json) {
    placedby = json['placedby']['\$oid'];

    foodlist = new List<FoodItem>();
    json['foodlist'].forEach((v) {
      foodlist.add(FoodItem.fromJson(v));
    });
  }
}

class FoodItem {
  String description;
  String name;
  String price;
  String foodId;
  String instructions;
  String status = 'queued';
  int quantity;

  FoodItem(
      {this.description,
      this.name,
      this.price,
      this.foodId,
      this.quantity,
      this.status,
      this.instructions});

  FoodItem.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    name = json['name'];
    price = json['price'];
    foodId = json['food_id'];
    quantity = json['quantity'];
    instructions = json['instructions'];
  }

//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['description'] = this.description;
//    data['name'] = this.name;
//    data['price'] = this.price;
//    data['food_id'] = this.foodId;
//    data['quantity'] = this.quantity;
//    data['instructions'] = this.instructions;
//    return data;
//  }
}

// class for assistance requests

class AssistanceRequest {
  String table;
  String oId;
  String user;
  String assistanceType;
  DateTime timeStamp;
  String acceptedBy;

  AssistanceRequest(
      {this.table,
      this.oId,
      this.user,
      this.assistanceType,
      this.timeStamp,
      this.acceptedBy});

  AssistanceRequest.fromJson(Map<String, dynamic> json) {
    RegExp regExp = new RegExp("[0-9]+");
    oId = json['_id']['\$oid'];
    table = regExp.firstMatch(json['table']).group(0);
    user = json['user']['\$oid'];
    assistanceType = json['assistance_type'];

    timeStamp = DateTime.parse(json['timestamp']);
  }
}
