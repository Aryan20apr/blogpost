class OTPVerifyModal {
  String? _data;
  String? _message;
  bool? _success;

  OTPVerifyModal({String? data, String? message, bool? success}) {
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

  String? get data => _data;
  set data(String? data) => _data = data;
  String? get message => _message;
  set message(String? message) => _message = message;
  bool? get success => _success;
  set success(bool? success) => _success = success;

  OTPVerifyModal.fromJson(Map<String, dynamic> json) {
    _data = json['data'];
    _message = json['message'];
    _success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this._data;
    data['message'] = this._message;
    data['success'] = this._success;
    return data;
  }
}