import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/utils/enums/common_enums.dart';
import '../../../../core/utils/func/dekhao.dart';
import '../../../../init_dependency.dart';
import '../../domain/entities/institute_public.dart';
import '../../domain/usecases/update_institute_page_bio.dart';

class InstitutePageUpdateBioProvider extends ChangeNotifier{

  SaveStatus _saveStatus = SaveStatus.canNotSave;

  InstitutePub _institutePub;
  late UpdateInstitutePageBioParams _institutePageBioParams;

  InstitutePageUpdateBioProvider(this._institutePub){
    _institutePageBioParams = UpdateInstitutePageBioParams(_institutePub);
  }

  //getters
  // String get docId => _institutePageBioParams.docId;
  // String get instituteName => _institutePageBioParams.pageName;
  // String get address => _institutePageBioParams.location.fullAddress ?? '';
  SaveStatus get saveStatus => _saveStatus;


  void checkIfCanSave() {
    dekhao("checking save ${_saveStatus.name}");
    if(_institutePageBioParams.isBioChanged()) {
      if(_saveStatus != SaveStatus.canSave) {
        _saveStatus = SaveStatus.canSave; notifyListeners();
      }
    } else {
      if(_saveStatus != SaveStatus.canNotSave) {
        _saveStatus = SaveStatus.canNotSave; notifyListeners();
      }
    }

    dekhao("finished checking save ${_saveStatus.name}");
  }



  void setInstituteName(String name) {
    _institutePageBioParams.pageName = name.trim();
    checkIfCanSave();
  }



  void setAddress(String address) {
    _institutePageBioParams.location.fullAddress = address.trim();
    checkIfCanSave();
  }


  Future<void> updateInstituteBio() async{
    if(_saveStatus != SaveStatus.canNotSave) {
      _saveStatus = SaveStatus.saving; notifyListeners();
      await serviceLocator<UpdateInstitutePageBio>().call(_institutePageBioParams).then((lr){
        return lr.fold(
          (l){
            Fluttertoast.showToast(msg: "Failed! Some error occured ${l.message}");
            dekhao("Error UpdateInstitutePageBio ${l.message}");
            _saveStatus = SaveStatus.failed; notifyListeners();
          }, (r){
            Fluttertoast.showToast(msg: "Done.");
            _saveStatus = SaveStatus.saved;
            notifyListeners();
          });
      });
    }
    
  }


}