
import 'package:dartz/dartz.dart';

import '../../../../../core/api_handler/failure.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../../data/datasources/remote/news_post_remote_datasource.dart';
import '../../entities/news.dart';
import '../../repositories/news_post_repo.dart';



class FetchAllNewsOfChannel implements AsyncEitherUsecase<List<News>, FetchAllNewsPostOfChannelParams>{
  final NewsPostRepo _newsPostRepo;

  FetchAllNewsOfChannel(this._newsPostRepo);

  @override
  Future<Either<DataCRUDFailure, List<News>>> call(FetchAllNewsPostOfChannelParams params) async{
    return await _newsPostRepo.fetchAllNewsPostOfChannel(params: params);
  }
  
}