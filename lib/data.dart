class Restaurant {
  String oid;
  String name;
  String restaurantId;
  String address;
  List<Category> foodMenu;
  List<Category> barMenu;
  List<Tables> tables;
  List<Staff> staff;
  List<KitchenStaff> kitchenStaff;
  List<TableOrder> tableOrders;
  List<AssistanceRequest> assistanceRequests;
  List<String> homeScreenTags;
  List<String> navigateBetterTags;

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
  });

  Restaurant.fromJson(Map<String, dynamic> json) {
    if (json['_id']['\$oid'] != null) {
      oid = json['_id']['\$oid'];
    }
//    address = json['address'];
    if (json['name'] != null) {
      name = json['name'];
    }

    if (json['restaurant_id'] != null) {
      restaurantId = json['restaurant_id'];
    }

    //todo: add restaurant address if present
    if (json['food_menu'].isNotEmpty) {
      foodMenu = new List<Category>();
      json['food_menu'].forEach((v) {
        foodMenu.add(new Category.fromJson(v));
      });
    }

//    print(json['bar_menu']);
    if (json['bar_menu'].isNotEmpty) {
      barMenu = new List<Category>();
      json['bar_menu'].forEach((v) {
        barMenu.add(new Category.fromJson(v));
      });
    }

    if (json['staff'].isNotEmpty) {
      staff = new List<Staff>();
      json['staff'].forEach((v) {
        staff.add(new Staff.fromJson(v));
      });
    }

    if (json['kitchen_staff'].isNotEmpty) {
      kitchenStaff = new List<KitchenStaff>();
      json['kitchen_staff'].forEach((v) {
        kitchenStaff.add(new KitchenStaff.fromJson(v));
      });
    }

    if (json['tables'].isNotEmpty) {
      tables = new List<Tables>();

      json['tables'].forEach((table) {
        tables.add(
          new Tables.fromRestJson(table, this.staff),
        );
      });
    }

    if (json['table_orders'].isNotEmpty) {
      tableOrders = new List<TableOrder>();
      json['table_orders'].forEach((v) {
        tableOrders.add(new TableOrder.fromJson(v));
      });
    }

    if (json['assistance_reqs'].isNotEmpty) {
      assistanceRequests = new List<AssistanceRequest>();
      json['assistance_reqs'].forEach((v) {
        assistanceRequests.add(new AssistanceRequest.fromJson(v));
      });
    }

    if (json['home_screen_tags'].isNotEmpty) {
      homeScreenTags = new List<String>();
      json['home_screen_tags'].forEach((v) {
        homeScreenTags.add(v);
      });
    }

    if (json['navigate_better_tags'].isNotEmpty) {
      navigateBetterTags = new List<String>();
      json['navigate_better_tags'].forEach((v) {
        navigateBetterTags.add(v);
      });
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

  addKitchenStaffDetails(data) {
    if (this.kitchenStaff == null) {
      this.kitchenStaff = new List<KitchenStaff>();
    }
    data.forEach((v) {
      this.kitchenStaff.add(new KitchenStaff.addConfig(v));
    });
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
  List<String> users; //todo: add scanned user details to table object

  List<TableOrder> tableOrders;
  List<AssistanceRequest> tableAssistanceRequest;

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
    this.tableAssistanceRequest,
//    this.tableQueuedOrders,
//    this.tableCookingOrders,
//    this.tableCompletedOrders,
    this.queueCount,
    this.cookingCount,
    this.completedCount,
  });

  Tables.fromJson(Map<String, dynamic> json) {
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
      json['staff'].forEach((v) {
        staff.add(v['\$oid']);
      });
    }

    if (json['users'].isNotEmpty) {
      users = new List<String>();
      json['users'].forEach((v) {
        users.add(v['\$oid']);
      });
    }

    if (json['table_orders'].isNotEmpty) {
      tableOrders = new List<TableOrder>();
      json['table_orders'].forEach((v) {
        tableOrders.add(new TableOrder.fromJson(v));
      });
    }

    if (json['assistance_reqs'].isNotEmpty) {
      tableAssistanceRequest = new List<AssistanceRequest>();
      json['assistance_reqs'].forEach((v) {
        tableAssistanceRequest.add(new AssistanceRequest.fromJson(v));
      });
    }
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
      users = new List<String>();
      json['users'].forEach((v) {
        users.add(v['\$oid']);
      });
    }

    if (json['table_orders'].isNotEmpty) {
      tableOrders = new List<TableOrder>();
      json['table_orders'].forEach((v) {
        tableOrders.add(new TableOrder.fromJson(v));
      });
    }

    if (json['assistance_reqs'].isNotEmpty) {
      tableAssistanceRequest = new List<AssistanceRequest>();
      json['assistance_reqs'].forEach((v) {
        tableAssistanceRequest.add(new AssistanceRequest.fromJson(v));
      });
    }
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

