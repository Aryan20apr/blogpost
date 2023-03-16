class UserModal {
  UserData? _userData;
  String? _message;
  bool? _success;

  UserModal({UserData? data, String? message, bool? success}) {
    if (data != null) {
      this._userData = data;
    }
    if (message != null) {
      this._message = message;
    }
    if (success != null) {
      this._success = success;
    }
  }

  UserData? get userData => _userData;
  set userData(UserData? data) => _userData = data;
  String? get message => _message;
  set message(String? message) => _message = message;
  bool? get success => _success;
  set success(bool? success) => _success = success;

  UserModal.fromJson(Map<String, dynamic> json) {
    _userData = json['data'] != null ? new UserData.fromJson(json['data']) : null;
    _message = json['message'];
    _success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._userData != null) {
      data['data'] = this._userData!.toJson();
    }
    data['message'] = this._message;
    data['success'] = this._success;
    return data;
  }
}

class UserData {
  int? _id;
  String? _firstname;
  String? _lastname;
  String? _email;
  String? _password;
  String? _about;
  String? _image;
  String? _imageurl;
  List<int>? _catids;

  UserData(
      {int? id,
      String? firstname,
      String? lastname,
      String? email,
      String? password,
      String? about,
      String? image,
      String? imageurl,
      List<int>? catids}) {
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
    if (password != null) {
      this._password = password;
    }
    if (about != null) {
      this._about = about;
    }
    if (image != null) {
      this._image = image;
    }
    if (imageurl != null) {
      this._imageurl = imageurl;
    }
    if (catids != null) {
      this._catids = catids;
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
  String? get password => _password;
  set password(String? password) => _password = password;
  String? get about => _about;
  set about(String? about) => _about = about;
  String? get image => _image;
  set image(String? image) => _image = image;
  String? get imageurl => _imageurl;
  set imageurl(String? imageurl) => _imageurl = imageurl;
   List<int>? get catids => _catids;
  set catids(List<int>? catids) => _catids = catids;

  UserData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _firstname = json['firstname'];
    _lastname = json['lastname'];
    _email = json['email'];
    _password = json['password'];
    _about = json['about'];
    _image = json['image'];
    _imageurl = json['imageurl'];
     _catids = json['catids'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['firstname'] = this._firstname;
    data['lastname'] = this._lastname;
    data['email'] = this._email;
    data['password'] = this._password;
    data['about'] = this._about;
    data['image'] = this._image;
    data['imageurl'] = this._imageurl;
    data['catids'] = this._catids;
    return data;
  }
}

