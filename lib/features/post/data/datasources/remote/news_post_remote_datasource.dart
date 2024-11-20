import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dormsity/core/api_handler/exceptions.dart';

import '../../../../../core/utils/constants/data_field_key_names.dart';
import '../../../../../core/utils/func/dekhao.dart';
import '../../../../auth/data/datasources/remote/auth_remote_datasource.dart';
import '../../models/news_model.dart';

abstract class NewsPostRemoteDatasource {
  Future<void> createNewsPost({required NewsModel news});

  Future<void> editNewsPostContent({required EditNewsPostContentParams editNewsPostContentParams});

  Future<void> upVoteNewsPost({required UpVoteNewsPostParams params});

  Future<void> downVoteNewsPost({required DownVoteNewsPostParams params});

  Future<NewsModel> fetchNewsPost({required String docId});

  Future<List<NewsModel>> fetchAllNewsPostOfChannel({required FetchAllNewsPostOfChannelParams params});

  Future<List<NewsModel>> fetchNewsFeedForHomeScreen({required FetchNewsFeedForHomeScreenParams params});
}

class EditNewsPostContentParams{
  final String newTextContent;
  final String docId;

  EditNewsPostContentParams({required this.newTextContent, required this.docId});
}

class FetchAllNewsPostOfChannelParams {
  final UserAuth userAuth;
  final String channelDocId;
  final String pageDocId;
  final NewsModel? lastFetched;
  final int? paginationLimit;

  FetchAllNewsPostOfChannelParams({required this.userAuth, required this.channelDocId, required this.pageDocId, required this.lastFetched, required this.paginationLimit});
}

class FetchNewsFeedForHomeScreenParams {
  final UserAuth userAuth;
  final NewsModel? lastFetched;
  final int? paginationLimit;

  FetchNewsFeedForHomeScreenParams({required this.userAuth, required this.lastFetched, required this.paginationLimit});
}

class UpVoteNewsPostParams{
  final UserAuth userAuth;
  final bool upVote;
  final NewsModel news;

  UpVoteNewsPostParams({required this.userAuth, required this.upVote, required this.news});
}

class DownVoteNewsPostParams{
  final UserAuth userAuth;
  final NewsModel news;
  final bool downVote;

  DownVoteNewsPostParams({required this.userAuth, required this.downVote, required this.news});
}



class NewsFirebaseImpl implements NewsPostRemoteDatasource{

  CollectionReference<Map<String, dynamic>> _newsPostsCollection(){ 
    return FirebaseFirestore.instance.collection(FirestoreNewsPosts.kCollection);
  }

  CollectionReference<Map<String, dynamic>> _newsPostUpVotersCollection(String newsDocId){ 
    return _newsPostsCollection().doc(newsDocId).collection(FirestoreUpVoters.kCollection);
  }

  CollectionReference<Map<String, dynamic>> _newsPostDownVotersCollection(String newsDocId){ 
    return _newsPostsCollection().doc(newsDocId).collection(FirestoreDownVoters.kCollection);
  }
  
  @override
  Future<void> createNewsPost({required NewsModel news}) async{
    return _newsPostsCollection().doc(news.docId).set(news.toMap());
  }

  @override
  Future<void> editNewsPostContent({required  EditNewsPostContentParams editNewsPostContentParams}) async{
    return _newsPostsCollection().doc(editNewsPostContentParams.docId).update({
      FirestoreNewsPosts.textContent: editNewsPostContentParams.newTextContent,
    });
  }

  @override
  Future<List<NewsModel>> fetchAllNewsPostOfChannel({required FetchAllNewsPostOfChannelParams params}) async{
    return _newsPostsCollection()
      .orderBy(FirestoreNewsPosts.lastEditAt, descending: true)
        .where('${FirestoreNewsPosts.postMetaData}.${FirestorePostMetaData.channelDocId}', isEqualTo: params.channelDocId)
          .limit(params.paginationLimit ?? 100)
            .get().then((qSnap) async{
                dekhao("fetchAllNewsPostOfChannel result ${qSnap.docs.length}");
                List<NewsModel> newsList = [];

                for(final doc in qSnap.docs){
                  try {
                    final news = NewsModel.fromMap(doc.data());
                    await isThePostAlreadyUpVoted(newsPostDocId: news.docId, userAuth: params.userAuth).then((yesClass) async{
                      if(yesClass.yes) {
                        news.setUpVoted();
                      } else {
                        await isThePostAlreadyDownVoted(newsPostDocId: news.docId, userAuth: params.userAuth).then((yesClass2) {
                          if(yesClass2.yes) {
                            news.setDownVoted();
                          }
                        });
                      }
                    });
                    newsList.add(news);
                  } catch (e) {
                    dekhao(e);
                  }
                }
                return newsList;
              });
  }

