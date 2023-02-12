class SubscriptionResponseModal {
  List<int>? _data;
  String? _message;
  bool? _success;

  SubscriptionResponseModal({List<int>? data, String? message, bool? success}) {
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

  List<int>? get data => _data;
  set data(List<int>? data) => _data = data;
  String? get message => _message;
  set message(String? message) => _message = message;
  bool? get success => _success;
  set success(bool? success) => _success = success;

  SubscriptionResponseModal.fromJson(Map<String, dynamic> json) {
    _data = json['data'].cast<int>();
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