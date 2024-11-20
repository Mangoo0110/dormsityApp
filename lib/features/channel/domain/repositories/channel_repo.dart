import 'package:dartz/dartz.dart';
import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../auth/data/datasources/remote/auth_remote_datasource.dart';
import '../entities/channel.dart';
import '../usecases/add_channel_admin.dart';
import '../usecases/create_channel.dart';
import '../usecases/follow_channel.dart';
import '../usecases/unfollow_channel.dart';


abstract interface class ChannelRepo {
  Future<Either<DataCRUDFailure, Success>> createChannel({required CreateChannelParams params});

  Future<Either<DataCRUDFailure, Channel>> fetchChannel({required String channelDocId});

  /// userId is the new admin's uid in database.
  Future<Either<DataCRUDFailure, Success>> addAdmin({required AddChannelAdminParams params});

  Future<Either<DataCRUDFailure, Success>> setUnsetPublic({required bool public, required String channelDocId});

  Future<Either<DataCRUDFailure, Success>> followChannel({required FollowChannelParams followChannelParams});

  Future<Either<DataCRUDFailure, Success>> unfollowChannel({required UnFollowChannelParams unFollowChannelParams});

  Future<Either<DataCRUDFailure, List<Channel>>> channelSearchResult({required String searchText, required int? paginationLimit, required Channel? lastFetchedPage});

  Future<Either<DataCRUDFailure, List<Channel>>> fetchUsersChannelAsAdmin({required UserAuth userAuth, required int? paginationLimit, required Channel? lastFetchedPage});
  
  Future<Either<DataCRUDFailure,List<String>>> adminChannelIdList({required UserAuth userAuth});

  Future<Either<DataCRUDFailure,List<String>>> fetchUsersFollowingChannelIdList({required UserAuth userAuth});

  Future<Either<DataCRUDFailure,List<Channel>>> fetchAllChannelsOfPage({required String pageDocId});

}