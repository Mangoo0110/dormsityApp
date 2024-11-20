import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../core/utils/classes/approve_details.dart';
import '../../../../../core/utils/classes/domain.dart';
import '../../../../../core/utils/func/dekhao.dart';
import '../../models/degree_field_of_study_model.dart';
import '../../models/education_public_model.dart';
import '../../models/education_private_model.dart';
import '../../../../../core/utils/constants/data_field_key_names.dart';



abstract interface class EducationRemoteDataSource {

  Future<void> createEducation({required EducationPrvModel educationPrv, required EducationPubModel educationPub});

  Future<void> approveEducation({required EducationPrvModel educationPrv, required ApproveDetails approveDetails});

  Future<void> disApproveEducation({required EducationPrvModel educationPrv});

  Future<void> approveGraduationComplete({required EducationPrvModel educationPrv});

  /// Only admins of respective institutions can do a successful fetch of private education list.
  Future<List<EducationPrvModel>> instituteApprovedEducations({required String institutionDomain, required int paginationLimit}); 

  ///Returns list of [EducationPubModel] of an user.
  Future<List<EducationPubModel>> fetchEducationsOfUser({required String userId});

  Future<List<EducationPrvModel>> institutePendingEducations({required String institutionDomain, required int paginationLimit});

  Future<List<EducationPrvModel>> searchByIdOrEmail({required String institutionDomain, required String studentIdOrEmail});
  
  Future<List<DegreeModel>> searchDegrees({required String searchText, required DomainUrl instituteDomain, int? paginationLimit, String? lastDegree });


}




class EducationFirebaseImpl implements EducationRemoteDataSource{

  static EducationFirebaseImpl? _instance;

  Timestamp? _oldest;
  Timestamp? _oldestNa;

  Timestamp? _newest;
  Timestamp? _newestNa;

  CollectionReference<Map<String,dynamic>> _educationPrivateCollection(){
    return FirebaseFirestore.instance.collection(FirestoreEducationPrv.kCollection);
  }

  CollectionReference<Map<String,dynamic>> _educationPublicCollection(){
    return FirebaseFirestore.instance.collection(FirestoreEducationPub.kCollection);
  }

  CollectionReference<Map<String,dynamic>> _degreeCollection(){
    return FirebaseFirestore.instance.collection(FirestoreDegree.kCollection);
  }


  EducationFirebaseImpl._();

  //getters
  static EducationFirebaseImpl get instance {
    _instance ??= EducationFirebaseImpl._();
    return _instance!;
  }

  List<DegreeModel> _degrees = []; 
  
  @override
  Future<void> approveGraduationComplete({required EducationPrvModel educationPrv}) async{
    UnimplementedError();
  }
  
  @override
  Future<void> approveEducation({required EducationPrvModel educationPrv, required ApproveDetails approveDetails}) async{
    WriteBatch batch = FirebaseFirestore.instance.batch();

    batch.update(_educationPrivateCollection().doc(educationPrv.docId), {FirestoreEducationPrv.kapproveDetails : approveDetails.toMap()});
    batch.update(_educationPublicCollection().doc(educationPrv.docId),{FirestoreEducationPub.kinstitutionApproved : true});

    return await batch.commit();

  }

  @override
  Future<void> disApproveEducation({required EducationPrvModel educationPrv}) async{
    WriteBatch batch = FirebaseFirestore.instance.batch();

    batch.delete(_educationPrivateCollection().doc(educationPrv.docId),);
    batch.delete(_educationPublicCollection().doc(educationPrv.docId),);

    return await batch.commit();
  }
  
  @override
  Future<List<EducationPrvModel>> instituteApprovedEducations({required String institutionDomain, required int paginationLimit}) async{
    List<EducationPrvModel> res = [];

    await _educationPrivateCollection()
        .where(FirestoreEducationPrv.kinstitutionDomain, isEqualTo: institutionDomain)
        .where(FirestoreEducationPrv.klastWriteAt, isGreaterThan: _newestNa ?? Timestamp.now(), isLessThan: _oldestNa ?? Timestamp.now())
        .limit(paginationLimit)
        .get().then((qSnapMap){
          for(final qDocSnap in qSnapMap.docs) {
            try {
              res.add(EducationPrvModel.fromMap(qDocSnap.data()));
            } catch (e) {
              "";
            }
          }
        });

    if(res.isEmpty) return res;

    if(_oldest == null || _greaterThanTime(_oldest!, Timestamp.fromDate(res.last.lastWriteAt))) {
      _oldest = Timestamp.fromDate(res.last.lastWriteAt);
    }

    if(_newest == null || _smallerThanTime(_newest!, Timestamp.fromDate(res.first.lastWriteAt))) {
      _newest = Timestamp.fromDate(res.first.lastWriteAt);
    }

    return res;
  }
  
