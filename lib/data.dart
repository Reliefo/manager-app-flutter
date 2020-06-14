bool debug = true;

class Restaurant {
  String oid;
  String name;
  String restaurantId;
  String address;
  List<Category> foodMenu;
  List<Category> barMenu;
  List<Tables> tables;
  List<Staff> staff;
//  List<KitchenStaff> kitchenStaff;
  List<TableOrder> tableOrders;
  List<AssistanceRequest> assistanceRequests;
  List<String> homeScreenTags;
  List<String> navigateBetterTags;
  List<RestaurantOrderHistory> orderHistory;
  List<Kitchen> kitchens;

  Restaurant({
    this.oid,
    this.name,
    this.restaurantId,
    this.address,
    this.foodMenu,
    this.barMenu,
    this.tables,
    this.staff,
    this.tableOrders,
    this.assistanceRequests,
    this.orderHistory,
  });

  Restaurant.fromJson(Map<String, dynamic> json) {
    if (json['_id']['\$oid'] != null) {
      oid = json['_id']['\$oid'];
    }

    if (debug) {
      print("Restaurant oid added.!");
    }
//    address = json['address'];
    if (json['name'] != null) {
      name = json['name'];
    }
    if (debug) {
      print("Restaurant Name added.!");
    }
    if (json['restaurant_id'] != null) {
      restaurantId = json['restaurant_id'];
    }
    if (debug) {
      print("Restaurant id added.!");
    }
    //todo: add restaurant address if present
    if (json['food_menu'].isNotEmpty) {
      foodMenu = new List<Category>();
      json['food_menu'].forEach((v) {
        foodMenu.add(new Category.fromJson(v));
      });
    }

    if (debug) {
      print("Food menu added to restaurant object.!");
    }

//    print(json['bar_menu']);
    if (json['bar_menu'].isNotEmpty) {
      barMenu = new List<Category>();
      json['bar_menu'].forEach((v) {
        barMenu.add(new Category.fromJson(v));
      });
    }
    if (debug) {
      print("Bar menu added to restaurant object.!");
    }
    if (json['staff'].isNotEmpty) {
      staff = new List<Staff>();
      json['staff'].forEach((v) {
        staff.add(new Staff.fromJson(v));
      });
    }
    if (debug) {
      print("Staff added to restaurant object.!");
    }
//    if (json['kitchen_staff'].isNotEmpty) {
//      kitchenStaff = new List<KitchenStaff>();
//      json['kitchen_staff'].forEach((v) {
//        kitchenStaff.add(new KitchenStaff.fromJson(v));
//      });
//    }
//    if (debug) {
//      print("Kitchen Staff added to restaurant object.!");
//    }
    if (json['tables'].isNotEmpty) {
      tables = new List<Tables>();
      json['tables'].forEach((table) {
        tables.add(
          new Tables.fromRestJson(table, this.staff),
        );
      });
    }
    if (debug) {
      print("Tables added to restaurant object.!");
    }
    if (json['table_orders'].isNotEmpty) {
      tableOrders = new List<TableOrder>();
      json['table_orders'].forEach((v) {
        tableOrders.add(new TableOrder.fromJson(v));
      });
    }
    if (debug) {
      print("TableOrders added to restaurant object.!");
    }
    if (json['assistance_reqs'].isNotEmpty) {
      assistanceRequests = new List<AssistanceRequest>();
      json['assistance_reqs'].forEach((v) {
        assistanceRequests.add(new AssistanceRequest.fromJson(v));
      });
    }
    if (debug) {
      print("assistanceRequests added to restaurant object.!");
    }
    if (json['home_screen_tags'] != null) {
      homeScreenTags = new List<String>();
      json['home_screen_tags'].forEach((v) {
        homeScreenTags.add(v);
      });
    }
    if (debug) {
      print("Home Screen Tags added to restaurant object.!");
    }
    if (json['navigate_better_tags'] != null) {
      navigateBetterTags = new List<String>();
      json['navigate_better_tags'].forEach((v) {
        navigateBetterTags.add(v);
      });
    }

    if (debug) {
      print("Navigate Better Tags added to restaurant object.!");
    }

    if (json['order_history'].isNotEmpty) {
      orderHistory = new List<RestaurantOrderHistory>();
      json['order_history'].forEach((v) {
        orderHistory.add(new RestaurantOrderHistory.fromJson(v));
      });
    }
    if (debug) {
      print("Order History added to restaurant object.!");
    }
    if (json['kitchens'].isNotEmpty) {
      kitchens = new List<Kitchen>();
      json['kitchens'].forEach((v) {
        kitchens.add(new Kitchen.fromJson(v));
      });
    }
    if (debug) {
      print("Kitchen rooms added to restaurant object.!");
    }
  }
  addTableDetails(data) {
    if (this.tables == null) {
      this.tables = new List<Tables>();
    }

    data.forEach((v) {
      this.tables.add(new Tables.add(v));
    });
  }

