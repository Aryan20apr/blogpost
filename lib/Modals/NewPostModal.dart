class NewPostModal {
  NewPostData? data;
  String? message;
  bool? success;

  NewPostModal({this.data, this.message, this.success});

  NewPostModal.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new NewPostData.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class NewPostData {
  int? postId;
  String? title;
  String? content;
  String? imageName;
  String? imageUrl;
  String? addedDate;

  NewPostData(
      {this.postId,
      this.title,
      this.content,
      this.imageName,
      this.imageUrl,
      this.addedDate});

  NewPostData.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    title = json['title'];
    content = json['content'];
    imageName = json['imageName'];
    imageUrl = json['imageUrl'];
    addedDate = json['addedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['imageName'] = this.imageName;
    data['imageUrl'] = this.imageUrl;
    data['addedDate'] = this.addedDate;
    return data;
  }
}