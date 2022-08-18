import 'package:ca_riverpod_memo/domain/repositories/memo_repository.dart';
import 'package:ca_riverpod_memo/global/interfaces/use_case/param_use_case.dart';
import 'package:dartz/dartz.dart';

class DeleteMemoUseCase extends ParamUseCase<Either<Exception, void>, int> {
  final MemoRepository _repository;

  DeleteMemoUseCase(this._repository);

  @override
  Future<Either<Exception, void>> execute(params) {
    return _repository.deleteMemo(params);
  }
}