  addStaffDetails(data) {
    if (this.staff == null) {
      this.staff = new List<Staff>();
    }
    data.forEach((v) {
      this.staff.add(new Staff.addConfig(v));
    });
  }

//  addKitchenStaffDetails(data) {
//    if (this.kitchenStaff == null) {
//      this.kitchenStaff = new List<KitchenStaff>();
//    }
//    data.forEach((v) {
//      this.kitchenStaff.add(new KitchenStaff.addConfig(v));
//    });
//  }

  addKitchenRooms(data) {
    if (this.kitchens == null) {
      this.kitchens = new List<Kitchen>();
    }
    this.kitchens.add(new Kitchen.addConfig(data));
  }

  addFoodMenuCategory(category) {
    if (this.foodMenu == null) {
      this.foodMenu = new List<Category>();
    }
    this.foodMenu.add(new Category.addConfig(category));
  }

  addBarMenuCategory(category) {
    if (this.barMenu == null) {
      this.barMenu = new List<Category>();
    }
    this.barMenu.add(new Category.addConfig(category));
  }
}

class Tables {
  String oid;
  String name;
  String seats;
  List<Staff> staff;
  List<Users> users = [];
  List<TableOrder> tableOrders;
//  List<AssistanceRequest> tableAssistanceRequest;

//  List<TableOrder> tableQueuedOrders = [];
//  List<TableOrder> tableCookingOrders = [];
//  List<TableOrder> tableCompletedOrders = [];
  int queueCount = 0;
  int cookingCount = 0;
  int completedCount = 0;

  Tables({
    this.oid,
    this.name,
    this.seats,
    this.staff,
    this.users,
    this.tableOrders,
    this.queueCount,
    this.cookingCount,
    this.completedCount,
  });

//  Tables.fromJson(Map<String, dynamic> json) {
//    if (json['_id']['\$oid'] != null) {
//      oid = json['_id']['\$oid'];
//    }
//
//    if (json['name'] != null) {
//      name = json['name'];
//    }
//
//    if (json['seats'] != null) {
//      seats = json['seats'].toString();
//    }
//
//    if (json['staff'].isNotEmpty) {
//      staff = new List<Staff>();
//      json['staff'].forEach((v) {
//        staff.add(v['\$oid']);
//      });
//    }
//
//    if (json['users'].isNotEmpty) {
//      users = new List<String>();
//      json['users'].forEach((v) {
//        users.add(v['\$oid']);
//      });
//    }
//
//    if (json['table_orders'].isNotEmpty) {
//      tableOrders = new List<TableOrder>();
//      json['table_orders'].forEach((v) {
//        tableOrders.add(new TableOrder.fromJson(v));
//      });
//    }
//
//    if (json['assistance_reqs'].isNotEmpty) {
//      tableAssistanceRequest = new List<AssistanceRequest>();
//      json['assistance_reqs'].forEach((v) {
//        tableAssistanceRequest.add(new AssistanceRequest.fromJson(v));
//      });
//    }
////    tableQueuedOrders = new List<TableOrder>();
////    json['qd_tableorders'].forEach((v) {
////      tableQueuedOrders.add(new TableOrder.fromJson(v));
////    });
////
////    tableCookingOrders = new List<TableOrder>();
////    json['cook_tableorders'].forEach((v) {
////      tableCookingOrders.add(new TableOrder.fromJson(v));
////    });
////
////    tableCompletedOrders = new List<TableOrder>();
////    json['com_tableorders'].forEach((v) {
////      tableCompletedOrders.add(new TableOrder.fromJson(v));
////    });
//  }

