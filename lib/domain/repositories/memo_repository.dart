import 'package:ca_riverpod_memo/domain/models/memo.dart';
import 'package:dartz/dartz.dart';

abstract class MemoRepository {
  Future<Either<Exception, List<Memo>>> getMemoList();

  Future<Either<Exception, Memo>> createMemo(String content);

  Future<Either<Exception, void>> updateMemo(Memo memo);

  Future<Either<Exception, void>> deleteMemo(int id);
}
