class TableDetails {
  String name;
  String seats;

  TableDetails({this.name, this.seats});

  TableDetails.fromStrings(String nameFrom, String seatsFrom) {
    name = nameFrom;
    seats = seatsFrom;
  }
}

class Restaurant {
  String oid;
  String address;
  String name;
  String restaurantId;
  List<MainCategory> menu;
  List<Server> servers;
  List<Table> tables;

  Restaurant({
    this.name,
    this.menu,
    this.address,
    this.oid,
    this.restaurantId,
    this.servers,
    this.tables,
  });

  Restaurant.fromJson(Map<String, dynamic> json) {
    oid = json['_id']['\$oid'];
    address = json['address'];
    name = json['name'];
    restaurantId = json['restaurant_id'];

    servers = new List<Server>();
    json['servers'].forEach((v) {
      servers.add(new Server.fromJson(v));
    });

    tables = new List<Table>();
    json['tables'].forEach((v) {
      tables.add(new Table.fromJson(v));
    });

    menu = new List<MainCategory>();
    json['menu'].forEach((v) {
      menu.add(new MainCategory.fromJson(v));
    });
  }
}

class Table {
  String oid;
  String name;
  int seats;
  int noOfUsers;
  List<String> servers;
  List<String> users;
  List<TableOrder> tableQueuedOrders;
  List<TableOrder> tableCookingOrders;
  List<TableOrder> tableCompletedOrders;
  List<AssistanceRequest> tableAssistanceRequest;

  Table({
    this.servers,
    this.oid,
    this.name,
    this.noOfUsers,
    this.seats,
    this.tableAssistanceRequest,
    this.tableCompletedOrders,
    this.tableCookingOrders,
    this.tableQueuedOrders,
    this.users,
  });

  Table.fromJson(Map<String, dynamic> json) {
    oid = json['_id']['\$oid'];
    name = json['name'];
    seats = json['seats'];
    noOfUsers = json['nofusers'];
    servers = new List<String>();
    json['servers'].forEach((v) {
      servers.add(v['\$oid']);
    });

    users = new List<String>();
    json['users'].forEach((v) {
      users.add(v['\$oid']);
    });

    tableQueuedOrders = new List<TableOrder>();
    json['qd_tableorders'].forEach((v) {
      tableQueuedOrders.add(new TableOrder.fromJson(v));
    });

    tableCookingOrders = new List<TableOrder>();
    json['cook_tableorders'].forEach((v) {
      tableCookingOrders.add(new TableOrder.fromJson(v));
    });

    tableCompletedOrders = new List<TableOrder>();
    json['com_tableorders'].forEach((v) {
      tableCompletedOrders.add(new TableOrder.fromJson(v));
    });

    tableAssistanceRequest = new List<AssistanceRequest>();
    json['assistance_reqs'].forEach((v) {
      tableAssistanceRequest.add(new AssistanceRequest.fromJson(v));
    });
  }
}

class Server {
  String oid;
  String name;
  //todo: update assistance history and order history
//  List assistanceHistory;
//  List orderHistory;

  Server({
    this.name,
    this.oid,
//    this.assistanceHistory,
//    this.orderHistory,
  });

  Server.fromJson(Map<String, dynamic> json) {
    oid = json['_id']['\$oid'];
    name = json['name'];
  }
}

class MainCategory {
  String oid;
  String description;
  String name;
  List<SubCategory> subCategory;

  MainCategory({
    this.oid,
    this.description,
    this.name,
    this.subCategory,
  });

  MainCategory.fromJson(Map<String, dynamic> json) {
    oid = json['_id']['\$oid'];

    name = json['name'];

    description = json['description'];

    if (json['sub_category'] != null) {
      subCategory = new List<SubCategory>();
      json['sub_category'].forEach((v) {
        subCategory.add(new SubCategory.fromJson(v));
      });
    }
  }

//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['description'] = this.description;
//    data['name'] = this.name;
//    if (this.subCategory != null) {
//      data['sub_category'] = this.subCategory.map((v) => v.toJson()).toList();
//    }
//    return data;
//  }
}

