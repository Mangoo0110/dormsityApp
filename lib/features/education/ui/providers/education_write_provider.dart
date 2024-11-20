
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/utils/enums/common_enums.dart';
import '../../domain/usecases/create_education.dart';

import '../../../../core/utils/classes/domain.dart';
import '../../../../core/utils/func/dekhao.dart';
import '../../../../core/utils/uuid_service/firebase_uid.dart';
import '../../../../init_dependency.dart';
import '../../domain/entities/degree_field_of_study.dart';
import '../../domain/entities/education_private.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../../../page_entity/domain/entities/institute_public.dart';

class EducationWriteProvider extends ChangeNotifier {
 SaveStatus _saveStatus = SaveStatus.canNotSave;
  EducationPrv? _newEducation;

  DateTime? _startDate;
  DateTime? _endDate;
  InstitutePub? _institute;
  String _studentId = '';
  String _email = '';
  Degree? _degree;



  EducationWriteProvider();

  //getters

  SaveStatus get saveStatus => _saveStatus;
  InstitutePub? get institute => _institute;
  String get studentID => _studentId;
  String get email => _email;
  String get contactNo => _newEducation?.contactNo ?? '';
  String get instituteName => _institute?.pageName ?? '';
  String get instituteDomain => _institute?.domain ?? '';
  Degree? get degree => _degree;
  String get startDate => _startDate == null ? '' : DateFormat.yMMMM().format(_startDate!);
  String get endDate => _endDate == null ? '' : DateFormat.yMMMM().format(_endDate!);


  void init({required String currentUserId}) {
    
    _newEducation = null; _institute = null; _saveStatus = SaveStatus.canNotSave;

    _newEducation = EducationPrv.newInstance(newDocId: uuidByFirebaseSdk(), currentUserId: currentUserId);

    _startDate = _newEducation?.startDate;
    _endDate = _newEducation?.endDate;
    _studentId = _newEducation!.studentId;
    _degree = _newEducation?.degree;
    _email = _newEducation!.email;
  }

  void _checkIfCanSave(){

    if(_hasCompulsoryFieldsData()) {
      dekhao("_hasCompulsoryFieldsData true");
      if(_saveStatus != SaveStatus.canSave) {
        _saveStatus = SaveStatus.canSave; notifyListeners();
      }
    } else {
      dekhao("_hasCompulsoryFieldsData false");
      if(_saveStatus != SaveStatus.canNotSave) {
        _saveStatus = SaveStatus.canNotSave; notifyListeners();
      }
    }

  }

  bool _hasCompulsoryFieldsData(){
    return _newEducation != null &&
        _newEducation?.institutionDomain != null &&
        _newEducation?.studentId != null &&
        _newEducation?.userId != null &&
        _newEducation?.startDate != null &&
        _newEducation?.endDate != null &&
        _newEducation?.institutionName != null &&
        _newEducation?.approveDetails == null;
  }

  void editStudentId(String studentId){
    dekhao("editStudentId ..............");
    studentId = studentId.trim();
    _studentId = studentId;
    _newEducation?.studentId = studentId;
    _checkIfCanSave();
  }

  void editEmail(String email){
    _newEducation?.email = email;
    _checkIfCanSave();
  }

  void editContactNo(String contactNo){
    _newEducation?.contactNo = contactNo;
    _checkIfCanSave();
  }

  void editInstitution(InstitutePub institute){
    if(DomainUrl.tryParse(institute.domain ?? '') == null || institute == _institute) {
      _newEducation?.institutionDomain = '';
      return;
    }

    _institute = institute;
    _newEducation?.institutionName = institute.pageName;
    _newEducation?.institutionDomain = institute.domain!;
    
    //Nullify every other fields
    _startDate = null;
    _endDate = null;
    _studentId = "";
    _degree = null;
    _email = '';
    notifyListeners();

    _checkIfCanSave();
  }

  void editDegree(Degree degree){
    _newEducation?.degree = degree;
    _degree = degree;
    _startDate = null;
    _newEducation?.startDate = DateTime.now();
    _endDate = null;
    _newEducation?.endDate = null;
    notifyListeners();
    _checkIfCanSave();
  }

  void editStartDate(DateTime startDate){
    _newEducation?.startDate = startDate;
    _startDate = startDate;
    _endDate = null;
    _newEducation?.endDate = null;
    notifyListeners();
    _checkIfCanSave();
  }

  void editEndDate(DateTime endDate){
    dekhao("changing endDate $endDate");
    if(_startDate == null){
      Fluttertoast.showToast(msg: "Start date is empty!");
      return;
    }

    if(_startDate!.isAfter(endDate)){
      Fluttertoast.showToast(msg: "Start date can not be after end date.");
      return;
    }
    _newEducation?.endDate = endDate;
    _endDate = endDate;
    notifyListeners();
    _checkIfCanSave();
  }


  Future<void> createEducation() async{
    if(_newEducation == null || _saveStatus != SaveStatus.canSave) return;
    _saveStatus = SaveStatus.saving; notifyListeners();
    try {
      await serviceLocator<CreateEducation>().call(_newEducation!).then((lr){
        return lr.fold(
          (l){
            _saveStatus = SaveStatus.failed; notifyListeners();
            return;
          }, 
          (r){
            _saveStatus = SaveStatus.saved; notifyListeners();
            _newEducation = null; _institute = null;
            _nullify();
          }
        );
      });
    } catch (e) {
      dekhao(e.toString());
      _saveStatus = SaveStatus.failed; notifyListeners();
      return;
    }
  }


  void _nullify() {
    _institute = null;
    _startDate = null;
    _endDate = null;
    _studentId = "";
    _degree = null;
    _email = '';
  }

}
