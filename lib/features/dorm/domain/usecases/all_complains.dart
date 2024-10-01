// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';
import '../../../../../core/usecases/usecases.dart';
import '../entities/complain.dart';
import '../repositories/complain_repo.dart';

class AllComplains implements NormalUsecase<SplayTreeMap<String, Complain>, NoParams> {

  final ComplainRepo _complainRepo;

  AllComplains(
    this._complainRepo,
  );
  @override
  SplayTreeMap<String, Complain> call(NoParams params) {
    return  _complainRepo.getComplains();
  }

}