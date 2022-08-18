import 'package:ca_riverpod_memo/domain/domain_module.dart';
import 'package:ca_riverpod_memo/domain/models/memo.dart';
import 'package:ca_riverpod_memo/domain/use_cases/memo_list/create_memo_use_case.dart';
import 'package:ca_riverpod_memo/domain/use_cases/memo_list/delete_memo_use_case.dart';
import 'package:ca_riverpod_memo/domain/use_cases/memo_list/get_memos_use_case.dart';
import 'package:ca_riverpod_memo/domain/use_cases/memo_list/update_memo_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final memoListViewModelStateNotifierProvider =
    StateNotifierProvider.autoDispose<MemoListViewModel, List<Memo>>((ref) {
  return MemoListViewModel(
    ref.watch(getMemoListUseCaseProvider),
    ref.watch(createMemoUseCaseProvider),
    ref.watch(updateMemoUseCaseProvider),
    ref.watch(deleteMemoUseCaseProvider),
  );
});

class MemoListViewModel extends StateNotifier<List<Memo>> {
  final GetMemosUseCase _getMemosUseCase;
  final CreateMemoUseCase _createMemoUseCase;
  final UpdateMemoUseCase _updateMemoUseCase;
  final DeleteMemoUseCase _deleteMemoUseCase;

  MemoListViewModel(
    this._getMemosUseCase,
    this._createMemoUseCase,
    this._updateMemoUseCase,
    this._deleteMemoUseCase,
  ) : super([]) {
    _getMemoList();
  }

  _getMemoList() async {
    final result = await _getMemosUseCase.execute();
    result.fold((exception) {
      print(exception);
      //TODO: exception
    }, (memoList) {
      state = memoList;
    });
  }

  createMemo(final String content) async {
    final result = await _createMemoUseCase.execute(content);
    result.fold((exception) {
      print(exception);
      //TODO: exception
    }, (newMemo) {
      state = [...state, newMemo];
    });
  }

  updateMemo(final Memo newMemo) async {
    final result = await _updateMemoUseCase.execute(newMemo);
    result.fold((exception) {
      print(exception);
      //TODO: exception
    }, (_) {
      state =
          state.map((memo) => memo.id == newMemo.id ? newMemo : memo).toList();
    });
  }

  deleteMemo(final int id) async {
    final result = await _deleteMemoUseCase.execute(id);
    result.fold((exception) {
      print(exception);
      //TODO: exception
    }, (_) {
      state = state.where((memo) => memo.id != id).toList();
    });
  }
}
