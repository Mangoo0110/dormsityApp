import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../core/utils/constants/data_field_key_names.dart';
import '../../models/complain_model.dart';

abstract interface class ComplainRemoteDatasource{
  Future<void> saveComplain({required ComplainModel complain,});

  Future<void> deleteComplain({required ComplainModel complain});

  void fetchAllComplains();

  SplayTreeMap<String, ComplainModel> get complainMap;
}

// class ComplainFirebaseImpl implements ComplainRemoteDatasource{

//   final SplayTreeMap<String, ComplainModel> _complains = SplayTreeMap<String, ComplainModel>();
//   ComplainModel? _lastFetchedComplain;

//   final _paginationLimit = 20;

//   bool _paginating = false;

//   static ComplainFirebaseImpl? _instance;

//   ComplainFirebaseImpl._(){
//     fetchAllComplains();
//   }

//   static ComplainFirebaseImpl get instance {
//     _instance ??= ComplainFirebaseImpl._();
//     return _instance!;
//   }

//   @override
//   SplayTreeMap<String, ComplainModel> get complainMap => _complains;

//   CollectionReference<Map<String, dynamic>> _complainCollectionReference() {
//     // if(AuthFirebaseImpl.instance.currentUserAuth == null) return null;
//     return FirebaseFirestore.instance
//         .collection(kFirestoreComplainCollection);
//   }


//   @override
//   Future<void> deleteComplain({required ComplainModel complain}) async{
//     await _complainCollectionReference().doc(complain.id).delete();
//   }

//   @override
//   void fetchAllComplains() async{

//     if(_paginating == true) return;

//     _paginating = true;
//     if(_lastFetchedComplain == null) {

//       await _complainCollectionReference().orderBy(kupdatedAt).limit(_paginationLimit).get().then((value) {
//         _paginating = false;
//         for (var element in value.docs) { 
//           try {
//             final complain = ComplainModel.fromMap(map: element.data());
//             _complains[complain.id] = complain;
//           } catch (e) {
//             null;
//           }
//         }
//       });

//     }
//   }

//   @override
//   Future<void> saveComplain({required ComplainModel complain}) async{
//     await _complainCollectionReference().doc(complain.id).set(complain.toMap());
//   }

// }

