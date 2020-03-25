class Order {
  String iId;
  List<String> placedby;
  String table;
  Map<String, FoodItem> foodlist;
  String customerType;

  Order(
      {this.iId, this.placedby, this.table, this.foodlist, this.customerType});

  Order.fromJson(Map<String, dynamic> json) {
    iId = json['_id']['\$oid'];

    placedby = new List<String>();
    json['placedby'].forEach((v) {
      placedby.add(v['\$oid']);
    });
    table = json['table']['\$oid'];

    foodlist = new Map<String, FoodItem>();
    json['foodlist'].forEach((k, v) {
      foodlist[k] = new FoodItem.fromJson(v);
    });

    customerType = json['customer_type'];
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
