
import 'package:dartz/dartz.dart';

import '../../../../../core/api_handler/failure.dart';
import '../../../../../core/api_handler/success.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../entities/news.dart';
import '../../repositories/news_post_repo.dart';



class CreateNewsPost implements AsyncEitherUsecase<Success, News>{
  final NewsPostRepo _newsPostRepo;

  CreateNewsPost(this._newsPostRepo);

  @override
  Future<Either<DataCRUDFailure, Success>> call(News news) async{
    return await _newsPostRepo.createNewsPost(news: news);
  }
  
}