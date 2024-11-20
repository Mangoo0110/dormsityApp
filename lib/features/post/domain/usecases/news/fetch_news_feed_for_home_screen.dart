
import 'package:dartz/dartz.dart';

import '../../../../../core/api_handler/failure.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../../data/datasources/remote/news_post_remote_datasource.dart';
import '../../entities/news.dart';
import '../../repositories/news_post_repo.dart';



class FetchNewsFeedForHomeScreen implements AsyncEitherUsecase<List<News>, FetchNewsFeedForHomeScreenParams>{
  final NewsPostRepo _newsPostRepo;

  FetchNewsFeedForHomeScreen(this._newsPostRepo);

  @override
  Future<Either<DataCRUDFailure, List<News>>> call(FetchNewsFeedForHomeScreenParams params) async{
    return await _newsPostRepo.fetchNewsFeedForHomeScreen(params: params);
  }
  
}