  Tables.fromRestJson(Map<String, dynamic> json, List<Staff> listStaff) {
    if (json['_id']['\$oid'] != null) {
      oid = json['_id']['\$oid'];
    }

    if (json['name'] != null) {
      name = json['name'];
    }

    if (json['seats'] != null) {
      seats = json['seats'].toString();
    }

    if (json['staff'].isNotEmpty) {
      staff = new List<Staff>();
      json['staff'].forEach((tableStaffId) {
        listStaff.forEach((restStaff) {
          if (restStaff.oid == tableStaffId["\$oid"]) {
            staff.add(restStaff);
          }
        });
      });
    }

    if (json['users'].isNotEmpty) {
      users = new List<Users>();
      json['users'].forEach((v) {
        users.add(new Users.fromJson(v));
      });

//      users = new List<Map<String, dynamic>>();
//      json['users'].forEach((v) {
//        users.add({v['_id']['\$oid']: v['name']});

//        users.add({
//          "id": v['_id']['\$oid'],
//          "name": v['name'],
//        });
//        print("users id added");

    }

    if (json['table_orders'].isNotEmpty) {
      tableOrders = new List<TableOrder>();
      json['table_orders'].forEach((v) {
        tableOrders.add(new TableOrder.fromJson(v));
      });
    }

//    if (json['assistance_reqs'].isNotEmpty) {
//      tableAssistanceRequest = new List<AssistanceRequest>();
//      json['assistance_reqs'].forEach((v) {
//        tableAssistanceRequest.add(new AssistanceRequest.fromJson(v));
//      });
//    }

//    tableQueuedOrders = new List<TableOrder>();
//    json['qd_tableorders'].forEach((v) {
//      tableQueuedOrders.add(new TableOrder.fromJson(v));
//    });
//
//    tableCookingOrders = new List<TableOrder>();
//    json['cook_tableorders'].forEach((v) {
//      tableCookingOrders.add(new TableOrder.fromJson(v));
//    });
//
//    tableCompletedOrders = new List<TableOrder>();
//    json['com_tableorders'].forEach((v) {
//      tableCompletedOrders.add(new TableOrder.fromJson(v));
//    });
  }

  addTableStaff(Staff selectedStaff) {
    print(selectedStaff);
    if (this.staff == null) {
      this.staff = new List<Staff>();
    }
    this.staff.add(selectedStaff);
  }

  Tables.add(table) {
    oid = table['table_id'];
    name = table['name'];
    seats = table['seats'];
  }

  updateOrderCount(queue, cooking, completed) {
//    print("from update count");
//    print(queue);
//    print(cooking);
//    print(completed);
    this.queueCount = this.queueCount + queue;
    this.cookingCount = this.cookingCount + cooking;
    this.completedCount = this.completedCount + completed;
  }
}

class Users {
  String oid;
  String name;

  Users({
    this.oid,
    this.name,
  });

  Users.fromJson(Map<String, dynamic> json) {
    if (json['_id']['\$oid'] != null) {
      oid = json['_id']['\$oid'];
    }

    if (json['name'] != null) {
      name = json['name'];
    }
  }
}

class Staff {
  String oid;
  String name;
  //todo: update assistance history and order history
//  List<AssistanceRequest> assistanceHistory;
  List<StaffOrderHistory> orderHistory;
  List requestHistory = [];

  Staff({
    this.name,
    this.oid,
//    this.assistanceHistory,
    this.orderHistory,
    this.requestHistory,
  });

  Staff.fromJson(Map<String, dynamic> json) {
//    print("inside staff");
//    print(json.keys.toList());
    if (json['_id']['\$oid'] != null) {
      oid = json['_id']['\$oid'];
    }

    if (json['name'] != null) {
      name = json['name'];
    }
//    print("before adding staff assistance");

    if (json['requests_history'] != null &&
        json['requests_history'].isNotEmpty) {
      json['requests_history'].forEach((v) {
        if (v['request_type'] == "pickup_request") {
          requestHistory.add(StaffOrderHistory.fromJson(v));

//          print("added to order history");
        }
        if (v['request_type'] == "assistance_request") {
          requestHistory.add(AssistanceRequest.fromJson(v));
//          print("added to assistance history");
        }
      });
    }
//    if (json['assistance_history'] != null &&
//        json['assistance_history'].isNotEmpty) {
//      print("before adding staff assistancefdfdfd");
//
//      print(json['assistance_history']);
//      //todo:check
//      assistanceHistory = new List<AssistanceRequest>();
//      json['assistance_history'].forEach((v) {
//        assistanceHistory.add(new AssistanceRequest.fromJson(v));
//      });
//    }
//    print("after adding staff assistance");

//    if (json['order_history'] != null &&
//        json['assistance_history'].isNotEmpty) {
//      //todo:check
//
//      orderHistory = new List<StaffOrderHistory>();
//      json['order_history'].forEach((v) {
//        print(v);
//        orderHistory.add(new StaffOrderHistory.fromJson(v));
//      });
//    }
  }