  @override
  Future<void> createEducation({required EducationPrvModel educationPrv, required EducationPubModel educationPub}) async{
    WriteBatch batch = FirebaseFirestore.instance.batch();

    batch.set(_educationPrivateCollection().doc(educationPrv.docId), educationPrv.toMap());
    batch.set(_educationPublicCollection().doc(educationPrv.docId), educationPub.toMap());

    return await batch.commit();
  }
  
  @override
  Future<List<EducationPubModel>> fetchEducationsOfUser({required String userId}) async{
    dekhao("Executing fetchEducationsOfUser");
    return await _educationPublicCollection()
        .where(FirestoreEducationPub.kuserId, isEqualTo: userId)
        .get().then((qSnapMap){
          dekhao("fetched ${qSnapMap.docs.length} docs");
          List<EducationPubModel> educationList = [];

          for(final doc in qSnapMap.docs) {
            try {
              educationList.add(EducationPubModel.fromMap(doc.data()));
            } catch (e) {
              dekhao("Format Error: $e");
            }
          }
          return educationList;
        });
  }
  
  @override
  Future<List<EducationPrvModel>> institutePendingEducations({required String institutionDomain, required int paginationLimit}) async{

    List<EducationPrvModel> res = [];

    dekhao("executing remote/EducationFirebaseImpl institutePendingEducations $institutionDomain");

    try {
      await _educationPrivateCollection()
        .where(FirestoreEducationPrv.kinstitutionDomain, isEqualTo: institutionDomain)
        .where(FirestoreEducationPrv.kapproveDetails, isNull: true)
        // .where(FirestoreEducationPrv.klastWriteAt, isGreaterThan: _newestNa ?? Timestamp.now(), isLessThan: _oldestNa ?? Timestamp.now())
        //.limit(paginationLimit)
        .get().then((qSnapMap){
          dekhao("qSnapMap length ${qSnapMap.docs.length}");
          for(final qDocSnap in qSnapMap.docs) {
            try {
              res.add(EducationPrvModel.fromMap(qDocSnap.data()));
            } catch (e) {
              dekhao(e);
            }
          }
        });
    } catch (e) {
      dekhao(e.toString());
      rethrow;
    }

    if(res.isEmpty) return res;

    // if(_oldestNa == null || _greaterThanTime(_oldestNa!, Timestamp.fromDate(res.last.lastWriteAt))) {
    //   _oldestNa = Timestamp.fromDate(res.last.lastWriteAt);
    // }

    // if(_newestNa == null || _smallerThanTime(_newestNa!, Timestamp.fromDate(res.first.lastWriteAt))) {
    //   _newestNa = Timestamp.fromDate(res.first.lastWriteAt);
    // }

    return res;
  }
  
  @override
  Future<List<EducationPrvModel>> searchByIdOrEmail({required String institutionDomain, required String studentIdOrEmail}) async{
    List<EducationPrvModel> res = await _educationPrivateCollection()
        .where(FirestoreEducationPrv.kinstitutionDomain, isEqualTo: institutionDomain)
        .where(FirestoreEducationPrv.kstudentId, isEqualTo: studentIdOrEmail).limit(1)
        .get().then((qSnapMap){
          return qSnapMap.docs
            .map((qDocSnap) => EducationPrvModel.fromMap(qDocSnap.data()))
            .toList();
        });

    
    List<EducationPrvModel> res2 = await _educationPrivateCollection()
        .where(FirestoreEducationPrv.kinstitutionDomain, isEqualTo: institutionDomain)
        .where(FirestoreEducationPrv.kemail, isEqualTo: studentIdOrEmail).limit(1)
        .get().then((qSnapMap){
          return qSnapMap.docs
            .map((qDocSnap) => EducationPrvModel.fromMap(qDocSnap.data()))
            .toList();
        });
    return res + res2;
  }

  bool _greaterThanTime(Timestamp first, Timestamp second) {
    return first.compareTo(second) > 0; 
  }

  bool _smallerThanTime(Timestamp first, Timestamp second) {
    return first.compareTo(second) < 0; 
  }
  
  @override
  Future<List<DegreeModel>> searchDegrees({required String searchText, required DomainUrl instituteDomain, int? paginationLimit, String? lastDegree}) {
    dekhao("searching ${lastDegree ?? searchText}");
    if(_degrees.isNotEmpty) {

    }
    return _degreeCollection()
      .where(FirestoreDegree.kinstitutionDomain, isEqualTo: instituteDomain.url)
      .get().then((qSnap){

        dekhao("qSnap.size ${qSnap.size}");
        List<DegreeModel> degrees = [];

        for(final doc in qSnap.docs) {
          try {
            degrees.add(DegreeModel.fromMap(doc.data()));
          } catch (e) {
            dekhao(doc.data());
            dekhao(e.toString());
          }
        }

        _degrees = degrees;
        return degrees;
      });
  }

}