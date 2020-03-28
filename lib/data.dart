class TableOrder {
  String iId;
  String table;

  List<Order> orders;
  DateTime timeStamp;

  TableOrder({this.iId, this.table, this.orders, this.timeStamp});

  TableOrder.fromJson(Map<String, dynamic> json) {
    iId = json['_id']['\$oid'];

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
  Map<String, FoodItem> foodlist;

  Order({this.placedby, this.foodlist});

  Order.fromJson(Map<String, dynamic> json) {
    placedby = json['placedby']['\$oid'];

    foodlist = new Map<String, FoodItem>();
    json['foodlist'].forEach((k, v) {
      foodlist[k] = new FoodItem.fromJson(v);
    });
  }
}

class FoodItem {
  String description;
  String name;
  String price;

  FoodItem({this.description, this.name, this.price});

  FoodItem.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}

// class for assistance requests

class AssistanceRequest {
  String table;
  String aId;
  String user;
  String assistanceType;
  DateTime timeStamp;

  AssistanceRequest(
      {this.table, this.aId, this.user, this.assistanceType, this.timeStamp});

  AssistanceRequest.fromJson(Map<String, dynamic> json) {
    RegExp regExp = new RegExp("[0-9]+");
    aId = json['_id']['\$oid'];
    table = regExp.firstMatch(json['table']).group(0);
    user = json['user']['\$oid'];
    assistanceType = json['assistance_type'];

    timeStamp = DateTime.parse(json['timestamp']);
  }
}
