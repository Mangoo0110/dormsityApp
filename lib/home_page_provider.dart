import 'dart:collection';

import 'package:dormsity/core/utils/func/dekhao.dart';
import 'package:dormsity/features/post/data/datasources/remote/news_post_remote_datasource.dart';
import 'package:dormsity/features/post/domain/usecases/news/fetch_news_feed_for_home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'core/utils/enums/common_enums.dart';
import 'features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'features/channel/domain/entities/channel.dart';


import 'features/post/domain/entities/news.dart';
import 'init_dependency.dart';
import 'package:flutter/material.dart';



class HomePageProvider extends ChangeNotifier{

  SplayTreeMap<String, Channel> channels = SplayTreeMap<String, Channel>();

  List<News> newsPostFeed = [];

  FetchingStatus fetchingPostsStatus = FetchingStatus.fetching;



  void fetchNewsFeedForHomeScreen({required UserAuth userAuth, bool? forceGet}) async{
    if(newsPostFeed.isNotEmpty && forceGet != true) {
      return;
    }

    fetchingPostsStatus = FetchingStatus.fetching; notifyListeners();

    return await serviceLocator<FetchNewsFeedForHomeScreen>().call(FetchNewsFeedForHomeScreenParams(userAuth: userAuth, lastFetched: null, paginationLimit: 100)).then((lr){
      return lr.fold(
        (l){
          Fluttertoast.showToast(msg: l.message);
          return;
        }, (posts){
          dekhao("fetched news post length ${posts.length.toString()}");
          newsPostFeed = posts;
          fetchingPostsStatus = FetchingStatus.fetched; notifyListeners();
    
        });
    });
  }

}