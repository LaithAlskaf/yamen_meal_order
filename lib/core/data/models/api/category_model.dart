class CategoryModel {
  int? id;
  String? name;
  String? logo;
  List<MealModel>? mealModel;

  CategoryModel({this.id, this.name, this.logo, this.mealModel});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    if (json['meal_model'] != null) {
      mealModel = <MealModel>[];
      json['meal_model'].forEach((v) {
        mealModel!.add( MealModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['logo'] = logo;
    if (mealModel != null) {
      data['meal_model'] = mealModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MealModel {
  String? name;
  int? mealId;
  int? categoryId;
  int? price;
  List<String>? images;

  MealModel({this.name, this.mealId, this.categoryId, this.price, this.images});

  MealModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mealId = json['mealId'];
    categoryId = json['categoryId'];
    price = json['price'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['mealId'] = mealId;
    data['categoryId'] = categoryId;
    data['price'] = price;
    data['images'] = images;
    return data;
  }
}