class SubCategory {
  String oid;
  String name;
  String description;
  List<MenuFoodItem> foodlist;

  SubCategory({
    this.description,
    this.foodlist,
    this.name,
    this.oid,
  });

  SubCategory.fromJson(Map<String, dynamic> json) {
    oid = json['_id']['\$oid'];

    name = json['name'];

    description = json['description'];

    if (json['foodlist'] != null) {
      foodlist = new List<MenuFoodItem>();
      json['foodlist'].forEach((v) {
        foodlist.add(new MenuFoodItem.fromJson(v));
      });
    }
  }

//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['description'] = this.description;
//    if (this.foodlist != null) {
//      data['foodlist'] = this.foodlist.map((v) => v.toJson()).toList();
//    }
//    data['name'] = this.name;
//
//    return data;
//  }
}

class MenuFoodItem {
  String description;
  String name;
  String price;
  String oid;

  MenuFoodItem({
    this.description,
    this.name,
    this.price,
    this.oid,
  });

  MenuFoodItem.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    name = json['name'];
    price = json['price'];
    oid = json['_id']['\$oid'];
  }
}

///////////////////////////////////////////////////////////////////////////////////
class TableOrder {
  String oId;
  String table;
  String status = 'queued';

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
  TableOrder.fromJsonNew(Map<String, dynamic> json) {
    oId = json['oId'];

    table = json['table'];
    status = json['status'];
    timeStamp = json['timeStamp'];
  }
  addFirstOrder(Order order) {
    this.orders = new List<Order>();
    this.orders.add(order);
  }

  addOrder(Order order) {
    this.orders.add(order);
  }

  cleanOrders(String order_id) {
    var delete = false;
    print(this.orders.length);
    this.orders.forEach((order) {
      if (order.oId == order_id) {
        if (order.foodlist.length == 0) delete = true;
      }
    });
    if (delete) this.orders.removeWhere((order) => order.oId == order_id);
    print(this.orders.length);
  }

  bool selfDestruct() {
    return this.orders.isEmpty;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oId'] = this.oId;
    data['table'] = this.table;
    data['status'] = this.status;
    data['timeStamp'] = this.timeStamp;
    return data;
  }
}

class Order {
  String oId;
  String placedby;

  List<FoodItem> foodlist;
  String status = 'queued';

  Order({this.oId, this.placedby, this.foodlist, this.status});

  Order.fromJson(Map<String, dynamic> json) {
    placedby = json['placedby']['\$oid'];
    oId = json['_id']['\$oid'];

    foodlist = new List<FoodItem>();
    json['foodlist'].forEach((v) {
      foodlist.add(FoodItem.fromJson(v));
    });
  }

  Order.fromJsonNew(Map<String, dynamic> json) {
    placedby = json['placedby'];
    oId = json['oId'];
    status = json['status'];
  }
  addFirstFood(FoodItem food) {
    this.foodlist = new List<FoodItem>();
    this.foodlist.add(food);
  }

  addFood(FoodItem food) {
    this.foodlist.add(food);
  }

  removeFoodItem(String food_id) {
    this.foodlist.removeWhere((food) => food.foodId == food_id);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oId'] = this.oId;
    data['placedby'] = this.placedby;
    data['status'] = this.status;
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['name'] = this.name;
    data['price'] = this.price;
    data['food_id'] = this.foodId;
    data['quantity'] = this.quantity;
    data['instructions'] = this.instructions;
    return data;
  }
}

// class for assistance requests

class AssistanceRequest {
  String table;
  String oId;
  String user;
  String assistanceType;
  DateTime timeStamp;
  String acceptedBy;

  AssistanceRequest({
    this.table,
    this.oId,
    this.user,
    this.assistanceType,
    this.timeStamp,
    this.acceptedBy,
  });

  AssistanceRequest.fromJson(Map<String, dynamic> json) {
    RegExp regExp = new RegExp("[0-9]+");
    oId = json['_id']['\$oid'];
    table = regExp.firstMatch(json['table']).group(0);
    user = json['user']['\$oid'];
    assistanceType = json['assistance_type'];

    timeStamp = DateTime.parse(json['timestamp']);
  }
}
