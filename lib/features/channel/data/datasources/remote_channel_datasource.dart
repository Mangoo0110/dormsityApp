import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dormsity/core/api_handler/exceptions.dart';
import 'package:dormsity/features/page_entity/domain/entities/page_public.dart';
import '../../../../core/utils/func/dekhao.dart';

import '../../../../core/utils/constants/data_field_key_names.dart';
import '../../../auth/data/datasources/remote/auth_remote_datasource.dart';
import '../../../page_entity/data/models/page_public_model.dart';
import '../../domain/usecases/add_channel_admin.dart';
import '../../domain/usecases/create_channel.dart';
import '../../domain/usecases/follow_channel.dart';
import '../../domain/usecases/unfollow_channel.dart';
import '../models/channel_model.dart';

abstract interface class RemoteChannelDatasource {

  Future<void> createChannel({required CreateChannelParams createChannelParams});

  Future<ChannelModel> fetchChannel({required String channelDocId});

  /// userId is the new admin's uid in database.
  Future<void> addAdmin({required AddChannelAdminParams params});

  Future<void> setUnsetPublic({required bool public, required String channelDocId});

  Future<void> followChannel({required FollowChannelParams followChannelParams});

  Future<void> unfollowChannel({required UnFollowChannelParams unfollowChannelParams});

  Future<List<ChannelModel>> channelSearchResult({required String searchText, required int? paginationLimit, required ChannelModel? lastFetchedPage});

  Future<List<ChannelModel>> fetchUsersChannelAsAdmin({required UserAuth userAuth, required int? paginationLimit, required ChannelModel? lastFetchedPage});
  
  Future<List<String>> fetchUsersChannelIdListAsAdmin({required UserAuth userAuth});

  Future<List<String>> fetchUsersFollowingChannelIdList({required UserAuth userAuth});

  Future<List<ChannelModel>> fetchAllChannelsOfPage({required String pageDocId});

}


class ChannelFirebaseImpl implements RemoteChannelDatasource{


  CollectionReference<Map<String, dynamic>> _channelCollection(){
    return FirebaseFirestore.instance.collection(FirestoreChannel.kCollection);
  }

  CollectionReference<Map<String, dynamic>> _channelAdminsCollection(String channelId){
    return FirebaseFirestore.instance.collection(FirestoreChannel.kCollection).doc(channelId).collection(FirestoreAdmins.kCollection);
  }

  CollectionReference<Map<String, dynamic>> _channelFollowersCollection(String channelId){
    return FirebaseFirestore.instance.collection(FirestoreChannel.kCollection).doc(channelId).collection(FirestoreFollowers.kCollection);
  }

  CollectionReference<Map<String, dynamic>> _pageCollection(){
    return FirebaseFirestore.instance.collection(FirestorePagePublic.kCollection);
  }

  CollectionReference<Map<String, dynamic>> _userAdminOfChannelsCollection(String userId){
    return FirebaseFirestore.instance.collection(FirestoreUserPub.kCollection).doc(userId).collection(FirestoreAdminOfChannels.kCollection);
  }

  CollectionReference<Map<String, dynamic>> _userChannelFollowingCollection(String userId){
    return FirebaseFirestore.instance.collection(FirestoreUserPub.kCollection).doc(userId).collection(FirestoreFollowingChannels.kCollection);
  }

  @override
  Future<void> addAdmin({required AddChannelAdminParams params}) async{

    for(int cnt = 0; cnt < 20; cnt++) {
      try {

        // First, need to check if docId(cnt = 1, 2, 3,....) exist or not.
        // Using 'update' to update a field of a non-existing document doesn't work with firebase firestore.
        await _userAdminOfChannelsCollection(params.userId).doc(cnt.toString()).get().then((data) async{

          // If document exist with the docId(cnt = 1, 2, 3,....), then update.
          if(data.data() != null) {
            await _userAdminOfChannelsCollection(params.userId).doc(cnt.toString()).update({
              FirestoreAdminOfChannels.idList: FieldValue.arrayUnion([params.channelDocId])
            });
          } 
          
          // Else set or create. 
          else {
            await _userAdminOfChannelsCollection(params.userId).doc(cnt.toString()).set({
              FirestoreAdminOfChannels.idList: FieldValue.arrayUnion([params.channelDocId])
            });
          }
        }).then((_) async{
            for(int cnt = 0; cnt < 20; cnt++) {
              try {

                // First, need to check if docId(cnt = 1, 2, 3,....) exist or not.
                // Using 'update' to update a field of a non-existing document doesn't work with firebase firestore.
                await _channelAdminsCollection(params.channelDocId).doc(cnt.toString()).get().then((data) async{

                  // If document exist with the docId(cnt = 1, 2, 3,....), then update.
                  if(data.data() != null) {
                    await _channelAdminsCollection(params.channelDocId).doc(cnt.toString()).update({
                      FirestoreAdminOfChannels.idList: FieldValue.arrayUnion([params.userId])
                    });
                  } 
                  
                  // Else set or create. 
                  else {
                    await _channelAdminsCollection(params.channelDocId).doc(cnt.toString()).set({
                      FirestoreAdminOfChannels.idList: FieldValue.arrayUnion([params.userId])
                    });
                  }
                });

                ///Exit
                return;
                
              } catch (e) {
                dekhao(e);
              }
            }
        });
        

        /// Exit
        return;

      } catch (e) {
        dekhao(e);
      }
    }
  }

