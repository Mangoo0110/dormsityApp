import 'package:dartz/dartz.dart';
import 'package:dormsity/features/auth/data/datasources/remote/auth_remote_datasource.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/channel_repo.dart';

class UnFollowChannel implements AsyncEitherUsecase<Success, UnFollowChannelParams>{
  final ChannelRepo _pageRepo;

  UnFollowChannel(this._pageRepo);

  @override
  Future<Either<DataCRUDFailure, Success>> call(UnFollowChannelParams params) async{
    return await _pageRepo.unfollowChannel(unFollowChannelParams: params);
  }
  
}

class UnFollowChannelParams {
  final String channelDocId;
  final String pageDocId;
  final UserAuth userAuth;

  UnFollowChannelParams({required this.channelDocId, required this.pageDocId, required this.userAuth});
}
