import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../data/datasources/remote/news_post_remote_datasource.dart';
import '../entities/news.dart';


abstract class NewsPostRepo {
  Future<Either<DataCRUDFailure, Success>> createNewsPost({required News news});

  Future<Either<DataCRUDFailure, Success>> editNewsPostContent({required EditNewsPostContentParams editNewsPostContentParams});

  Future<Either<DataCRUDFailure, Success>> upVoteNewsPost({required UpVoteNewsPostParams params});

  Future<Either<DataCRUDFailure, Success>> downVoteNewsPost({required DownVoteNewsPostParams params});

  Future<Either<DataCRUDFailure,News>> fetchNewsPost({required String docId});

  Future<Either<DataCRUDFailure,List<News>>> fetchAllNewsPostOfChannel({required FetchAllNewsPostOfChannelParams params});

  Future<Either<DataCRUDFailure,List<News>>> fetchNewsFeedForHomeScreen({required FetchNewsFeedForHomeScreenParams params});
}