  @override
  Future<List<ChannelModel>> channelSearchResult({required String searchText, required int? paginationLimit, required ChannelModel? lastFetchedPage}) async{
    return _channelCollection()
      .startAt([searchText]).endAt(['$searchText\uf8ff'])
      .limit(paginationLimit ?? 100).get().then((qSnap){
        List<ChannelModel> issuePages = [];
        for(final doc in qSnap.docs) {
          try {
            issuePages.add(ChannelModel.fromMap(doc.data()));
          } catch (e) {
            dekhao("PageFirebaseImpl/PageSearchResult failed. $e");
          }
        }
        return issuePages;
      });
  }

  @override
  Future<void> createChannel({required CreateChannelParams createChannelParams}) async{
    WriteBatch batch = FirebaseFirestore.instance.batch();
    batch.set(_channelCollection().doc(createChannelParams.docId), createChannelParams.toMap());
    batch.update(
      _pageCollection().doc(createChannelParams.pagePublic.docId), {
        FirestorePagePublic.channelList: FieldValue.arrayUnion([
          ChannelNameTypeModel(channelDocId: createChannelParams.docId, channelName: createChannelParams.channelName, channelType: createChannelParams.channelType).toMap()
        ])});
    
    await batch.commit().then((_) async{
      return await addAdmin(params: AddChannelAdminParams(
        userId: createChannelParams.createdBy, 
        channelDocId: createChannelParams.docId, 
        pageDocId: createChannelParams.pagePublic.docId
      ));
    });
  }


  @override
  Future<void> followChannel({required FollowChannelParams followChannelParams}) async{

    for(int cnt = 0; cnt < 20; cnt++) {
      try {

        // First, need to check if docId(cnt = 1, 2, 3,....) exist or not.
        // Using 'update' to update a field of a non-existing document doesn't work with firebase firestore.
        await _userChannelFollowingCollection(followChannelParams.userAuth.id).doc(cnt.toString()).get().then((data) async{

          // If document exist with the docId(cnt = 1, 2, 3,....), then update.
          if(data.data() != null) {
            await _userChannelFollowingCollection(followChannelParams.userAuth.id).doc(cnt.toString()).update({
              FirestoreAdminOfChannels.idList: FieldValue.arrayUnion([followChannelParams.channelDocId])
            });
          }

          // Else set or create. 
          else {
            await _userChannelFollowingCollection(followChannelParams.userAuth.id).doc(cnt.toString()).set({
              FirestoreAdminOfChannels.idList: FieldValue.arrayUnion([followChannelParams.channelDocId])
            });
          }
        }).then((_) async{
            for(int cnt = 0; cnt < 20; cnt++) {
              try {

                // First, need to check if docId(cnt = 1, 2, 3,....) exist or not.
                // Using 'update' to update a field of a non-existing document doesn't work with firebase firestore.
                await _channelFollowersCollection(followChannelParams.channelDocId).doc(cnt.toString()).get().then((data) async{
                  if(data.data() != null) {

                    // If document exist with the docId(cnt = 1, 2, 3,....), then update.
                    await _channelFollowersCollection(followChannelParams.channelDocId).doc(cnt.toString()).update({
                      FirestoreAdminOfChannels.idList: FieldValue.arrayUnion([followChannelParams.userAuth.id])
                    });
                  } 
                  
                   // Else set or create. 
                  else {
                    await _channelFollowersCollection(followChannelParams.channelDocId).doc(cnt.toString()).set({
                      FirestoreAdminOfChannels.idList: FieldValue.arrayUnion([followChannelParams.userAuth.id])
                    });
                  }
                });

                ///Exit
                return;
                
              } catch (e) {
                dekhao(e);
              }
            }
        }).then((_){
          _channelCollection().doc(followChannelParams.channelDocId).update({
            FirestoreChannel.followersCount: FieldValue.increment(1)
          });
        });
        

        /// Exit
        return;

      } catch (e) {
        dekhao(e);
      }
    }
  }


  @override
  Future<void> setUnsetPublic({required bool public, required String channelDocId}) {
    // TODO: implement setUnsetPublic
    throw UnimplementedError();
  }

