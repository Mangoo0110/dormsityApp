import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/channel_repo.dart';

class AddChannelAdmin implements AsyncEitherUsecase<Success, AddChannelAdminParams>{
  final ChannelRepo _issuePageRepo;

  AddChannelAdmin(this._issuePageRepo);

  @override
  Future<Either<DataCRUDFailure, Success>> call(AddChannelAdminParams params) async{
    return await _issuePageRepo.addAdmin(params: params);
  }
  
}

class AddChannelAdminParams {
  final String userId;
  final String channelDocId;
  final String pageDocId;

  AddChannelAdminParams({required this.userId, required this.channelDocId, required this.pageDocId});
}