  addStaff(staff) {
//    print(staff.oid);
//    print('ading staff f');
    oid = staff.oid;
    name = staff.name;
  }

  Staff.addConfig(staff) {
    oid = staff['staff_id'];
    name = staff['name'];
  }
}

class StaffOrderHistory {
  String tableOrderId;
  String orderId;
  String foodId;
  String kitchenStaffId;
  String table;
  String tableId;
  String user;
  DateTime timestamp;
  String food;
  String status;
  String acceptedBy;

  StaffOrderHistory({
    this.tableOrderId,
    this.orderId,
    this.foodId,
    this.kitchenStaffId,
    this.table,
    this.tableId,
    this.user,
    this.timestamp,
    this.food,
    this.status,
    this.acceptedBy,
  });

  StaffOrderHistory.fromJson(Map<String, dynamic> json) {
    if (json['table_order_id'] != null) {
      tableOrderId = json['table_order_id'];
    }
    if (json['order_id'] != null) {
      orderId = json['order_id'];
    }
    if (json['food_id'] != null) {
      foodId = json['food_id'];
    }
    if (json['kitchen_staff_id'] != null) {
      kitchenStaffId = json['kitchen_staff_id'];
    }
    if (json['table'] != null) {
      table = json['table'];
    }
    if (json['table_id'] != null) {
      tableId = json['table_id'];
    }
    if (json['user'] != null) {
      user = json['user'];
    }

    if (json['timestamp'] != null) {
      timestamp = DateTime.parse(json['timestamp']);
    }
    if (json['food_name'] != null) {
      food = json['food_name'];
    }
    if (json['status'] != null) {
      status = json['status'];
    }
    if (json['staff_id'] != null) {
      acceptedBy = json['staff_id'];
    }
  }
}

//{
//"table_order_id": "5ec4f44a52fb64704df9b2c1",
//"type": "on_the_way",
//"order_id": "5ec4f44a52fb64704df9b2c0",
//"food_id": "5eb41b85adb66da6f5312064",
//"kitchen_staff_id": "5ebbf19bdcfeedd2a5c55c93",
//"table": "table6",
//"table_id": "5eb41b91adb66da6f5312125",
//"user": "Saturn_1",
//"timestamp": "2020-05-20 14:42:09.397902",
//"food_name": "SPICY TRICOLOUR CHAAT",
//"request_type": "pickup_request",
//"status": "accepted",
//"restaurant_id": null,
//"staff_id": "5eb41bbaadb66da6f5312132"
//}
class KitchenStaff {
  String oid;
  String name;
  String kitchen;

  KitchenStaff({this.name, this.oid, this.kitchen});
  KitchenStaff.fromJson(Map<String, dynamic> json) {
    if (json['_id']['\$oid'] != null) {
      oid = json['_id']['\$oid'];
    }

    if (json['name'] != null) {
      name = json['name'];
    }

    if (json['kitchen'] != null) {
      kitchen = json['kitchen'];
    }
  }

  KitchenStaff.addConfig(staff) {
    oid = staff['kitchen_staff_id'];
    name = staff['name'];
  }
}

class Category {
  String oid;
  String name;
  String description;
  List<MenuFoodItem> foodList;

  Category({
    this.oid,
    this.name,
    this.description,
    this.foodList,
  });

  Category.fromJson(Map<String, dynamic> json) {
    if (json['_id']['\$oid'] != null) {
      oid = json['_id']['\$oid'];
    }
    if (json['name'] != null) {
      name = json['name'];
    }

    if (json['description'] != null) {
      description = json['description'];
    }

    if (json['food_list'] != null) {
      foodList = new List<MenuFoodItem>();
      json['food_list'].forEach((v) {
        foodList.add(new MenuFoodItem.fromJson(v));
      });
    }
  }
  Category.addConfig(category) {
    oid = category['category_id'];
    name = category['name'];
    if (category['description'] != null) {
      description = category['description'];
    }
    print('added to category');
  }

