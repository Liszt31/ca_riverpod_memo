import 'package:ca_riverpod_memo/data/data_module.dart';
import 'package:ca_riverpod_memo/domain/use_cases/memo_list/create_memo_use_case.dart';
import 'package:ca_riverpod_memo/domain/use_cases/memo_list/get_memos_use_case.dart';
import 'package:ca_riverpod_memo/domain/use_cases/memo_list/update_memo_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getMemoListUseCaseProvider = Provider<GetMemosUseCase>(
    (ref) => GetMemosUseCase(ref.watch(memoRepositoryProvider)));
final createMemoUseCaseProvider = Provider<CreateMemoUseCase>(
    (ref) => CreateMemoUseCase(ref.watch(memoRepositoryProvider)));
final updateMemoUseCaseProvider = Provider<UpdateMemoUseCase>(
    (ref) => UpdateMemoUseCase(ref.watch(memoRepositoryProvider)));