  @override
  Future<List<NewsModel>> fetchNewsFeedForHomeScreen({required FetchNewsFeedForHomeScreenParams params}) async{
    return _newsPostsCollection()
      .orderBy(FirestoreNewsPosts.lastEditAt, descending: true)
        .orderBy(FirestoreNewsPosts.impression, descending: true)
          .limit(params.paginationLimit ?? 100)
            .get().then((qSnap) async{
                List<NewsModel> newsList = [];

                for(final doc in qSnap.docs){
                  try {
                    final news = NewsModel.fromMap(doc.data());
                    await isThePostAlreadyUpVoted(newsPostDocId: news.docId, userAuth: params.userAuth).then((yesClass) async{
                      if(yesClass.yes) {
                        news.setUpVoted();
                      } else {
                        await isThePostAlreadyDownVoted(newsPostDocId: news.docId, userAuth: params.userAuth).then((yesClass2) {
                          if(yesClass2.yes) {
                            news.setDownVoted();
                          }
                        });
                      }
                    });
                    newsList.add(news);
                  } catch (e) {
                    dekhao(e);
                  }
                }
                return newsList;
              });
  }

  @override
  Future<NewsModel> fetchNewsPost({required String docId}) async{
    return _newsPostsCollection().doc(docId).get().then((docSnap){
        if(docSnap.data() == null) {
          throw NoDataException();
        } else {
          return NewsModel.fromMap(docSnap.data()!);
        }
      });
  }

  @override
  Future<void> upVoteNewsPost({required UpVoteNewsPostParams params}) async{
    dekhao("upVoteNewsPost reached remote calling endpoint");
    if(params.upVote == false) {
      return cancelUpVoteNewsPost(params: params);
    }

    // 
    dekhao("calling isThePostAlreadyUpVoted");
    return await isThePostAlreadyUpVoted(newsPostDocId: params.news.docId, userAuth: params.userAuth).then((value) async{
      if(value.yes) {
        dekhao("isThePostAlreadyUpVoted true");
        return;
      } else {

        dekhao("isThePostAlreadyUpVoted false");
        dekhao("Now, calling isThePostAlreadyDownVoted");
        isThePostAlreadyDownVoted(newsPostDocId: params.news.docId, userAuth: params.userAuth).then((value2) async{
          if(value2.yes) {
            dekhao("isThePostAlreadyDownVoted true");
            await cancelDownVoteNewsPost(params: DownVoteNewsPostParams(downVote: false, userAuth: params.userAuth, news: params.news));
          } 

          for(int cnt = 0; cnt < 20; cnt++) {
              try {

                WriteBatch batch = FirebaseFirestore.instance.batch();
                batch.set(_newsPostUpVotersCollection(params.news.docId).doc(cnt.toString()), {FirestoreUpVoters.idList: FieldValue.arrayUnion([params.userAuth.id])});
                batch.update(_newsPostsCollection().doc(params.news.docId), {FirestoreNewsPosts.upVote: FieldValue.increment(1)});
                batch.update(_newsPostsCollection().doc(params.news.docId), {FirestoreNewsPosts.impression: FieldValue.increment(10)});
                await batch.commit();

                ///Exit
                return;
                
              } catch (e) {
                dekhao(e);
              }
            }
        });
      }
    });
    
    
  }


  Future<void> cancelUpVoteNewsPost({required UpVoteNewsPostParams params}) async{
    
    return await isThePostAlreadyUpVoted(newsPostDocId: params.news.docId, userAuth: params.userAuth).then((value) async{
      if(value.yes) {

        WriteBatch batch = FirebaseFirestore.instance.batch();
        batch.set(_newsPostUpVotersCollection(params.news.docId).doc(value.docId ?? ''), {FirestoreUpVoters.idList: FieldValue.arrayRemove([params.userAuth.id])});
        batch.update(_newsPostsCollection().doc(params.news.docId), {FirestoreNewsPosts.upVote: FieldValue.increment(-1)});
        batch.update(_newsPostsCollection().doc(params.news.docId), {FirestoreNewsPosts.impression: FieldValue.increment(-10)});
        await batch.commit();
        return;

      } else {
        return;
      }
    });
    
  }
  
