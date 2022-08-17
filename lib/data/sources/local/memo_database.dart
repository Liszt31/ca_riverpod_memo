import 'package:ca_riverpod_memo/domain/models/memo.dart';
import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MemoDatabase {
  static const _databaseName = 'memo_database1.db';
  static const _tableName = 'memo_table';
  static const _databaseVersion = 1;
  static const _columnId = 'id';
  static const _columnContent = 'content';
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, _) {
        db.execute('''
          CREATE TABLE $_tableName(
            $_columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $_columnContent TEXT NOT NULL
          )
        ''');
      },
      version: _databaseVersion,
    );
  }

  Future<Either<Exception, List<Memo>>> getMemos() async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> result = await db.query(_tableName);
      List<Memo> memoList = [];
      for (var memo in result) {
        memoList.add(Memo.fromJson(memo));
      }
      return Right(memoList);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, Memo>> insertMemo(final String content) async {
    final db = await database;
    try {
      late final Memo result;
      await db.transaction((txn) async {
        final id = await txn.insert(
          _tableName,
          Memo(content: content).toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        final results = await txn
            .query(_tableName, where: '$_columnId = ?', whereArgs: [id]);
        result = Memo.fromJson(results.first);
      });
      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, void>> updateMemo(final Memo memo) async {
    final db = await database;

    try {
      final memoMap = memo.toJson();
      final int id = memoMap['id'];
      await db.update(
        _tableName,
        memoMap,
        where: '$_columnId = ?',
        whereArgs: [id],
      );
      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
