
import 'package:dormsity/core/utils/enums/page_enums.dart';
import 'package:dormsity/core/utils/uuid_service/firebase_uid.dart';
import 'package:dormsity/features/page_entity/domain/entities/page_private.dart';

import '../../../../core/utils/enums/common_enums.dart';

import '../../../../core/utils/classes/domain.dart';
import '../../../../core/utils/func/dekhao.dart';
import '../../../auth/data/datasources/remote/auth_remote_datasource.dart';
import '../../domain/entities/institute_public.dart';
import '../../domain/usecases/save_institute.dart';

import '../../../../init_dependency.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class InstitutePageWriteProvider extends ChangeNotifier {

  SaveStatus _saveStatus = SaveStatus.canNotSave;

  InstitutePub? _oldInstitutePrv;
  InstitutePub? _newInstitute;


  //getters
  String get docId => _newInstitute?.docId ?? '';
  String get domain => _newInstitute?.domain ?? '';
  String get instituteName => _newInstitute?.pageName ?? '';
  String get address => _newInstitute?.location.fullAddress ?? '';
  SaveStatus get saveStatus => _saveStatus;


  void init({required InstitutePub? oldInstitutePrv, required UserAuth userAuth}) {

    _oldInstitutePrv = oldInstitutePrv;
    _saveStatus = SaveStatus.canNotSave;

    if (_oldInstitutePrv != null) {
      _newInstitute = _oldInstitutePrv!;
    } else {
      _newInstitute = InstitutePub(
        docId: uuidByFirebaseSdk(),
        logoUrl: '',
        domain: '',
        pageName: '',
        location: LocationDetail(),
        createdBy: userAuth.id,
        adminIds: [userAuth.id], 
        pageType: PageType.institute, 
        impression: 0, 
        description: '', 
        public: true, 
        channelList: [],
        approved: false, deActivated: false,
      );
    }
  }

  void checkIfCanSave() {
    dekhao("checking save ${_saveStatus.name}");
    if(_newInstitute != null && _oldInstitutePrv != _newInstitute 
        && DomainUrl.tryParse(_newInstitute!.domain) != null 
        && _newInstitute!.pageName.isNotEmpty 
        && (_newInstitute!.location.fullAddress ?? '').isNotEmpty
    ) {
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

  void setDomain(String domain) {
    if(_newInstitute == null) return;
    _newInstitute!.domain = domain.trim();
    checkIfCanSave();
  }

  void setInstituteName(String name) {
    if(_newInstitute == null) return;
    _newInstitute!.pageName = name.trim();
    checkIfCanSave();
  }

  void setLogoUrl(String url) {
    if(_newInstitute == null) return;
    _newInstitute!.logoUrl = url;
  }

  void setAddress(String address) {
    if(_newInstitute == null) return;
    _newInstitute!.location.fullAddress = address.trim();
    checkIfCanSave();
  }


  Future<void> saveInstitute() async{
    if(_newInstitute == null) return;
    if(_saveStatus != SaveStatus.canNotSave) {
      _saveStatus = SaveStatus.saving; notifyListeners();
      await serviceLocator<SaveInstitute>().call(_newInstitute!).then((lr){
        return lr.fold(
          (l){
            Fluttertoast.showToast(msg: "Failed! Some error occured ${l.message}");
            dekhao("Error doing saveInstitute ${l.message}");
            _saveStatus = SaveStatus.failed; notifyListeners();
          }, (r){
            Fluttertoast.showToast(msg: "Done.");
            _saveStatus = SaveStatus.saved;
            notifyListeners();
          });
      });
    }
    
  }


  void dump(){
    _saveStatus = SaveStatus.canNotSave;

    _oldInstitutePrv = null;
    _newInstitute = null;
  }

}
