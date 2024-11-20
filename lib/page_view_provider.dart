import 'dart:collection';

import 'package:dormsity/core/utils/enums/page_enums.dart';
import 'package:dormsity/core/utils/func/dekhao.dart';
import 'package:dormsity/features/post/data/datasources/remote/news_post_remote_datasource.dart';
import 'package:dormsity/features/post/domain/usecases/news/fetch_all_news_of_channel.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'core/utils/enums/common_enums.dart';
import 'features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'features/channel/domain/entities/channel.dart';


import 'features/channel/domain/usecases/fetch_channel.dart';
import 'features/channel/domain/usecases/follow_channel.dart';
import 'features/channel/domain/usecases/unfollow_channel.dart';
import 'features/page_entity/domain/entities/page_public.dart';
import 'features/post/domain/entities/news.dart';
import 'init_dependency.dart';
import 'package:flutter/material.dart';



class PageViewProvider extends ChangeNotifier{

  SplayTreeMap<String, Channel> channels = SplayTreeMap<String, Channel>();

  /// Key: channel docId, value: List[News]
  SplayTreeMap<String, List<News>> newsPostOfChannel = SplayTreeMap<String, List<News>>();

  PagePublic pagePub;
  UserAuth userAuth;
  TabController tabController;
  FetchingStatus fetchingChannelStatus = FetchingStatus.fetched;
  FetchingStatus fetchingPostsStatus = FetchingStatus.fetching;

  int _currentTabIndex = 0;

  PageViewProvider({required this.pagePub, required this.userAuth, required this.tabController}){
    init();
  }

  void init(){
    getChannel(channelDocId: pagePub.channelList[0].channelDocId, forceGet: false);
    tabController.addListener((){
      if(_currentTabIndex != tabController.index) {
        dekhao("tabController.index ${tabController.index}");
        _currentTabIndex = tabController.index;
        getChannel(channelDocId: pagePub.channelList[tabController.index].channelDocId, forceGet: false);
      }
      
    });
  }

  // Future<void> _getPageChannels() async{
  //   await serviceLocator<FetchAllChannelsOfPage>().call(_pagePub.docId).then((lr){
  //     lr.fold(
  //       (l){

  //       }, (channels){
  //         // TODO:: need implement
  //       });
  //   });
  // }

  

  Future<Channel?> getChannel({required String channelDocId, required bool forceGet}) async{
    fetchingChannelStatus = FetchingStatus.fetching; notifyListeners();

    dekhao("getChannel called");
    if(channels.containsKey(channelDocId) && !forceGet) {
      dekhao("::: Channel fetched before. Returning already fetched channel data");
      if(channels[channelDocId]!.channelType == ChannelType.news) {
        getNewsChannelPosts(channelDocId: channelDocId);
      }
      return channels[channelDocId];
    }
    return await serviceLocator<FetchChannel>().call(channelDocId).then((lr){
      return lr.fold(
        (l){
          Fluttertoast.showToast(msg: l.message);
          return null;
        }, (channel){
          dekhao(channel.toString());

          fetchingChannelStatus = FetchingStatus.fetched; notifyListeners();
          channels[channel.docId] = channel;

          if(channels[channelDocId]!.channelType == ChannelType.news) {
            getNewsChannelPosts(channelDocId: channelDocId);
          }
          return channel;
        });
    });
  }

  void getNewsChannelPosts({required String channelDocId, bool? forceGet}) async{
    if(newsPostOfChannel.containsKey(channelDocId) && newsPostOfChannel[channelDocId]!.isNotEmpty && forceGet != true) {
      return;
    }

    fetchingPostsStatus = FetchingStatus.fetching; notifyListeners();

    return await serviceLocator<FetchAllNewsOfChannel>().call(FetchAllNewsPostOfChannelParams(userAuth: userAuth, channelDocId: channelDocId, pageDocId: pagePub.docId, lastFetched: null, paginationLimit: 100)).then((lr){
      return lr.fold(
        (l){
          Fluttertoast.showToast(msg: l.message);
          return;
        }, (posts){
          dekhao("fetched news post length ${posts.length.toString()}");
          newsPostOfChannel[channelDocId] = posts;
          fetchingPostsStatus = FetchingStatus.fetched; notifyListeners();
    
        });
    });
  }

  Future<bool> followChannel({
    required String channelDocId,
  }) async{

    return await serviceLocator<FollowChannel>().call(FollowChannelParams(
      channelDocId: channelDocId, 
      pageDocId: pagePub.docId, 
      userAuth: userAuth)).then((lr){
        return lr.fold(
          (l){
            Fluttertoast.showToast(msg: l.message);
            return false;
          }, (success){
            return true;
          });
      });
  }

  Future<bool> unfollowChannel({
    required String channelDocId,
  }) async{

    return await serviceLocator<UnFollowChannel>().call(UnFollowChannelParams(
      channelDocId: channelDocId, 
      pageDocId: pagePub.docId, 
      userAuth: userAuth)).then((lr){
        return lr.fold(
          (l){
            Fluttertoast.showToast(msg: l.message);
            return false;
          }, (success){
            return true;
          });
      });
  }

}