import 'package:dartz/dartz.dart';
import 'package:dormsity/features/post/data/models/news_model.dart';
import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../datasources/remote/news_post_remote_datasource.dart';
import '../../domain/entities/news.dart';
import '../../../../core/api_handler/trycatch.dart';
import '../../domain/repositories/news_post_repo.dart';


class NewsPostRepoImpl implements NewsPostRepo{
  final NewsPostRemoteDatasource _newsPostRemoteDatasource;

  NewsPostRepoImpl(this._newsPostRemoteDatasource);

  @override
  Future<Either<DataCRUDFailure, Success>> createNewsPost({required News news}) async{
    return asyncTryCatch<Success>(tryFunc: () async{
      return _newsPostRemoteDatasource.createNewsPost(news: NewsModel.fromEntity(news)).then((_) => Success());
    });
  }

  @override
  Future<Either<DataCRUDFailure, Success>> downVoteNewsPost({required DownVoteNewsPostParams params}) async{
    return asyncTryCatch<Success>(tryFunc: () async{
      return _newsPostRemoteDatasource.downVoteNewsPost(params: params).then((_) => Success());
    });
  }

  @override
  Future<Either<DataCRUDFailure, Success>> editNewsPostContent({required EditNewsPostContentParams editNewsPostContentParams}) async{
    return asyncTryCatch<Success>(tryFunc: () async{
      return _newsPostRemoteDatasource.editNewsPostContent(editNewsPostContentParams: editNewsPostContentParams).then((_) => Success());
    });
  }

  @override
  Future<Either<DataCRUDFailure, List<News>>> fetchAllNewsPostOfChannel({required FetchAllNewsPostOfChannelParams params}) async{
    return asyncTryCatch<List<News>>(tryFunc: () async{
      return _newsPostRemoteDatasource.fetchAllNewsPostOfChannel(params: params);
    });
  }

  @override
  Future<Either<DataCRUDFailure, List<News>>> fetchNewsFeedForHomeScreen({required FetchNewsFeedForHomeScreenParams params}) async{
    return asyncTryCatch<List<News>>(tryFunc: () async{
      return _newsPostRemoteDatasource.fetchNewsFeedForHomeScreen(params: params);
    });
  }

  @override
  Future<Either<DataCRUDFailure, News>> fetchNewsPost({required String docId}) async{
    return asyncTryCatch<News>(tryFunc: () async{
      return _newsPostRemoteDatasource.fetchNewsPost(docId: docId);
    });
  }

  @override
  Future<Either<DataCRUDFailure, Success>> upVoteNewsPost({required UpVoteNewsPostParams params}) async{
    return asyncTryCatch<Success>(tryFunc: () async{
      return _newsPostRemoteDatasource.upVoteNewsPost(params: params).then((_) => Success());
    });
  }
}