  addFoodItem(foodItem) {
    if (this.foodList == null) {
      this.foodList = new List<MenuFoodItem>();
    }

    this.foodList.add(MenuFoodItem.addFood(foodItem));
  }

//
//      food_dict: {name: new food, description: tyukk, price: 45p, food_options: {options: {},
//      choices: []}, food_id: 5e949ed8fe4ce65500586c29}

//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['description'] = this.description;
//    if (this.food_list != null) {
//      data['food_list'] = this.foodlist.map((v) => v.toJson()).toList();
//    }
//    data['name'] = this.name;
//
//    return data;
//  }
}

class MenuFoodItem {
  String oid;
  String name;
  String description;
  String price;
  List<String> tags;
  FoodOption foodOption;

  MenuFoodItem({
    this.oid,
    this.name,
    this.description,
    this.price,
    this.tags,
    this.foodOption,
  });

  MenuFoodItem.fromJson(Map<String, dynamic> json) {
    if (json['_id']['\$oid'] != null) {
      oid = json['_id']['\$oid'];
    }

    if (json['name'] != null) {
      name = json['name'];
    }

    if (json['description'] != null) {
      description = json['description'];
    }

    if (json['price'] != null) {
      price = json['price'];
    }

    if (json['tags'] != null) {
//      print("inside add tags");
      tags = new List<String>();
      json['tags'].forEach((v) {
        tags.add(v);
      });
    }

    if (json['food_options'] != null) {
      foodOption = new FoodOption.fromJson(json['food_options']);
    }
  }

  MenuFoodItem.addFood(food) {
    this.oid = food['food_id'];
    this.name = food['name'];
    this.description = food['description'];
    this.price = food['price'];
    if (food['food_options'] != null) {
      this.foodOption = new FoodOption.fromJson(food['food_options']);
      print('food item added');
    }
  }

  addEdited(edited) {
    if (edited['food_id'] != null) {
      this.oid = edited['food_id'];
    }
    if (edited['name'] != null) {
      this.name = edited['name'];
    }

    if (edited['description'] != null) {
      this.description = edited['description'];
    }
    if (edited['price'] != null) {
      this.price = edited['price'];
    }
    print('added edited here');

    if (edited["food_options"] != null) {
      print('added edited here3');

      if (edited["food_options"]["options"] != null) {
        print("uii");

        print("uii122");
        if (edited["food_options"]["options"].length > 0) {
          this.foodOption.options = new List<Map<String, dynamic>>();
          edited["food_options"]["options"].forEach((option) {
            this.foodOption.options.add(option);
          });
        } else {
          print("hjk");
          this.foodOption.options.clear();
        }
      }

      print("cming herewqeeqe");
      if (edited["food_options"]["choices"] != null) {
        if (edited["food_options"]["choices"].length > 0) {
          this.foodOption.choices = new List<String>();
          edited["food_options"]["choices"].forEach((choice) {
            this.foodOption.choices.add(choice);
          });
        } else {
          print("ch here");
          this.foodOption.choices.clear();
        }
      }
    }
    print('added edited here45');
  }
}

class FoodOption {
  List<Map<String, dynamic>> options = [];
  List<Map<String, dynamic>> addOns = [];
  List<String> choices = [];

  FoodOption({
    this.options,
    this.choices,
  });

  FoodOption.fromJson(Map<String, dynamic> json) {
    if (json['options'] != null) {
      options = new List<Map<String, dynamic>>();
      json['options'].forEach((option) {
        options.add(option);
      });
      //Todo: check
    }
    if (json['add_ons'] != null) {
      addOns = new List<Map<String, dynamic>>();
      json['add_ons'].forEach((addOn) {
        addOns.add(addOn);
      });
      //Todo: check
    }
    if (json['choices'] != null) {
      choices = new List<String>();
      json['choices'].forEach((v) {
        choices.add(v);
      });
    }
  }
}

class TableOrder {
  String oId;
  String table;
  String tableId;
  List<Order> orders;
  String status = 'queued';
  bool personalOrder = false;

  DateTime timeStamp;

