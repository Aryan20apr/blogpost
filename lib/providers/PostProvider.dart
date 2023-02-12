import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class PostProvider extends ChangeNotifier
{
 bool _isUploaded=false;
 bool _isRemoved=false;
  get isRemoved => this._isRemoved;

 set isRemoved( value) => this._isRemoved = value;
  XFile? _imagefile=null;
  String? _imagename;

  String? _id;
  String? _name;
 String? get id => this._id;

 set id(String? value) => this._id = value;

  get name => this._name;

 set name( value) => this._name = value;
  //String? _imageSize;
 //String? get imageSize => this._imageSize;

 //set imageSize(String? value) => this._imageSize = value;
 bool get isUploaded => this._isUploaded;

 set isUploaded(bool value) => this._isUploaded = value;

  get imagefile => this._imagefile;

 set imagefile( value) => this._imagefile = value;

  get imagename => this._imagename;

 set imagename( value) => this._imagename = value;

void loadImage({required XFile? imagefile})
{
  _imagefile=imagefile;
  _imagename=imagefile!.name;
  //imageSize=imagefile.mimeType;
  _isUploaded=true;
  notifyListeners();
}
void updateImage({required XFile? imagefile})
{
  if(imagefile!=null)
 { _imagefile=imagefile;
  _imagename=imagefile.name;
  //imageSize=imagefile.mimeType;
  _isUploaded=true;}
  else
  {
   _isUploaded=false;
  
  _isRemoved=true;;
    _imagename=null;
  }
  print('${_isUploaded} ${_isRemoved}');
  notifyListeners();
}


void removeImage()
{
  _imagefile=null;
  _imagename=null;
  //imageSize=imagefile.mimeType;
  _isUploaded=false;
  notifyListeners();
}
void updateCategory(String categoryid)
{
  _id=categoryid;
  
  notifyListeners();
}

}