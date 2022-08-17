import 'package:ca_riverpod_memo/domain/models/memo.dart';
import 'package:ca_riverpod_memo/presentation/viewmodels/memo_list/memo_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final memoDetailViewModelProvider =
    Provider.autoDispose.family<MemoDetailViewModel, Memo?>((ref, memo) {
  return MemoDetailViewModel(ref.read, memo);
});

class MemoDetailViewModel {
  late final MemoListViewModel _memoListViewModel;
  late int _id;
  var _content = '';
  var _isNewMemo = false;

  String initialContentValue() => _content;
  setContent(final String value) => _content = value;

  MemoDetailViewModel(final Reader read, final Memo? memo) {
    _memoListViewModel = read(memoListViewModelStateNotifierProvider.notifier);
    _initMemo(memo);
  }

  _initMemo(final Memo? memo) {
    if (memo == null) {
      _isNewMemo = true;
    } else {
      _id = memo.id!;
      _content = memo.content;
    }
  }

  createOrUpdateMemo() {
    if (_isNewMemo) {
      _memoListViewModel.createMemo(_content);
    } else {
      final newMemo = Memo(id: _id, content: _content);
      _memoListViewModel.updateMemo(newMemo);
    }
  }
}