  TableOrder({
    this.oId,
    this.table,
    this.tableId,
    this.orders,
    this.status,
    this.timeStamp,
    this.personalOrder,
  });

  TableOrder.fromJson(Map<String, dynamic> json) {
    if (json['_id']['\$oid'] != null) {
      oId = json['_id']['\$oid'];
    }

    if (json['table'] != null) {
      table = json['table'];
    }

    if (json['table_id'] != null) {
      tableId = json['table_id'];
    }

    if (json['orders'] != null) {
      orders = new List<Order>();
      json['orders'].forEach((v) {
        orders.add(new Order.fromJson(v));
      });
    }
    if (json['personal_order'] != null) {
      personalOrder = json['personal_order'];
    }
    if (json['timestamp'] != null) {
      timeStamp = DateTime.parse(json['timestamp']);
    }
  }

  TableOrder.fromJsonNew(Map<String, dynamic> json) {
    print("innside table order");
    print(json);
    oId = json['oId'];
    table = json['table'];
    tableId = json['table_id'];
    status = json['status'];
    timeStamp = json['timestamp'];
    personalOrder = json['personalOrder'];
  }

  addFirstOrder(Order order) {
    this.orders = new List<Order>();
    this.orders.add(order);
  }

  addOrder(Order order) {
    this.orders.add(order);
  }

  cleanOrders(String orderId) {
    var delete = false;
    this.orders.forEach((order) {
      if (order.oId == orderId) {
        if (order.foodList.length == 0) delete = true;
      }
    });
    if (delete) this.orders.removeWhere((order) => order.oId == orderId);
  }

  bool selfDestruct() {
    return this.orders.isEmpty;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oId'] = this.oId;
    data['table'] = this.table;
    data['table_id'] = this.tableId;
    data['status'] = this.status;
    data['timestamp'] = this.timeStamp;
    data['personalOrder'] = this.personalOrder;
    return data;
  }
}

class Order {
  String oId;
  Map<String, dynamic> placedBy;
  List<FoodItem> foodList;
  String status;

  Order({
    this.oId,
    this.placedBy,
    this.foodList,
    this.status,
  });

  Order.fromJson(Map<String, dynamic> json) {
    if (json['_id']['\$oid'] != null) {
      oId = json['_id']['\$oid'];
    }

    if (json['placed_by'] != null) {
//      print("inside orders");
//      print(json['placed_by']);
      placedBy = {
        "id": json['placed_by']['id'],
        "name": json['placed_by']['name']
      };
    }

    if (json['food_list'] != null) {
      foodList = new List<FoodItem>();
      json['food_list'].forEach((v) {
        foodList.add(FoodItem.fromJson(v));
      });
    }

//    if (json['status'] != null) {
//      placedBy = json['placed_by']['\$oid'];
//    }
  }

  Order.fromJsonNew(Map<String, dynamic> json) {
    placedBy = json['placed_by'];
    oId = json['oId'];
    status = json['status'];
  }
  addFirstFood(FoodItem food) {
    this.foodList = new List<FoodItem>();
    this.foodList.add(food);
  }

  addFood(FoodItem food) {
    this.foodList.add(food);
  }

  removeFoodItem(String foodId) {
    this.foodList.removeWhere((food) => food.foodId == foodId);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oId'] = this.oId;
    data['placed_by'] = this.placedBy;
    data['status'] = this.status;
    return data;
  }
}

class FoodItem {
  String foodId;
  String name;
  String description;
  String price;
  String instructions;
  int quantity;
  String status;
  FoodOption foodOption;

  FoodItem({
    this.foodId,
    this.name,
    this.description,
    this.price,
    this.instructions,
    this.quantity,
    this.status,
  });

