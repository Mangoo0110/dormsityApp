import 'dart:collection';

import '../../models/complain_model.dart';

abstract interface class ComplainLocalDatasource{
  Future<void> saveComplain({required ComplainModel complain,});

  Future<void> deleteComplain({required ComplainModel complain});

  Stream<SplayTreeMap<String, ComplainModel>> fetchAllComplains();
}