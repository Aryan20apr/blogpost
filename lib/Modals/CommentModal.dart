class CommentsListDTO {
  List<CommentData>? _data;
  String? _message;
  bool? _success;

  CommentsListDTO({List<CommentData>? data, String? message, bool? success}) {
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

  List<CommentData>? get data => _data;
  set data(List<CommentData>? data) => _data = data;
  String? get message => _message;
  set message(String? message) => _message = message;
  bool? get success => _success;
  set success(bool? success) => _success = success;

  CommentsListDTO.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <CommentData>[];
      json['data'].forEach((v) {
        _data!.add(new CommentData.fromJson(v));
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







class Comment {
  CommentData? _data;
  String? _message;
  bool? _success;

  Comment({CommentData? data, String? message, bool? success}) {
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

  CommentData? get data => _data;
  set data(CommentData? data) => _data = data;
  String? get message => _message;
  set message(String? message) => _message = message;
  bool? get success => _success;
  set success(bool? success) => _success = success;

  Comment.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? new CommentData.fromJson(json['data']) : null;
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

class CommentData {
  int? _id;
  String? _content;
  int? _date;
  String? _firstname;
  String? _lastname;

  CommentData(
      {int? id,
      String? content,
      int? date,
      String? firstname,
      String? lastname}) {
    if (id != null) {
      this._id = id;
    }
    if (content != null) {
      this._content = content;
    }
    if (date != null) {
      this._date = date;
    }
    if (firstname != null) {
      this._firstname = firstname;
    }
    if (lastname != null) {
      this._lastname = lastname;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get content => _content;
  set content(String? content) => _content = content;
  int? get date => _date;
  set date(int? date) => _date = date;
  String? get firstname => _firstname;
  set firstname(String? firstname) => _firstname = firstname;
  String? get lastname => _lastname;
  set lastname(String? lastname) => _lastname = lastname;

  CommentData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _content = json['content'];
    _date = json['date'];
    _firstname = json['firstname'];
    _lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['content'] = this._content;
    data['date'] = this._date;
    data['firstname'] = this._firstname;
    data['lastname'] = this._lastname;
    return data;
  }
}