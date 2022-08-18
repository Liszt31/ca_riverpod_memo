import 'package:ca_riverpod_memo/domain/models/memo.dart';
import 'package:ca_riverpod_memo/presentation/viewmodels/memo_detail/memo_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MemoDetailPage extends ConsumerWidget {
  const MemoDetailPage({required this.memo, Key? key}) : super(key: key);
  final Memo? memo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MemoDetailViewModel viewModel =
        ref.read(memoDetailViewModelProvider(memo));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memo'),
        elevation: 0,
        actions: [
          if (viewModel.shouldShowDeleteMemoIcon())
            IconButton(
              onPressed: () => _showConfirmDeleteTodoDialog(context, viewModel),
              icon: const Icon(Icons.delete),
            )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFormField(
                    initialValue: viewModel.initialContentValue(),
                    maxLength: 150,
                    onChanged: (value) => viewModel.setContent(value),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        viewModel.createOrUpdateMemo();
                        GoRouter.of(context).pop();
                      },
                      child: const Text('Save'),
                    ),
                  ),
                ])),
      ),
    );
  }

  _showConfirmDeleteTodoDialog(
      final BuildContext context, final MemoDetailViewModel viewModel) async {
    final bool result = await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: const Text('Delete Memo?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('DELETE'),
            ),
          ],
        );
      },
    );
    if (result) {
      viewModel.deleteMemo();
      Navigator.pop(context);
      // GoRouter.of(context).pop();
    }
  }
}
