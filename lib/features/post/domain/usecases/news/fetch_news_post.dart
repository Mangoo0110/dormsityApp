
import 'package:dartz/dartz.dart';

import '../../../../../core/api_handler/failure.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../entities/news.dart';
import '../../repositories/news_post_repo.dart';



class FetchNewsPost implements AsyncEitherUsecase<News, String>{
  final NewsPostRepo _newsPostRepo;

  FetchNewsPost(this._newsPostRepo);

  @override
  Future<Either<DataCRUDFailure, News>> call(String docId) async{
    return await _newsPostRepo.fetchNewsPost(docId: docId);
  }
  
}