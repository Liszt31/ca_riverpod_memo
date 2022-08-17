import 'package:ca_riverpod_memo/domain/models/memo.dart';
import 'package:ca_riverpod_memo/domain/repositories/memo_repository.dart';
import 'package:ca_riverpod_memo/global/interfaces/use_case/param_use_case.dart';
import 'package:dartz/dartz.dart';

class CreateMemoUseCase extends ParamUseCase<Either<Exception, Memo>, String> {
  final MemoRepository _repository;

  CreateMemoUseCase(this._repository);

  @override
  Future<Either<Exception, Memo>> execute(params) {
    return _repository.createMemo(params);
  }
}
