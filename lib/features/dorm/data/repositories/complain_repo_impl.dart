import 'dart:collection';


import 'package:dartz/dartz.dart';

import '../../../../../../core/api_handler/failure.dart';
import '../../../../../../core/api_handler/success.dart';
import '../datasources/local/complain_local_datasource.dart';
import '../datasources/remote/complain_remote_datasource.dart';
import '../models/complain_model.dart';
import '../../domain/entities/complain.dart';
import '../../domain/repositories/complain_repo.dart';

import '../../../../../core/api_handler/trycatch.dart';

class ComplainRepoImpl implements ComplainRepo{

  final ComplainLocalDatasource _complainLocalDatasource;
  final ComplainRemoteDatasource _complainRemoteDatasource;

  ComplainRepoImpl(this._complainLocalDatasource, this._complainRemoteDatasource);

  @override
  Future<Either<DataCRUDFailure, Success>> deleteComplain({required Complain complain}) async{
    return asyncTryCatch<Success>(tryFunc: () async{
      return await _complainRemoteDatasource.deleteComplain(complain: ComplainModel.fromEntity(complain)).then((value) => Success());
    });
  }

  @override
  SplayTreeMap<String, Complain> getComplains() {
    _complainRemoteDatasource.fetchAllComplains();
    return _complainRemoteDatasource.complainMap;
  }

  @override
  Future<Either<DataCRUDFailure, Success>> saveComplain({required Complain complain}) async{
    return asyncTryCatch<Success>(tryFunc: () async{
      return await _complainRemoteDatasource.saveComplain(complain: ComplainModel.fromEntity(complain)).then((value) => Success());
    });
  }
  
}