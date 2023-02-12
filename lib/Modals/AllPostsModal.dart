import 'CategoriesModal.dart';

class AllPostsModal {
  Data? _data;
  String? _message;
  bool? _success;

  AllPostsModal({Data? data, String? message, bool? success}) {
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

  Data? get data => _data;
  set data(Data? data) => _data = data;
  String? get message => _message;
  set message(String? message) => _message = message;
  bool? get success => _success;
  set success(bool? success) => _success = success;

  AllPostsModal.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    _message = json['message'];
    _success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    data['message'] = this._message;
    data['success'] = this._success;
    return data;
  }
}

class Data {
  List<Content>? _content;
  int? _pageNumber;
  int? _pageSize;
  int? _totalElements;
  int? _totalPages;
  bool? _lastPage;

  Data(
      {List<Content>? content,
      int? pageNumber,
      int? pageSize,
      int? totalElements,
      int? totalPages,
      bool? lastPage}) {
    if (content != null) {
      this._content = content;
    }
    if (pageNumber != null) {
      this._pageNumber = pageNumber;
    }
    if (pageSize != null) {
      this._pageSize = pageSize;
    }
    if (totalElements != null) {
      this._totalElements = totalElements;
    }
    if (totalPages != null) {
      this._totalPages = totalPages;
    }
    if (lastPage != null) {
      this._lastPage = lastPage;
    }
  }

  List<Content>? get content => _content;
  set content(List<Content>? content) => _content = content;
  int? get pageNumber => _pageNumber;
  set pageNumber(int? pageNumber) => _pageNumber = pageNumber;
  int? get pageSize => _pageSize;
  set pageSize(int? pageSize) => _pageSize = pageSize;
  int? get totalElements => _totalElements;
  set totalElements(int? totalElements) => _totalElements = totalElements;
  int? get totalPages => _totalPages;
  set totalPages(int? totalPages) => _totalPages = totalPages;
  bool? get lastPage => _lastPage;
  set lastPage(bool? lastPage) => _lastPage = lastPage;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      _content = <Content>[];
      json['content'].forEach((v) {
        _content!.add(new Content.fromJson(v));
      });
    }
    _pageNumber = json['pageNumber'];
    _pageSize = json['pageSize'];
    _totalElements = json['totalElements'];
    _totalPages = json['totalPages'];
    _lastPage = json['lastPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._content != null) {
      data['content'] = this._content!.map((v) => v.toJson()).toList();
    }
    data['pageNumber'] = this._pageNumber;
    data['pageSize'] = this._pageSize;
    data['totalElements'] = this._totalElements;
    data['totalPages'] = this._totalPages;
    data['lastPage'] = this._lastPage;
    return data;
  }
}

class Content {
  int? _postId;
  String? _title;
  String? _content;
  String? _imageName;
  String? _imageUrl;
  String? _addedDate;
  Category? _category;
  User? _user;

  Content(
      {int? postId,
      String? title,
      String? content,
      String? imageName,
      Null? imageUrl,
      String? addedDate,
      Category? category,
      User? user}) {
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
    if (user != null) {
      this._user = user;
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
  User? get user => _user;
  set user(User? user) => _user = user;

  Content.fromJson(Map<String, dynamic> json) {
    _postId = json['postId'];
    _title = json['title'];
    _content = json['content'];
    _imageName = json['imageName'];
    _imageUrl = json['imageUrl'];
    _addedDate = json['addedDate'];
    _category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    _user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
    if (this._user != null) {
      data['user'] = this._user!.toJson();
    }
    return data;
  }
}

class User {
  int? _id;
  String? _firstname;
  String? _lastname;
  String? _email;

  User({int? id, String? firstname, String? lastname, String? email}) {
    if (id != null) {
      this._id = id;
    }
    if (firstname != null) {
      this._firstname = firstname;
    }
    if (lastname != null) {
      this._lastname = lastname;
    }
    if (email != null) {
      this._email = email;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get firstname => _firstname;
  set firstname(String? firstname) => _firstname = firstname;
  String? get lastname => _lastname;
  set lastname(String? lastname) => _lastname = lastname;
  String? get email => _email;
  set email(String? email) => _email = email;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _firstname = json['firstname'];
    _lastname = json['lastname'];
    _email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['firstname'] = this._firstname;
    data['lastname'] = this._lastname;
    data['email'] = this._email;
    return data;
  }
}