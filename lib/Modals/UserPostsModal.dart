

import 'CategoriesModal.dart';

class UserPostsModal {
  List<UserPostData>? _data;
  String? _message;
  bool? _success;

  UserPostsModal({List<UserPostData>? data, String? message, bool? success}) {
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

  List<UserPostData>? get data => _data;
  set data(List<UserPostData>? data) => _data = data;
  String? get message => _message;
  set message(String? message) => _message = message;
  bool? get success => _success;
  set success(bool? success) => _success = success;

  UserPostsModal.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <UserPostData>[];
      json['data'].forEach((v) {
        _data!.add(new UserPostData.fromJson(v));
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

class UserPostData {
  int? _postId;
  String? _title;
  String? _content;
  String? _imageName;
  String? _imageUrl;
  String? _addedDate;
  Category? _category;

  UserPostData(
      {int? postId,
      String? title,
      String? content,
      String? imageName,
      String? imageUrl,
      String? addedDate,
      Category? category}) {
    if (postId != null) {
      this._postId = postId;
    }
    if (title != null) {
      this._title = title;
    }
    if (content != null) {
      this._content = content;
    }
    if (imageName != null) {
      this._imageName = imageName;
    }
    if (imageUrl != null) {
      this._imageUrl = imageUrl;
    }
    if (addedDate != null) {
      this._addedDate = addedDate;
    }
    if (category != null) {
      this._category = category;
    }
  }

  int? get postId => _postId;
  set postId(int? postId) => _postId = postId;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get content => _content;
  set content(String? content) => _content = content;
  String? get imageName => _imageName;
  set imageName(String? imageName) => _imageName = imageName;
  String? get imageUrl => _imageUrl;
  set imageUrl(String? imageUrl) => _imageUrl = imageUrl;
  String? get addedDate => _addedDate;
  set addedDate(String? addedDate) => _addedDate = addedDate;
  Category? get category => _category;
  set category(Category? category) => _category = category;

  UserPostData.fromJson(Map<String, dynamic> json) {
    _postId = json['postId'];
    _title = json['title'];
    _content = json['content'];
    _imageName = json['imageName'];
    _imageUrl = json['imageUrl'];
    _addedDate = json['addedDate'];
    _category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this._postId;
    data['title'] = this._title;
    data['content'] = this._content;
    data['imageName'] = this._imageName;
    data['imageUrl'] = this._imageUrl;
    data['addedDate'] = this._addedDate;
    if (this._category != null) {
      data['category'] = this._category!.toJson();
    }
    return data;
  }
}