  @override
  Future<void> downVoteNewsPost({required DownVoteNewsPostParams params}) async{

    // If user wants to undo down vote, then...
    if(params.downVote == false) {
      return cancelDownVoteNewsPost(params: params);
    }

    // Otherwise, proceed with down voting.
    // First, check if the post is already downvoted if so then return.
    return await isThePostAlreadyDownVoted(newsPostDocId: params.news.docId, userAuth: params.userAuth).then((value) async{
      if(value.yes) {
        return;
      } else {
        // If not downvoted yet, then check if the post is upvoted.
        isThePostAlreadyUpVoted(newsPostDocId: params.news.docId, userAuth: params.userAuth).then((value2) async{

          if(value2.yes) {
            // If the post already upvoted, then first, cancel the upvote, then down vote.
            await cancelDownVoteNewsPost(params: DownVoteNewsPostParams(downVote: false, userAuth: params.userAuth, news: params.news));
          } 

          // Now, try down voting.
          for(int cnt = 0; cnt < 20; cnt++) {
              try {

                WriteBatch batch = FirebaseFirestore.instance.batch();
                // Add user's uid in one of post's downVoters collection.
                batch.set(_newsPostDownVotersCollection(params.news.docId).doc(cnt.toString()), {FirestoreUpVoters.idList: FieldValue.arrayUnion([params.userAuth.id])});
                // Decrement the vote counting field('upVote') by one.
                batch.update(_newsPostsCollection().doc(params.news.docId), {FirestoreNewsPosts.upVote: FieldValue.increment(-1)});
                batch.update(_newsPostsCollection().doc(params.news.docId), {FirestoreNewsPosts.impression: FieldValue.increment(-10)});
                await batch.commit();

                ///Exit on success.
                return;
                
              } catch (e) {
                dekhao(e);
              }
            }
        });
      }
    });
  }

  Future<void> cancelDownVoteNewsPost({required DownVoteNewsPostParams params}) async{
    return await isThePostAlreadyDownVoted(newsPostDocId: params.news.docId, userAuth: params.userAuth).then((value) async{
      if(value.yes) {
        WriteBatch batch = FirebaseFirestore.instance.batch();
        batch.set(_newsPostDownVotersCollection(params.news.docId).doc(value.docId), {FirestoreDownVoters.idList: FieldValue.arrayRemove([params.userAuth.id])});
        batch.update(_newsPostsCollection().doc(params.news.docId), {FirestoreNewsPosts.upVote: FieldValue.increment(1)});
        batch.update(_newsPostsCollection().doc(params.news.docId), {FirestoreNewsPosts.impression: FieldValue.increment(10)});
        await batch.commit();
      }
    });
  }

  Future<DocIdAndBooleanVal> isThePostAlreadyUpVoted({required String newsPostDocId, required UserAuth userAuth}) async{
    try {
      return _newsPostUpVotersCollection(newsPostDocId)
      .where(FirestoreUpVoters.idList, arrayContains: userAuth.id)
      .limit(1).get().then((qSnap){
        if(qSnap.docs.isNotEmpty) return DocIdAndBooleanVal(docId: qSnap.docs.first.id, yes: true);
        return DocIdAndBooleanVal(yes: false);
      });
    } catch (e) {
      return DocIdAndBooleanVal(yes: false);
    }
  }

  Future<DocIdAndBooleanVal> isThePostAlreadyDownVoted({required String newsPostDocId, required UserAuth userAuth}) async{
    try {
      return _newsPostDownVotersCollection(newsPostDocId)
      .where(FirestoreUpVoters.idList, arrayContains: userAuth.id)
      .limit(1).get().then((qSnap){
        if(qSnap.docs.isNotEmpty) return DocIdAndBooleanVal(docId: qSnap.docs.first.id, yes: true);
        return DocIdAndBooleanVal(yes: false);
      });
    } catch (e) {
      return DocIdAndBooleanVal(yes: false);
    }
    
  }
}

class DocIdAndBooleanVal{
  final String? docId;
  final bool yes;

  DocIdAndBooleanVal({this.docId, required this.yes});
}