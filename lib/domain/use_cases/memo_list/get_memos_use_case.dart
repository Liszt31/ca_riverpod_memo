import 'package:ca_riverpod_memo/domain/models/memo.dart';
import 'package:ca_riverpod_memo/domain/repositories/memo_repository.dart';
import 'package:ca_riverpod_memo/global/interfaces/use_case/no_param_use_case.dart';
import 'package:dartz/dartz.dart';

class GetMemosUseCase extends NoParamUseCase<Either<Exception, List<Memo>>> {
  final MemoRepository _repository;

  GetMemosUseCase(this._repository);

  @override
  Future<Either<Exception, List<Memo>>> execute() {
    return _repository.getMemoList();
  }
}
