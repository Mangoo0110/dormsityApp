import 'package:dartz/dartz.dart';
import '../../../auth/data/datasources/remote/auth_remote_datasource.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/channel.dart';
import '../repositories/channel_repo.dart';

class FetchAllChannelsOfPage implements AsyncEitherUsecase<List<Channel>, String>{
  final ChannelRepo _channelRepo;

  FetchAllChannelsOfPage(this._channelRepo);

  @override
  Future<Either<DataCRUDFailure, List<Channel>>> call(String params) async{
    return await _channelRepo.fetchAllChannelsOfPage(pageDocId: params);
  }
  
}


class FetchPagesForAdminParams{
  final UserAuth userAuth;
  final int? paginationLimit;
  final Channel? lastFetchedPage;

  FetchPagesForAdminParams({required this.userAuth,  this.paginationLimit, this.lastFetchedPage});
}

