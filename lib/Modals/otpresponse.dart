class OTPResponse {
  String? _email;
  String? _message;
  bool? _success;

  OTPResponse({String? email, String? message, bool? success}) {
    if (email != null) {
      this._email = email;
    }
    if (message != null) {
      this._message = message;
    }
    if (success != null) {
      this._success = success;
    }
  }

  String? get email => _email;
  set email(String? email) => _email = email;
  String? get message => _message;
  set message(String? message) => _message = message;
  bool? get success => _success;
  set success(bool? success) => _success = success;

  OTPResponse.fromJson(Map<String, dynamic> json) {
    _email = json['email'];
    _message = json['message'];
    _success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this._email;
    data['message'] = this._message;
    data['success'] = this._success;
    return data;
  }
}