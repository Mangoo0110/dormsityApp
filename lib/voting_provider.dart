import 'package:dormsity/core/utils/func/dekhao.dart';
import 'package:dormsity/features/post/data/models/news_model.dart';

import 'features/post/data/datasources/remote/news_post_remote_datasource.dart';

import 'features/post/domain/usecases/news/downvote_news_post.dart';
import 'features/post/domain/usecases/news/upvote_news.dart';
import 'init_dependency.dart';
import 'package:flutter/foundation.dart';

import 'features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'features/post/domain/entities/news.dart';

class VotingProvider extends ChangeNotifier{

  Future<void> tappedUpVote({required UserAuth userAuth, required News newsPost,}) async{
    dekhao("before ${newsPost.toString()}");
    if(newsPost.upVoted) {
      final params = UpVoteNewsPostParams(userAuth: userAuth, upVote: false, news: NewsModel.fromEntity(newsPost));
      await _cancelUpVoteNewsPost(
        params: params,
        success: () {
          newsPost.cancelUpVote();
        },
      );
    } else {
      final params = UpVoteNewsPostParams(userAuth: userAuth, upVote: true, news: NewsModel.fromEntity(newsPost));
      await _upVoteNewsPost(
        params: params,
        success: () {
          newsPost.upVoteIt();
        },
      );
    }
    dekhao("after ${newsPost.toString()}");
  }

  Future<void> tappedDownVote({required UserAuth userAuth, required News newsPost,}) async{
    
    if(newsPost.downVoted) {
      final params = DownVoteNewsPostParams(userAuth: userAuth, downVote: false, news: NewsModel.fromEntity(newsPost));
      await _cancelDownVoteNewsPost(
        params: params,
        success: () {
          newsPost.cancelDownVote();
        },
      );
    } else {
      final params = DownVoteNewsPostParams(userAuth: userAuth, downVote: true, news: NewsModel.fromEntity(newsPost));
      await _downVoteNewsPost(
        params: params,
        success: () {
          newsPost.downVoteIt();
        },
      );
    }
  }

  Future<void> _upVoteNewsPost({required UpVoteNewsPostParams params, required VoidCallback success}) async{
    return await serviceLocator<UpvoteNewsPost>()
      .call(params)
      .then((lr){
        return lr.fold(
          (l){
            return;
          }, (r){
            success();
        });
      });
  }

  Future<void> _cancelUpVoteNewsPost({required UpVoteNewsPostParams params, required VoidCallback success}) async{
    return await serviceLocator<UpvoteNewsPost>()
      .call(params)
      .then((lr){
        return lr.fold(
          (l){
            return;
          }, (r){
            success();
        });
      });
  }

  Future<void> _downVoteNewsPost({required DownVoteNewsPostParams params, required VoidCallback success}) async{
    return await serviceLocator<DownvoteNewsPost>()
      .call(params)
      .then((lr){
        return lr.fold(
          (l){
            return;
          }, (r){
            success();
        });
      });
  }

  Future<void> _cancelDownVoteNewsPost({required DownVoteNewsPostParams params, required VoidCallback success}) async{
    return await serviceLocator<DownvoteNewsPost>()
      .call(params)
      .then((lr){
        return lr.fold(
          (l){
            return;
          }, (r){
            success();
        });
      });
  }
}