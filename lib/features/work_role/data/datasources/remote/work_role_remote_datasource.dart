
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/work_private_model.dart';
import '../../../../../core/utils/constants/data_field_key_names.dart';
import '../../models/work_public_model.dart';

abstract interface class WorkRoleRemoteDataSource {

  void refresh();
  
  Future<void> saveWorkRole({required WorkRolePrvModel workRolePrv});

  Future<void> approveWorkRole({required WorkRolePrvModel workRolePrv});

  Future<void> approveWorkRoleComplete({required WorkRolePrvModel workRolePrv});

  /// Only admins of respective institutions can do a successful fetch of private work roles.
  Future<List<WorkRolePrvModel>> instituteWorkRolesPrv({required String institutionDomain, required int paginationLimit});

  /// Only admins of respective institutions should do a successful fetch of public work roles.
  Future<List<WorkRolePubModel>> instituteWorkRolesPub({required String institutionDomain});

  /// Only admins of respective institutions can do a successful fetch of private work roles.
  Future<List<WorkRolePrvModel>> notApprovedWorkRoles({required String institutionDomain, required int paginationLimit});

  /// Only respective user and admins can fetch private data.
  Future<List<WorkRolePrvModel>> userWorkRolesPrv({required String userId});


  Future<List<WorkRolePubModel>> userWorkRoles({required String userId});
}

class WorkRoleFirebaseImpl implements WorkRoleRemoteDataSource {

  static WorkRoleFirebaseImpl? _instance;

  Timestamp? _oldest;
  Timestamp? _oldestNa;

  Timestamp? _newest;
  Timestamp? _newestNa;

  WorkRoleFirebaseImpl._();

  //getters
  static WorkRoleFirebaseImpl get instance {
    _instance ??= WorkRoleFirebaseImpl._();
    return _instance!;
  }

  CollectionReference<Map<String, dynamic>> _workRolePrvCollection() {
    return FirebaseFirestore.instance.collection(FirestoreWorkRolesPrv.kCollection);
  }

  CollectionReference<Map<String, dynamic>> _workRolePubCollection() {
    return FirebaseFirestore.instance.collection(FirestoreWorkRolesPrv.kCollection);
  }

  @override
  void refresh() {
    _oldest = null;
    _oldestNa = null;
    _newest = null;
    _newestNa = null;
  }


  // This is a write call and should be batch call updating or setting both private and public data atomically.
  @override
  Future<void> approveWorkRole({required WorkRolePrvModel workRolePrv}) async {

    // Using batch for atomic write.
    final batch = FirebaseFirestore.instance.batch();
    
    batch.update(_workRolePrvCollection().doc(workRolePrv.docId), {FirestoreWorkRolesPrv.kinstitutionApproved: true});
    batch.update(_workRolePubCollection().doc(workRolePrv.docId), {FirestoreWorkRolesPrv.kinstitutionApproved: true});

    return await batch.commit();
  }


  // This is a write call and should be batch call updating or setting both private and public data atomically.
  @override
  Future<void> approveWorkRoleComplete({required WorkRolePrvModel workRolePrv}) async {

    // Using batch for atomic write.
    final batch = FirebaseFirestore.instance.batch();
    
    batch.update(_workRolePrvCollection().doc(workRolePrv.docId), {FirestoreWorkRolesPrv.kendDateApproved: true});
    batch.update(_workRolePubCollection().doc(workRolePrv.docId), {FirestoreWorkRolesPrv.kendDateApproved: true});

  }

