import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../core/utils/func/dekhao.dart';
import '../../../../../core/api_handler/exceptions.dart';
import '../../../../../core/utils/constants/data_field_key_names.dart';
import '../../../domain/usecases/update_institute_page_bio.dart';
import '../../models/institute_public_model.dart';

import '../../../../../core/utils/classes/domain.dart';

abstract interface class RemoteInstituteDatasource {

  Future<void> createInstitute({required InstitutePubModel institute,});

  Future<void> updatePageBio({required UpdateInstitutePageBioParams updateInstitutePageBioParams});

  Future<InstitutePubModel> fetchByDomain({required DomainUrl domain});

  Future<InstitutePubModel> fetchAdminInstitute({required String userId});

  Future<void> addAdmin({required String docId, required String userId});

  Future<List<InstitutePubModel>> searchByName({required String searchText, int? loadMore, String? lastInstituteName });

}


class InstituteFirebaseImpl implements RemoteInstituteDatasource{


  CollectionReference<Map<String, dynamic>> _collectionPub(){
    return FirebaseFirestore.instance.collection(FirestorePagePublic.kCollection);
  }

  List<InstitutePubModel> cachedPubInstitute = [];

  @override
  Future<InstitutePubModel> fetchAdminInstitute({required String userId}) async{
    dekhao("fetchAdminInstitute.... fetching");

    final query = _collectionPub()
    .where(FirestorePagePublic.adminIds, arrayContains: userId);

    dekhao("query ${query.parameters.toString()}");
            
    return await query
    .limit(1).get().then((val) async{
      dekhao("fetchAdminInstitute.... ${val.docs.length}");
      if(val.docs.isEmpty) {
        throw NoDataException();
      }
      else{
        try {
          return InstitutePubModel.fromMap(val.docs.first.data());
        } catch (e) {
          dekhao("InstitutePubModel format error: $e");
          throw const FormatException();
        }
      }
    });
  }

  @override
  Future<InstitutePubModel> fetchByDomain({required DomainUrl domain}) async{
    dekhao("fetchByDomain is called. Domain is ${domain.url}");
    for(final institute in cachedPubInstitute){
      dekhao("exist in cache!");
      if(institute.domain == domain.url) return institute;
    }
    return await _collectionPub()
        .doc(domain.url)
        .get().then((qsnap) {
          try {
            dekhao("Found match. ${qsnap.data()!}");
            final institute = InstitutePubModel.fromMap(qsnap.data()!);
            // Remove first of cachedPubInstitute if length of cachedPubInstitute is greater than 30.
            if(cachedPubInstitute.length > 30)cachedPubInstitute.removeAt(0);
            cachedPubInstitute.add(institute);
            
            return institute;
          } catch (e) {
            dekhao("Format error: $e");
            throw const FormatException();
          }
        });
  }

  @override
  Future<void> createInstitute({required InstitutePubModel institute, }) async{
    if(institute.domain.trim().isEmpty) return;
    
    final batch = FirebaseFirestore.instance.batch();
    
    batch.set(_collectionPub().doc(institute.docId.trim()), institute.toMap());

    await batch.commit();
  }
  
  @override
  Future<void> addAdmin({required String docId, required String userId}) async{
    return _collectionPub().doc(docId).update({
      FirestorePagePublic.adminIds: FieldValue.arrayUnion([userId])
    });
  }
  
  @override
  Future<List<InstitutePubModel>> searchByName({required String searchText, int? loadMore, String? lastInstituteName}) async{

    dekhao("searching ${lastInstituteName ?? searchText}");
    return _collectionPub()
      .where(FirestorePagePublic.approved, isEqualTo: true)
      .orderBy(FirestorePagePublic.pageName)
      .startAt([lastInstituteName ?? searchText]).endAt(['${lastInstituteName ?? searchText}\uf8ff'])
      .limit(loadMore??20).get().then((qSnap){

        dekhao("qSnap.size ${qSnap.size}");
        List<InstitutePubModel> institutes = [];

        for(final doc in qSnap.docs) {
          try {
            institutes.add(InstitutePubModel.fromMap(doc.data()));
          } catch (e) {
            dekhao(doc.data());
            dekhao(e.toString());
          }
        }
        return institutes;
      });
  }
  
  @override
  Future<void> updatePageBio({required UpdateInstitutePageBioParams updateInstitutePageBioParams}) async{
    return await _collectionPub().doc(updateInstitutePageBioParams.docId).update(updateInstitutePageBioParams.toMap());
  }

}