
import 'package:dartz/dartz.dart';

import '../../../../../core/api_handler/failure.dart';
import '../../../../../core/api_handler/success.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../../data/datasources/remote/news_post_remote_datasource.dart';
import '../../repositories/news_post_repo.dart';



class DownvoteNewsPost implements AsyncEitherUsecase<Success, DownVoteNewsPostParams>{
  final NewsPostRepo _newsPostRepo;

  DownvoteNewsPost(this._newsPostRepo);

  @override
  Future<Either<DataCRUDFailure, Success>> call(DownVoteNewsPostParams params) async{
    return await _newsPostRepo.downVoteNewsPost(params: params);
  }
  
}