  @override
  Future<void> unfollowChannel({required UnFollowChannelParams unfollowChannelParams}) async{
    for(int cnt = 0; cnt < 20; cnt++) {
      try {

        // First, need to check if docId(cnt = 1, 2, 3,....) exist or not.
        // Using 'update' to update a field of a non-existing document doesn't work with firebase firestore.
        await _userChannelFollowingCollection(unfollowChannelParams.userAuth.id).doc(cnt.toString()).get().then((data) async{

          // If document exist with the docId(cnt = 1, 2, 3,....), then update.
          if(data.data() != null) {
            await _userChannelFollowingCollection(unfollowChannelParams.userAuth.id).doc(cnt.toString()).update({
              FirestoreAdminOfChannels.idList: FieldValue.arrayRemove([unfollowChannelParams.channelDocId])
            });
          }

          // Else set or create. 
          else {
            await _userChannelFollowingCollection(unfollowChannelParams.userAuth.id).doc(cnt.toString()).set({
              FirestoreAdminOfChannels.idList: FieldValue.arrayRemove([unfollowChannelParams.channelDocId])
            }, SetOptions(merge: true), );
          }
        }).then((_) async{
            for(int cnt = 0; cnt < 20; cnt++) {
              try {

                // First, need to check if docId(cnt = 1, 2, 3,....) exist or not. 
                // Using 'update' to update a field of a non-existing document doesn't work with firebase firestore.
                await _channelFollowersCollection(unfollowChannelParams.channelDocId).doc(cnt.toString()).get().then((data) async{
                  if(data.data() != null) {

                    // If document exist with the docId(cnt = 1, 2, 3,....), then update.
                    await _channelFollowersCollection(unfollowChannelParams.channelDocId).doc(cnt.toString()).update({
                      FirestoreAdminOfChannels.idList: FieldValue.arrayRemove([unfollowChannelParams.userAuth.id])
                    });
                  } 
                  
                   // Else set or create. 
                  else {
                    await _channelFollowersCollection(unfollowChannelParams.channelDocId).doc(cnt.toString()).set({
                      FirestoreAdminOfChannels.idList: FieldValue.arrayRemove([unfollowChannelParams.userAuth.id])
                    });
                  }
                });

                ///Exit
                return;
                
              } catch (e) {
                dekhao(e);
              }
            }
        }).then((_){
          _channelCollection().doc(unfollowChannelParams.channelDocId).update({
            FirestoreChannel.followersCount: FieldValue.increment(-1)
          });
        });
        

        /// Exit
        return;

      } catch (e) {
        dekhao(e);
      }
    }
  }
  
  @override
  Future<List<ChannelModel>> fetchUsersChannelAsAdmin({required UserAuth userAuth, required int? paginationLimit, required ChannelModel? lastFetchedPage}) async{
    return _channelCollection()
      .where(FirestoreChannel.adminIds, arrayContains: userAuth.id)
      .limit(paginationLimit ?? 100).get().then((qSnap){
        List<ChannelModel> channels = [];
        for(final doc in qSnap.docs) {
          try {
            channels.add(ChannelModel.fromMap(doc.data()));
          } catch (e) {
            dekhao("PageFirebaseImpl/fetchPagesForAdmin failed. ${"\n\n"}${doc.data()} ${"\n\n"} Error: $e");
          }
        }
        return channels;
      });
  }
  
  @override
  Future<List<String>> fetchUsersChannelIdListAsAdmin({required UserAuth userAuth}) async{
    return await _userAdminOfChannelsCollection(userAuth.id).get().then((qSnap){
      List<String> channelIdList = [];
      for(final doc in qSnap.docs) {
        channelIdList.addAll((doc.data()[FirestoreAdminOfChannels.idList] as List<dynamic>).map((e) => e.toString()).toList());
      }
      return channelIdList;
    });
  }
  
  @override
  Future<List<ChannelModel>> fetchAllChannelsOfPage({required String pageDocId}) async{
    return _channelCollection().where(FirestoreChannel.pageId, isEqualTo: pageDocId).get().then((qSnaps){
      List<ChannelModel> channels = [];
      for(final doc in qSnaps.docs) {
        try {
          channels.add(ChannelModel.fromMap(doc.data()));
        } catch (e) {
          dekhao(e);
        }
      }
      return channels;
    });
  }
  
  @override
  Future<List<String>> fetchUsersFollowingChannelIdList({required UserAuth userAuth}) async{
    return await _userChannelFollowingCollection(userAuth.id).get().then((qSnap){
      List<String> channelIdList = [];
      for(final doc in qSnap.docs) {
        channelIdList.addAll((doc.data()[FirestoreFollowingChannels.idList] as List<dynamic>).map((e) => e.toString()).toList());
      }
      return channelIdList;
    });
  }
  
  @override
  Future<ChannelModel> fetchChannel({required String channelDocId}) async{
     dekhao("fetchChannel call received from remote calling endpoint.");

    return await _channelCollection().doc(channelDocId).get().then((docSnap){
      if(docSnap.data() == null) throw NoDataException();
      return ChannelModel.fromMap(docSnap.data()!);
    }).then((channel) async{
      return await _channelAdminsCollection(channelDocId).get().then((qSnap){
        for(final doc in qSnap.docs) {
          channel.adminIds.addAll((doc.data()[FirestoreAdmins.idList] as List<dynamic>).map((e)=> e.toString()).toList());
        }
        return channel;
      });
    });
  }
}