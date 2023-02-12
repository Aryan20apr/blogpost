class CategoriesModal {
  List<Category>? _data;
  String? _message;
  bool? _success;

  CategoriesModal({List<Category>? data, String? message, bool? success}) {
    if (data != null) {
      this._data = data;
    }
    if (message != null) {
      this._message = message;
    }
    if (success != null) {
      this._success = success;
    }
  }

  List<Category>? get data => _data;
  set data(List<Category>? data) => _data = data;
  String? get message => _message;
  set message(String? message) => _message = message;
  bool? get success => _success;
  set success(bool? success) => _success = success;

  CategoriesModal.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <Category>[];
      json['data'].forEach((v) {
        _data!.add(new Category.fromJson(v));
      });
    }
    _message = json['message'];
    _success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != null) {
      data['data'] = this._data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this._message;
    data['success'] = this._success;
    return data;
  }
}

class Category {
  int? _categoryId;
  String? _categoryTitle;
  String? _categoryDescription;

  Category({int? categoryId, String? categoryTitle, String? categoryDescription}) {
    if (categoryId != null) {
      this._categoryId = categoryId;
    }
    if (categoryTitle != null) {
      this._categoryTitle = categoryTitle;
    }
    if (categoryDescription != null) {
      this._categoryDescription = categoryDescription;
    }
  }

  int? get categoryId => _categoryId;
  set categoryId(int? categoryId) => _categoryId = categoryId;
  String? get categoryTitle => _categoryTitle;
  set categoryTitle(String? categoryTitle) => _categoryTitle = categoryTitle;
  String? get categoryDescription => _categoryDescription;
  set categoryDescription(String? categoryDescription) =>
      _categoryDescription = categoryDescription;

  Category.fromJson(Map<String, dynamic> json) {
    _categoryId = json['categoryId'];
    _categoryTitle = json['categoryTitle'];
    _categoryDescription = json['categoryDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this._categoryId;
    data['categoryTitle'] = this._categoryTitle;
    data['categoryDescription'] = this._categoryDescription;
    return data;
  }
}