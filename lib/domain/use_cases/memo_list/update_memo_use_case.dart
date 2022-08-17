import 'package:ca_riverpod_memo/domain/models/memo.dart';
import 'package:ca_riverpod_memo/domain/repositories/memo_repository.dart';
import 'package:ca_riverpod_memo/global/interfaces/use_case/param_use_case.dart';
import 'package:dartz/dartz.dart';

class UpdateMemoUseCase extends ParamUseCase<Either<Exception, void>, Memo> {
  final MemoRepository _repository;

  UpdateMemoUseCase(this._repository);

  @override
  Future<Either<Exception, void>> execute(params) {
    return _repository.updateMemo(params);
  }
}
