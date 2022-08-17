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
}
