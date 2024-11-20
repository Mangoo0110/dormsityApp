// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dormsity/core/utils/enums/common_enums.dart';
import 'package:flutter/foundation.dart';

import 'package:dormsity/core/utils/enums/page_enums.dart';
import 'package:dormsity/core/utils/uuid_service/firebase_uid.dart';
import 'package:dormsity/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:dormsity/features/channel/domain/entities/channel.dart';
import 'package:dormsity/features/page_entity/domain/entities/page_public.dart';
import 'package:dormsity/features/post/domain/entities/news.dart';
import 'package:dormsity/features/post/domain/entities/post.dart';
import 'package:dormsity/features/post/domain/usecases/news/create_news_post.dart';
import 'package:dormsity/init_dependency.dart';

class NewsPostCreateProvider extends ChangeNotifier {
  Channel channel;
  PagePublic pagePublic;
  UserAuth userAuth;

  String _textContent = '';

  SaveStatus _saveStatus = SaveStatus.canNotSave;

  NewsPostCreateProvider({
    required this.channel,
    required this.pagePublic,
    required this.userAuth,
  });

  // getters

  String get textContent => _textContent;
  SaveStatus get saveStatus => _saveStatus;


  void checkIfCanSave() {
    if(_textContent.isNotEmpty && saveStatus != SaveStatus.canSave) {
      _saveStatus = SaveStatus.canSave; notifyListeners();
    }

    if(_textContent.isEmpty && saveStatus == SaveStatus.canSave) {
      _saveStatus = SaveStatus.canNotSave; notifyListeners();
    }
  }

  void setTextContent(String text){
    _textContent = text; checkIfCanSave();
  }
  

  Future<void> createPost({required Future<List<String> >Function() saveImageReturnUrl}) async {
    _saveStatus = SaveStatus.saving; notifyListeners();

    await saveImageReturnUrl().then((urls){
      final news = News(
        docId: uuidByFirebaseSdk(),
        postMetaData: PostMetaData(
            createdAt: DateTime.now(),
            channelDocId: channel.docId,
            channelName: channel.channelName,
            channelType: channel.channelType,
            pageDocId: pagePublic.docId,
            pageName: pagePublic.pageName,
            pageLogoUrl: pagePublic.logoUrl
          ),
        postType: PostType.news,
        createdBy: userAuth.id,
        createdAt: DateTime.now(),
        lastEditAt: DateTime.now(),
        textContent: _textContent,
        imageContentUrls: urls,
        upVote: 0,
        impression: 0,
        commentCount: 0,
      );
      return serviceLocator<CreateNewsPost>().call(news).then((lr){
        lr.fold(
          (l){
            _saveStatus = SaveStatus.failed; notifyListeners();
          }, (r){
            _saveStatus = SaveStatus.saved; notifyListeners();
          });
      });
    });
    
    
  }
}
