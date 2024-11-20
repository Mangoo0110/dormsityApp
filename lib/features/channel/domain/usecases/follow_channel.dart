import 'package:dartz/dartz.dart';
import 'package:dormsity/features/auth/data/datasources/remote/auth_remote_datasource.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/channel_repo.dart';

class FollowChannel implements AsyncEitherUsecase<Success, FollowChannelParams>{
  final ChannelRepo _pageRepo;

  FollowChannel(this._pageRepo);

  @override
  Future<Either<DataCRUDFailure, Success>> call(FollowChannelParams params) async{
    return await _pageRepo.followChannel(followChannelParams: params);
  }
  
}

class FollowChannelParams {
  final String channelDocId;
  final String pageDocId;
  final UserAuth userAuth;

  FollowChannelParams({required this.channelDocId, required this.pageDocId, required this.userAuth});
}
