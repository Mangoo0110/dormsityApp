// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:flutter/foundation.dart';

import 'package:dormsity/core/utils/enums/page_enums.dart';

class Post {
  bool _upVoted = false;
  bool _downVoted = false;
  final String docId;
  final PostMetaData postMetaData;
  final PostType postType;
  final String createdBy;
  final DateTime? createdAt;
  final DateTime? lastEditAt;
  final String textContent;
  final List<String> imageContentUrls;
  int _voteCount;
  int _impression;
  final int commentCount;
  
  Post({
    required this.docId,
    required this.postMetaData,
    required this.postType,
    required this.createdBy,
    required this.createdAt,
    required this.lastEditAt,
    required this.textContent,
    required this.imageContentUrls,
    required int upVote,
    required int impression,
    required this.commentCount,
  }): _impression = impression, _voteCount = upVote;


  // getters

  int get impression => _impression;
  int get upVote => _voteCount;
  bool get upVoted => _upVoted;
  bool get downVoted => _downVoted;

  setUpVoted(){
    _upVoted = true; _downVoted = false;
  }

  setDownVoted(){
    _upVoted = false; _downVoted = true;
  }

  upVoteIt() {
    if(_upVoted) {
      return;
    }  
    if(_downVoted){
      cancelDownVote();
    } 

    _voteCount += 1;
    _upVoted = true;
    _downVoted = false;
  }

  cancelUpVote() {
    if(_upVoted != true) return;

    _voteCount--;
    _upVoted = false;
  }

  cancelDownVote() {
    if(_downVoted != true) return;

    _voteCount++;
    _downVoted = false;
  }

  downVoteIt() {
    if(_downVoted) {
      return;
    }
    if(_upVoted){
      cancelUpVote();
    } 

    _voteCount -= 1;
    _downVoted = true;
    _upVoted = false;
  }

  @override
  String toString() {
    return 'Post(docId: $docId, channelId: $postMetaData, postType: $postType, createdBy: $createdBy, createdAt: $createdAt, lastEditAt: $lastEditAt, textContent: $textContent, imageContentUrls: $imageContentUrls, upVote: $upVote, impression: $_impression, commentCount: $commentCount, upVoted: $upVoted, downVoted: $downVoted)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;
  
    return 
      other.docId == docId &&
      other.postMetaData == postMetaData &&
      other.postType == postType &&
      other.createdBy == createdBy &&
      other.createdAt == createdAt &&
      other.lastEditAt == lastEditAt &&
      other.textContent == textContent &&
      listEquals(other.imageContentUrls, imageContentUrls) &&
      other.upVote == upVote &&
      other.impression == impression &&
      other.commentCount == commentCount;
  }

  @override
  int get hashCode {
    return docId.hashCode ^
      postMetaData.hashCode ^
      postType.hashCode ^
      createdBy.hashCode ^
      createdAt.hashCode ^
      lastEditAt.hashCode ^
      textContent.hashCode ^
      imageContentUrls.hashCode ^
      upVote.hashCode ^
      impression.hashCode ^
      commentCount.hashCode;
  }
}


class PostMetaData {
  final DateTime? createdAt;
  final String channelDocId;
  final String channelName;
  final ChannelType channelType;
  final String pageDocId;
  final String pageName;
  final String pageLogoUrl;
  PostMetaData({
    required this.createdAt,
    required this.channelDocId,
    required this.channelName,
    required this.channelType,
    required this.pageDocId,
    required this.pageName,
    required this.pageLogoUrl,
  });

  @override
  String toString() {
    return 'PostMetaData(createdAt: $createdAt, channelDocId: $channelDocId, channelName: $channelName, channelType: $channelType, pageDocId: $pageDocId, pageName: $pageName, pageLogoUrl: $pageLogoUrl)';
  }

  @override
  bool operator ==(covariant PostMetaData other) {
    if (identical(this, other)) return true;
  
    return 
      other.createdAt == createdAt &&
      other.channelDocId == channelDocId &&
      other.channelName == channelName &&
      other.channelType == channelType &&
      other.pageDocId == pageDocId &&
      other.pageName == pageName &&
      other.pageLogoUrl == pageLogoUrl;
  }

  @override
  int get hashCode {
    return createdAt.hashCode ^
      channelDocId.hashCode ^
      channelName.hashCode ^
      channelType.hashCode ^
      pageDocId.hashCode ^
      pageName.hashCode ^
      pageLogoUrl.hashCode;
  }
}