class Staff {
  String oid;
  String name;
  //todo: update assistance history and order history
  List<AssistanceRequest> assistanceHistory;
  List orderHistory;

  Staff({
    this.name,
    this.oid,
    this.assistanceHistory,
    this.orderHistory,
  });

  Staff.fromJson(Map<String, dynamic> json) {
    if (json['_id']['\$oid'] != null) {
      oid = json['_id']['\$oid'];
    }

    if (json['name'] != null) {
      name = json['name'];
    }

//    if (json['assistance_history'].isNotEmpty) {
//      //todo:check
//      assistanceHistory = new List<AssistanceRequest>();
//      json['assistance_history'].forEach((v) {
//        assistanceHistory.add(new AssistanceRequest.fromJson(v));
//      });
//    }
//    if (json['order_history'] != null) {
//      //todo:check
//      orderHistory = new List<OrderHistory>();
//      json['order_history'].forEach((v) {
//        orderHistory.add(new OrderHistory.fromJson(v));
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

class KitchenStaff {
  String oid;
  String name;

  KitchenStaff({
    this.name,
    this.oid,
  });
  KitchenStaff.fromJson(Map<String, dynamic> json) {
    if (json['_id']['\$oid'] != null) {
      oid = json['_id']['\$oid'];
    }

    if (json['name'] != null) {
      name = json['name'];
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
    description = category['description'];

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
    this.oid = edited['food_id'];
    this.name = edited['name'];
    this.description = edited['description'];
    this.price = edited['price'];
    print('added edited here');
    if (edited["food_options"] != null) {
      print('added edited here3');
      if (edited["food_options"]["options"] != null) {
        this.foodOption.options.clear();
        edited["food_options"]["options"].forEach((option) {
          this.foodOption.options.add(option);
        });
      }
      if (edited["food_options"]["choices"] != null) {
        this.foodOption.choices.clear();
        edited["food_options"]["choices"].forEach((choice) {
          this.foodOption.choices.add(choice);
        });
      }
    }
    print('added edited here45');
  }
}

class FoodOption {
  List<Map<String, dynamic>> options;
  List<String> choices;

  FoodOption({
    this.options,
    this.choices,
  });

  FoodOption.fromJson(Map<String, dynamic> json) {
//    print("while adding food iption");
//    print(json['options']);
    if (json['options'] != null) {
      options = new List<Map<String, dynamic>>();
      json['options'].forEach((option) {
//        print("here");
//        print(option["option_name"]);
//        print(option["option_price"]);
        options.add(option);

//        print("added");
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

//class MainCategory {
//  String oid;
//  String description;
//  String name;
//  List<SubCategory> subCategory;
//
//  MainCategory({
//    this.oid,
//    this.description,
//    this.name,
//    this.subCategory,
//  });
//
//  MainCategory.fromJson(Map<String, dynamic> json) {
//    oid = json['_id']['\$oid'];
//
//    name = json['name'];
//
//    description = json['description'];
//
//    if (json['sub_category'] != null) {
//      subCategory = new List<SubCategory>();
//      json['sub_category'].forEach((v) {
//        subCategory.add(new SubCategory.fromJson(v));
//      });
//    }
//  }
//
////  Map<String, dynamic> toJson() {
////    final Map<String, dynamic> data = new Map<String, dynamic>();
////    data['description'] = this.description;
////    data['name'] = this.name;
////    if (this.subCategory != null) {
////      data['sub_category'] = this.subCategory.map((v) => v.toJson()).toList();
////    }
////    return data;
////  }
//}
///////////////////////////////////////////////////////////////////////////////////
class TableOrder {
  String oId;
  String table;
  String tableId;
  List<Order> orders;
  String status = 'queued';

  DateTime timeStamp;

  TableOrder({
    this.oId,
    this.table,
    this.tableId,
    this.orders,
    this.status,
    this.timeStamp,
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

    if (json['timestamp'] != null) {
      timeStamp = DateTime.parse(json['timestamp']);
    }
  }

  TableOrder.fromJsonNew(Map<String, dynamic> json) {
    oId = json['oId'];

    table = json['table'];
    tableId = json['table_id'];
    status = json['status'];
    timeStamp = json['timestamp'];
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
    data['status'] = this.status;
    data['timestamp'] = this.timeStamp;
    return data;
  }
}

class Order {
  String oId;
  String placedBy;
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

    if (json['placed_by']['\$oid'] != null) {
      placedBy = json['placed_by']['\$oid'];
    }

    if (json['food_list'] != null) {
      foodList = new List<FoodItem>();
      json['food_list'].forEach((v) {
        foodList.add(FoodItem.fromJson(v));
      });
    }

    if (json['status'] != null) {
      placedBy = json['placed_by']['\$oid'];
    }
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

class AssistanceRequest {
  String oId;
  String user;
  String assistanceType;
  DateTime timeStamp;
  String acceptedBy; // directly provided by fetchAccepted() in main page
  String table;
  String tableId;

  AssistanceRequest({
    this.oId,
    this.user,
    this.assistanceType,
    this.timeStamp,
    this.acceptedBy,
    this.table,
    this.tableId,
  });
//    {table: table14, table_id: 5eb41b91adb66da6f531212d, assistance_type: ketchup,
//timestamp: 2020-05-12 13:11:11.544441, user_id: 5eba3ceadbecc1e361595049,
//user: Neptune_11, assistance_req_id: 5eba5317dbecc1e3615951e2,
//request_type: assistance_request, msg: Service has been requested}
  AssistanceRequest.fromJson(Map<String, dynamic> json) {
    if (json['_id']['\$oid'] != null) {
      oId = json['_id']['\$oid'];
    }

    if (json['table'] != null) {
      table = json['table'];
    }

    if (json['table_id'] != null) {
      tableId = json['table_id'];
    }

    if (json['user']['\$oid'] != null) {
      user = json['user']['\$oid'];
    }

    if (json['assistance_type'] != null) {
      assistanceType = json['assistance_type'];
    }

    if (json['timestamp'] != null) {
      timeStamp = DateTime.parse(json['timestamp']);
    }
  }

  AssistanceRequest.adding(Map<String, dynamic> json) {
    print("here ass ");
    if (json['assistance_req_id'] != null) {
      oId = json['assistance_req_id'];
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

    if (json['assistance_type'] != null) {
      assistanceType = json['assistance_type'];
    }

    if (json['timestamp'] != null) {
      timeStamp = DateTime.parse(json['timestamp']);
    }
  }
}

//"order_history": [
//{
//"table_order_id": "5eaebd6b792a3686411acc1d",
//"order_id": "5eaebd6b792a3686411acc1c",
//"food_id": "5ead65bfe1823a4f213256d7",
//"timestamp": "2020-05-03 18:20:48.997083"
//},]
class OrderHistory {
  String tableOrderId;
  String orderId;
  String foodId;
  DateTime timeStamp;

  OrderHistory({
    this.tableOrderId,
    this.orderId,
    this.foodId,
    this.timeStamp,
  });

  OrderHistory.fromJson(Map<String, dynamic> json) {
    print("order history");
    if (json['table_order_id'] != null) {
      tableOrderId = json['table_order_id'];
    }
    if (json['order_id'] != null) {
      orderId = json['order_id'];
    }

    if (json['food_id'] != null) {
      foodId = json['food_id'];
    }
    if (json['timestamp'] != null) {
      timeStamp = DateTime.parse(json['timestamp']);
    }
  }
}
