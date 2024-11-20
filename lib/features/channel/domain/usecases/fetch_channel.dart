import 'package:dartz/dartz.dart';
import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/channel.dart';
import '../repositories/channel_repo.dart';

class FetchChannel implements AsyncEitherUsecase<Channel, String>{
  final ChannelRepo _channelRepo;

  FetchChannel(this._channelRepo);

  @override
  Future<Either<DataCRUDFailure, Channel>> call(String channelDocId) async{
    return await _channelRepo.fetchChannel(channelDocId: channelDocId);
  }
  
}

