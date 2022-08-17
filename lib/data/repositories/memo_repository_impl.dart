import 'package:ca_riverpod_memo/data/sources/local/memo_database.dart';
import 'package:ca_riverpod_memo/domain/models/memo.dart';
import 'package:ca_riverpod_memo/domain/repositories/memo_repository.dart';
import 'package:dartz/dartz.dart';

class MemoRepositoryImpl implements MemoRepository {
  final MemoDatabase database;

  const MemoRepositoryImpl(this.database);

  @override
  Future<Either<Exception, List<Memo>>> getMemoList() async {
    final memoList = await database.getMemos();
    print(memoList.length());
    return memoList;
  }

  @override
  Future<Either<Exception, Memo>> createMemo(String content) {
    return database.insertMemo(content);
  }

  @override
  Future<Either<Exception, void>> updateMemo(Memo memo) {
    return database.updateMemo(memo);
  }
}
