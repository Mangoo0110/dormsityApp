import 'package:dartz/dartz.dart';
import 'package:dormsity/features/channel/data/models/channel_model.dart';
import 'package:dormsity/features/channel/domain/entities/channel.dart';
import 'package:dormsity/features/channel/domain/usecases/add_channel_admin.dart';
import 'package:dormsity/features/channel/domain/usecases/create_channel.dart';

import '../../../../core/api_handler/failure.dart';

import '../../../../core/api_handler/success.dart';
import '../../../../core/api_handler/trycatch.dart';

import '../../../auth/data/datasources/remote/auth_remote_datasource.dart';
import '../../domain/repositories/channel_repo.dart';
import '../../domain/usecases/follow_channel.dart';
import '../../domain/usecases/unfollow_channel.dart';
import '../datasources/remote_channel_datasource.dart';

class ChannelRepoImpl implements ChannelRepo{

  final RemoteChannelDatasource _remotePageDatasource;

  ChannelRepoImpl(this._remotePageDatasource);

  @override
  Future<Either<DataCRUDFailure, Success>> addAdmin({required AddChannelAdminParams params}) async{
    return asyncTryCatch<Success>(tryFunc: () async{
      return _remotePageDatasource.addAdmin(params: params).then((_) => Success());
    });
  }

  @override
  Future<Either<DataCRUDFailure, Success>> createChannel({required CreateChannelParams params}) async{
    return asyncTryCatch<Success>(tryFunc: () async{
      return _remotePageDatasource.createChannel(createChannelParams: params).then((_) => Success());
    });
  }

  @override
  Future<Either<DataCRUDFailure, List<Channel>>> fetchUsersChannelAsAdmin({required UserAuth userAuth, required int? paginationLimit, required Channel? lastFetchedPage}) async{
    return asyncTryCatch<List<Channel>>(tryFunc: () async{
      return _remotePageDatasource.fetchUsersChannelAsAdmin(userAuth: userAuth, paginationLimit: paginationLimit, lastFetchedPage: lastFetchedPage == null ? null : ChannelModel.fromEntity(lastFetchedPage));
    });
  }

  @override
  Future<Either<DataCRUDFailure, Success>> followChannel({required FollowChannelParams followChannelParams}) async{
    return asyncTryCatch<Success>(tryFunc: () async{
      return _remotePageDatasource.followChannel(followChannelParams: followChannelParams).then((_) => Success());
    });
  }

  @override
  Future<Either<DataCRUDFailure, List<Channel>>> channelSearchResult({required String searchText, required int? paginationLimit, required Channel? lastFetchedPage}) async{
    return asyncTryCatch<List<Channel>>(tryFunc: () async{
      return _remotePageDatasource.channelSearchResult(
        searchText: searchText, 
        paginationLimit: paginationLimit, 
        lastFetchedPage: lastFetchedPage == null ? null : ChannelModel.fromEntity(lastFetchedPage)
      );
    });
  }

  @override
  Future<Either<DataCRUDFailure, Success>> setUnsetPublic({required bool public, required String channelDocId}) async{
    return asyncTryCatch<Success>(tryFunc: () async{
      return _remotePageDatasource.setUnsetPublic(public: public, channelDocId: channelDocId).then((_) => Success());
    });
  }

  @override
  Future<Either<DataCRUDFailure, Success>> unfollowChannel({required UnFollowChannelParams unFollowChannelParams}) async{
    return asyncTryCatch<Success>(tryFunc: () async{
      return _remotePageDatasource.unfollowChannel(unfollowChannelParams: unFollowChannelParams).then((_) => Success());
    });
  }
  
  @override
  Future<Either<DataCRUDFailure, List<Channel>>> fetchAllChannelsOfPage({required String pageDocId}) async{
    return asyncTryCatch<List<Channel>>(tryFunc: () async{
      return _remotePageDatasource.fetchAllChannelsOfPage(pageDocId: pageDocId);
    });
  }
  
  @override
  Future<Either<DataCRUDFailure, List<String>>> adminChannelIdList({required UserAuth userAuth}) async{
    return asyncTryCatch<List<String>>(tryFunc: () async{
      return _remotePageDatasource.fetchUsersChannelIdListAsAdmin(userAuth: userAuth);
    });
  }
  
  @override
  Future<Either<DataCRUDFailure, List<String>>> fetchUsersFollowingChannelIdList({required UserAuth userAuth}) async{
    return asyncTryCatch<List<String>>(tryFunc: () async{
      return _remotePageDatasource.fetchUsersFollowingChannelIdList(userAuth: userAuth);
    });
  }
  
  @override
  Future<Either<DataCRUDFailure, Channel>> fetchChannel({required String channelDocId}) async{
    return asyncTryCatch<Channel>(tryFunc: () async{
      return _remotePageDatasource.fetchChannel(channelDocId: channelDocId);
    });
  }

  // @override
  // Future<Either<DataCRUDFailure, List<Page>>> PageSearchResult({required String searchText, required int? paginationLimit, required Page? lastFetchedPage}) {
  //   // TODO: implement PageSearchResult
  //   throw UnimplementedError();
  // }

}