  @override
  Future<List<WorkRolePrvModel>> notApprovedWorkRoles ({required String institutionDomain, required int paginationLimit}) async {

    int oneFetchLimit = 20;
    List<WorkRolePrvModel>res = [];

    await _workRolePrvCollection()
      .where(FirestoreWorkRolesPrv.kinstitutionDomain, isEqualTo: institutionDomain)
      .where(FirestoreWorkRolesPrv.kinstitutionApproved, isEqualTo: false)
      .where(FirestoreWorkRolesPrv.klastWriteAt, isGreaterThan: (_newestNa ?? Timestamp.now()), isLessThan: (_oldestNa ?? Timestamp.now()))
      .orderBy(FirestoreWorkRolesPrv.klastWriteAt,)
      .limit(oneFetchLimit)
      .get(const GetOptions(source: Source.serverAndCache))
      .then((qSnapMap) {

        // By using try-catch inside for loop and manualy adding formatted data class to variable 'res',
        // we can avoid possible error occurance when we format fetched data to class using fromMap
        for (var qDocSnap in qSnapMap.docs) {
          try {
            res.add(WorkRolePrvModel.fromMap(qDocSnap.data()));
          } catch (e) {
            "";
          }
        }
      });
      
    if(res.isEmpty) return res;

    if(_oldestNa == null || _greaterThanTime(_oldestNa!, Timestamp.fromDate(res.last.lastWriteAt))) {
      _oldestNa = Timestamp.fromDate(res.last.lastWriteAt);
    }

    if(_newestNa == null || _smallerThanTime(_newestNa!, Timestamp.fromDate(res.first.lastWriteAt))) {
      _newestNa = Timestamp.fromDate(res.first.lastWriteAt);
    }
    return res;
  }

  // This is a write call and should be batch call updating or setting both private and public data atomically.
  @override
  Future<void> saveWorkRole({required WorkRolePrvModel workRolePrv}) async {
    // Using batch for atomic write.
    WriteBatch batch = FirebaseFirestore.instance.batch();

    batch.set(_workRolePrvCollection().doc(workRolePrv.docId), workRolePrv.toMap());
    
    batch.set(_workRolePrvCollection().doc(workRolePrv.docId), WorkRolePubModel.fromMap(workRolePrv.toMap()).toMap());

    return await batch.commit();
    
  }
  
  @override
  Future<List<WorkRolePrvModel>> instituteWorkRolesPrv({required String institutionDomain, required int paginationLimit}) async {

    // Create the list.
    List<WorkRolePrvModel>res = [];

    await _workRolePrvCollection()
      .where(FirestoreWorkRolesPrv.kinstitutionDomain, isEqualTo: institutionDomain) // Fetches documents related to the institutes domain.
      .where(FirestoreWorkRolesPrv.klastWriteAt, isGreaterThan: (_newest ?? Timestamp.now()), isLessThan: (_oldest ?? Timestamp.now()))
      .orderBy(FirestoreWorkRolesPrv.klastWriteAt,) // Tells query to order or sort the documents by ther lastWriteAt field.
      .limit(paginationLimit)
      .get()
      .then((qSnapMap) {

        if(qSnapMap.docs.isEmpty) return;
          
        for (var qDocSnap in qSnapMap.docs) {
          try {
            res.add(WorkRolePrvModel.fromMap(qDocSnap.data()));

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
  Future<List<WorkRolePrvModel>> userWorkRolesPrv({required String userId})async{
    
    return await _workRolePrvCollection()
        .where(FirestoreWorkRolesPrv.kuserId, isEqualTo: userId)
        .get()
        .then((qSnapMap) {
          return qSnapMap.docs
              .map((qDocSnap) => WorkRolePrvModel.fromMap(qDocSnap.data()))
              .toList();
        });
  }
  
  @override
  Future<List<WorkRolePubModel>> userWorkRoles({required String userId}) async{
    return await _workRolePrvCollection()
        .where(FirestoreWorkRolesPub.kuserId, isEqualTo: userId)
        .get()
        .then((qSnapMap) {
          return qSnapMap.docs
              .map((qDocSnap) => WorkRolePubModel.fromMap(qDocSnap.data()))
              .toList();
        });
  }
  
  @override
  Future<List<WorkRolePubModel>> instituteWorkRolesPub({required String institutionDomain}) {
    // TODO: implement instituteWorkRolesPub
    throw UnimplementedError();
  }

  bool _greaterThanTime(Timestamp first, Timestamp second) {
    return first.compareTo(second) > 0; 
  }

  bool _smallerThanTime(Timestamp first, Timestamp second) {
    return first.compareTo(second) < 0; 
  }
}
