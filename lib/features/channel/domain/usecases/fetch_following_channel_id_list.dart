import 'package:dartz/dartz.dart';
import '../../../auth/data/datasources/remote/auth_remote_datasource.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/channel_repo.dart';

class FetchFollowingChannelIdList implements AsyncEitherUsecase<List<String>, UserAuth>{
  final ChannelRepo _channelRepo;

  FetchFollowingChannelIdList(this._channelRepo);

  @override
  Future<Either<DataCRUDFailure, List<String>>> call(UserAuth params) async{
    return await _channelRepo.fetchUsersFollowingChannelIdList(userAuth: params);
  }
  
}