  FoodItem.fromJson(Map<String, dynamic> json) {
    if (json['food_id'] != null) {
      foodId = json['food_id'];
    }

    if (json['name'] != null) {
      name = json['name'];
    }

    if (json['description'] != null) {
      description = json['description'];
    }

    if (json['price'] != null) {
      price = json['price'];
    }

    if (json['instructions'] != null) {
      instructions = json['instructions'];
    }

    if (json['quantity'] != null) {
      quantity = json['quantity'];
    }

    if (json['status'] != null) {
      status = json['status'];
    }

    if (json['food_options'] != null) {
      foodOption = new FoodOption.fromJson(json['food_options']);
    }
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
//    {table: table5, table_id: 5eb41b91adb66da6f5312124,
//assistance_type: ketchup, timestamp: 2020-05-19 19:54:31.404966,
//accepted_by: {}, user_id: 5ebe96afbf56fc08b6d464b9, user: Mercury_1,
//assistance_req_id: 5ec3ec1f52fb64704df9b2aa, request_type: assistance_request,
//status: pending, msg: Service has been requested}
//////////////// in staff accepted & rej history

class AssistanceRequest {
  String table;
  String tableId;
  String assistanceType;
  DateTime timeStamp;
  Map<String, String> acceptedBy;
  String userId;
  String user;
  String assistanceReqId;
  String requestType;
  String status;

  AssistanceRequest({
    this.table,
    this.tableId,
    this.assistanceType,
    this.timeStamp,
    this.acceptedBy,
    this.userId,
    this.user,
    this.assistanceReqId,
    this.requestType,
    this.status,
  });
//  {
//  "table": "table6",
//  "table_id": "5eb41b91adb66da6f5312125",
//  "assistance_type": "water",
//  "timestamp": "2020-05-19 15:34:44.508783",
//  "accepted_by": {
//  "staff_id": "5eb41bbaadb66da6f5312132",
//  "staff_name": "Amb"
//  },
//  "user_id": "5ebbf238dcfeedd2a5c55c95",
//  "user": "Venus_2",
//  "assistance_req_id": "5ec3af3c8d66e5b92fad7797",
//  "request_type": "assistance_request",
//  "status": "accepted",
//  "msg": "Service has been accepted",
//  "restaurant_id": "BNGHSR0001",
//  "staff_name": "Amb"
//  }
  AssistanceRequest.fromJson(Map<String, dynamic> json) {
    if (json['table'] != null) {
      table = json['table'];
    }
    if (json['table_id'] != null) {
      tableId = json['table_id'];
    }
    if (json['assistance_type'] != null) {
      assistanceType = json['assistance_type'];
    }
    if (json['timestamp'] != null) {
      timeStamp = DateTime.parse(json['timestamp']);
    }
//    print("while adding");
    if (json['accepted_by'].isNotEmpty) {
      acceptedBy = {
        "staff_name": json['accepted_by']['staff_name'],
        "staff_id": json['accepted_by']['staff_id']
      };
    }
//    print("while adding 1");
    if (json['user_id'] != null) {
      userId = json['user_id'];
    }
    if (json['user'] != null) {
      user = json['user'];
    }
    if (json['assistance_req_id'] != null) {
      assistanceReqId = json['assistance_req_id'];
    }
    if (json['request_type'] != null) {
      requestType = json['request_type'];
    }
    if (json['status'] != null) {
      status = json['status'];
    }
  }

//  AssistanceRequest.adding(Map<String, dynamic> json) {
//    print("here ass ");
//    if (json['assistance_req_id'] != null) {
//      oId = json['assistance_req_id'];
//    }
//
//    if (json['table'] != null) {
//      table = json['table'];
//    }
//
//    if (json['table_id'] != null) {
//      tableId = json['table_id'];
//    }
//
//    if (json['user'] != null) {
//      user = json['user'];
//    }
//
//    if (json['assistance_type'] != null) {
//      assistanceType = json['assistance_type'];
//    }
//
//    if (json['timestamp'] != null) {
//      timeStamp = DateTime.parse(json['timestamp']);
//    }
//  }
}

class RestaurantOrderHistory {
  String oid;
  List<TableOrder> tableOrder;
  List<TableOrder> personalOrder;
  List<Map<String, String>> users;
  List<AssistanceRequest> assistanceReq;
  DateTime timeStamp;
  String tableId;
  String table;
  Bill bill;
  String pdf;

  RestaurantOrderHistory({
    this.oid,
    this.tableOrder,
    this.personalOrder,
    this.users,
    this.assistanceReq,
    this.timeStamp,
    this.tableId,
    this.table,
    this.bill,
    this.pdf,
  });

  RestaurantOrderHistory.fromJson(Map<String, dynamic> json) {
    print("order history");
    print(json.keys.toList());
//
    print(json['bill_structure']);
    print(json['timestamp']);
    print(json['pdf']);

    if (json['_id']['\$oid'] != null) {
      oid = json['_id']['\$oid'];
    }

    if (debug) {
      print(" oid added to RestaurantOrderHistory.!");
    }

    if (json['table_orders'] != null) {
      tableOrder = new List<TableOrder>();
      json['table_orders'].forEach((v) {
        tableOrder.add(TableOrder.fromJson(v));
      });
    }
    if (debug) {
      print(" table order added to RestaurantOrderHistory.!");
    }

    if (json['personal_orders'] != null) {
      personalOrder = new List<TableOrder>();
      json['personal_orders'].forEach((v) {
        personalOrder.add(TableOrder.fromJson(v));
      });
    }
    if (debug) {
      print(" personalOrder added to RestaurantOrderHistory.!");
    }
    if (json['users'] != null) {
      users = new List<Map<String, String>>();
      json['users'].forEach((user) {
        users.add({"name": user["name"], "id": user["user_id"]});
      });
    }
    if (debug) {
      print(" users added to RestaurantOrderHistory.!");
    }
    if (json['assistance_reqs'] != null) {
      assistanceReq = new List<AssistanceRequest>();
      json['assistance_reqs'].forEach((v) {
        assistanceReq.add(AssistanceRequest.fromJson(v));
      });
    }
    if (debug) {
      print(" assistanceReq added to RestaurantOrderHistory.!");
    }
    if (json['timestamp'] != null) {
      timeStamp = DateTime.parse(json['timestamp']);
    }
    if (debug) {
      print(" timeStamp added to RestaurantOrderHistory.!");
    }
    if (json['table_id'] != null) {
      tableId = json['table_id'];
    }
    if (debug) {
      print(" tableId added to RestaurantOrderHistory.!");
    }
    if (json['table'] != null) {
      table = json['table'];
    }
    if (debug) {
      print(" table added to RestaurantOrderHistory.!");
    }
    if (json['bill_structure'] != null) {
      bill = Bill.fromJson(json['bill_structure']);
    }
    if (debug) {
      print(" bill added to RestaurantOrderHistory.!");
    }
    if (json['pdf'] != null) {
      pdf = json['pdf'];
    }
    if (debug) {
      print(" pdf added to RestaurantOrderHistory.!");
    }
  }
}

class Bill {
  double preTaxAmount;
  double totalTax;
  double totalAmount;

  Bill({
    this.preTaxAmount,
    this.totalTax,
    this.totalAmount,
  });
//  {Pre-Tax Amount: 870.0, Total Tax: 8.5, Total Amount: 943.95}
  Bill.fromJson(Map<String, dynamic> json) {
    print(json['Pre-Tax Amount'].runtimeType);
    print(json['Taxes'].runtimeType);
    print(json['Total Amount'].runtimeType);

    if (json['Pre-Tax Amount'] != null) {
      if (json['Pre-Tax Amount'].runtimeType == int) {
        preTaxAmount = json['Pre-Tax Amount'].toDouble();
      } else
        preTaxAmount = json['Pre-Tax Amount'];
    }

    if (json['Taxes'] != null) {
      totalTax = json['Taxes'];
    }

    if (json['Total Amount'] != null) {
      totalAmount = json['Total Amount'];
    }
  }
}

class Kitchen {
  String oid;
  String name;
  List<Category> categoriesList;
  List<KitchenStaff> kitchenStaffList;

  Kitchen({
    this.oid,
    this.name,
    this.categoriesList,
    this.kitchenStaffList,
  });

  Kitchen.fromJson(Map<String, dynamic> json) {
    print('kitchen json');
    print(json.keys.toList());

    if (json['_id']['\$oid'] != null) {
      oid = json['_id']['\$oid'];
    }

    if (json['name'] != null) {
      name = json['name'];
    }
    print("here45");
    if (json['categories'] != null) {
      categoriesList = new List<Category>();
      json['categories'].forEach((v) {
        categoriesList.add(Category.addConfig(v));
      });
    }
    print("her22e45");

    if (json['kitchen_staff'] != null) {
      kitchenStaffList = new List<KitchenStaff>();
      json['kitchen_staff'].forEach((v) {
        kitchenStaffList.add(KitchenStaff.fromJson(v));
      });
    }
  }

  Kitchen.addConfig(kitchen) {
    print("config kitchen");
    print(kitchen);
    print(kitchen['kitchen_id']);
    oid = kitchen['kitchen_id'];
    name = kitchen['name'];
  }
}
