import 'dart:collection';

import 'package:dartz/dartz.dart';

import '../../../../../core/api_handler/failure.dart';
import '../../../../../core/api_handler/success.dart';
import '../entities/complain.dart';

abstract interface class ComplainRepo{

  Future<Either<DataCRUDFailure, Success>> saveComplain({required Complain complain,});

  Future<Either<DataCRUDFailure, Success>> deleteComplain({required Complain complain});

  SplayTreeMap<String, Complain> getComplains();

}