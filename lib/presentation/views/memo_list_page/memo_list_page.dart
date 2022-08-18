import 'package:ca_riverpod_memo/presentation/viewmodels/memo_list/memo_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MemoListPage extends ConsumerWidget {
  final _memoListProvider = memoListViewModelStateNotifierProvider;

  MemoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memoList = ref.watch(_memoListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memo'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: GridView.builder(
            itemCount: memoList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
              childAspectRatio: 1, //item 의 가로, 세로의 비율
              mainAxisSpacing: 10, //수평 Padding
              crossAxisSpacing: 10, //수직 Padding
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => context.go('/detail', extra: memoList[index]),
                child: Container(
                  color: Colors.orangeAccent,
                  child: Center(child: Text(memoList[index].content)),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/detail'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
