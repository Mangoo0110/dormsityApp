import 'package:dormsity/core/utils/classes/approve_details.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../auth/data/datasources/remote/auth_remote_datasource.dart';
import '../../domain/entities/education_private.dart';
import 'package:flutter/material.dart';

import '../../../../init_dependency.dart';
import '../../domain/usecases/admin_approve_education.dart';
import '../../domain/usecases/disapprove_education.dart';

enum EducationApproveStatus {approving, disApproving, failed, inquiring, done}

class EducationInquiryProvider extends ChangeNotifier{
  EducationPrv? _education;
  EducationApproveStatus _educationApproveStatus = EducationApproveStatus.inquiring;

  //getters
  EducationApproveStatus get educationApproveStatus => _educationApproveStatus;


  void init(EducationPrv education) {
    _education = education;
    _educationApproveStatus = EducationApproveStatus.inquiring;
  }


  /// **Only institute-admin feature.**
  Future<void> approveEducation({required UserAuth userAuth}) async{
    // if(true) {
    //   _educationApproveStatus = EducationApproveStatus.approving; notifyListeners();
    //   return;
    // }
    if(_education == null) return;
    _educationApproveStatus = EducationApproveStatus.approving; notifyListeners();
    return await serviceLocator<ApproveEducation>().call(
      ApproveEducationParams(educationPrv: _education!, approveDetails: ApproveDetails(approvedBy: userAuth.id, approvedAt: DateTime.now()))
    ).then((lr){
      lr.fold(
        (l){
          _educationApproveStatus = EducationApproveStatus.failed; notifyListeners();
          Fluttertoast.showToast(msg: "Failed to approve the education.");
        }, 
        (r){
          _educationApproveStatus = EducationApproveStatus.done; notifyListeners();
          Fluttertoast.showToast(msg: "Approved education.");
          _education = null;
        });
    });
  }


  Future<void> disApproveEducation() async{
    // if(true) {
    //   _educationApproveStatus = EducationApproveStatus.disApproving; notifyListeners();
    //   return;
    // }
    if(_education == null) return;
    _educationApproveStatus = EducationApproveStatus.disApproving; notifyListeners();

    return await serviceLocator<DisApproveEducation>().call(_education!).then((lr){
      lr.fold(
        (l){
          _educationApproveStatus = EducationApproveStatus.failed; notifyListeners();
          Fluttertoast.showToast(msg: "Failed to disapprove and delete the education.");
        }, 
        (r){
          _educationApproveStatus = EducationApproveStatus.done; notifyListeners();
          Fluttertoast.showToast(msg: "Education is deleted.");
          _education = null;
        });
    });
  }
}