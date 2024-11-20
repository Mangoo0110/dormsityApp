import 'package:dormsity/features/image/domain/usecases/save_image_with_reference_path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/utils/enums/common_enums.dart';
import '../../../../core/utils/func/dekhao.dart';
import '../../../../init_dependency.dart';
import '../../domain/usecases/fetch_image.dart';

class ImageWriteProvider extends ChangeNotifier{

  Uint8List? _image;
  String? _referencePath;
  SaveStatus _saveStatus = SaveStatus.canNotSave;

  //getters
  bool get canSave => _saveStatus != SaveStatus.canNotSave;

  Uint8List? get image => _image;

  String? get referencePath => _referencePath;

  void checkIfCanSave(){
    if(true){
      if(_saveStatus == SaveStatus.canNotSave){
        _saveStatus = SaveStatus.canNotSave; notifyListeners();
      }
    }
  }

  ImageWriteProvider();

  void init({required String? existingImageUrl, required String collectionName, required String docId}) {

    _saveStatus != SaveStatus.canNotSave; 
    _image = null;

    if(existingImageUrl != null && existingImageUrl.isNotEmpty) {
      _referencePath = FirebaseStorage.instance.refFromURL(existingImageUrl).fullPath;
    }

    _referencePath ??= FirebaseStorage.instance.ref(collectionName).child(docId).child(DateTime.now().millisecondsSinceEpoch.toString()).fullPath;
    dekhao("image path to save is $_referencePath");
    _image = image;
    if(_image == null && existingImageUrl != null) {
      getImageFromExistingUrl();
    }
  }

  Future<void> getImageFromExistingUrl() async{
    if(_referencePath == null) return;
    return await serviceLocator<FetchImage>().call(FetchImageParams(url: _referencePath!, forceFetch: false)).then((value) {
        return value.fold(
          (l) {
            return null;
          }, (r) {
            dekhao("fetched existingImageUrl ...");
            _image = r.image; notifyListeners();
          });
    });
  }
  
  void changeImage(Uint8List image){
    _image = image;
    _saveStatus = SaveStatus.canSave;
    notifyListeners();
  }


  Future<String?> saveImage() async{

    if(_saveStatus == SaveStatus.canSave && _image != null && _referencePath != null){
      dekhao("saving image.");
      return await serviceLocator<SaveImageWithReferencePath>().call(SaveImageWithReferencePathParams(referencePath: _referencePath!, imageData: _image!)).then((lr){
        return lr.fold (
          (l) {
            return null;
          }, 
          (r) {
            _image = null;
            _referencePath = null;
            _saveStatus != SaveStatus.canNotSave;
            return r;
          }
        );
      });
    }
    return null;
  }
}