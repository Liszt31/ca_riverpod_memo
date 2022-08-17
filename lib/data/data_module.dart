import 'package:ca_riverpod_memo/data/repositories/memo_repository_impl.dart';
import 'package:ca_riverpod_memo/data/sources/local/memo_database.dart';
import 'package:ca_riverpod_memo/domain/repositories/memo_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final memoDatabaseProvider = Provider<MemoDatabase>((_) => MemoDatabase());
final memoRepositoryProvider = Provider<MemoRepository>(
    (ref) => MemoRepositoryImpl(ref.watch(memoDatabaseProvider)));
