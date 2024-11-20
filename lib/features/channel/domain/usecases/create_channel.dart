
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dormsity/core/utils/uuid_service/firebase_uid.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../../core/utils/enums/page_enums.dart';
import '../../../auth/data/datasources/remote/auth_remote_datasource.dart';
import '../../../page_entity/domain/entities/page_public.dart';
import '../repositories/channel_repo.dart';

class CreateChannel implements AsyncEitherUsecase<Success, CreateChannelParams>{
  final ChannelRepo _issuePageRepo;

  CreateChannel(this._issuePageRepo);

  @override
  Future<Either<DataCRUDFailure, Success>> call(CreateChannelParams params) async{
    return await _issuePageRepo.createChannel(params: params);
  }
  
}

class CreateChannelParams {
  final PagePublic pagePublic;
  final String docId = uuidByFirebaseSdk();
  String channelName = '';
  ChannelType channelType = ChannelType.news;
  final int impression = 0;
  final String description = '';
  final String logoUrl = '';
  bool public = true;
  final int follwersCount = 0;
  final int postCount = 0;
  /// User's uid.
  final String createdBy;

  ///List of uid of users.
  final List<String> adminIds;
  final DateTime createdAt = DateTime.now();
  final UserAuth _currentUserAuth;
  CreateChannelParams({
    required UserAuth currentUserAuth,
    required this.pagePublic
  }): createdBy = currentUserAuth.id,
      adminIds = [currentUserAuth.id],
      _currentUserAuth = currentUserAuth;



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docId': docId,
      'pageId': pagePublic.docId,
      'channelName': channelName,
      'channelType': channelType.name,
      'impression': impression,
      'description': description,
      'logoUrl': logoUrl,
      'public': public,
      'follwersCount': follwersCount,
      'postCount': postCount,
      'createdBy': createdBy,
      'adminIds': adminIds,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  bool canCreate() {
    return (createdBy == _currentUserAuth.id && channelName.isNotEmpty);
  }

}


