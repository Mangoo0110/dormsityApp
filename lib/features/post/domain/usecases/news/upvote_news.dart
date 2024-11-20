
import 'package:dartz/dartz.dart';

import '../../../../../core/api_handler/failure.dart';
import '../../../../../core/api_handler/success.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../../data/datasources/remote/news_post_remote_datasource.dart';
import '../../repositories/news_post_repo.dart';



class UpvoteNewsPost implements AsyncEitherUsecase<Success, UpVoteNewsPostParams>{
  final NewsPostRepo _newsPostRepo;

  UpvoteNewsPost(this._newsPostRepo);

  @override
  Future<Either<DataCRUDFailure, Success>> call(UpVoteNewsPostParams params) async{
    return await _newsPostRepo.upVoteNewsPost(params: params);
  }
  
}