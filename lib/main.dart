// flutter
import 'package:ca_riverpod_memo/domain/models/memo.dart';
import 'package:flutter/material.dart';

// views
import 'package:ca_riverpod_memo/presentation/views/memo_detail_page/memo_detail_page.dart';
import 'package:ca_riverpod_memo/presentation/views/memo_list_page/memo_list_page.dart';

// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }

  final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) => MemoListPage(),
        routes: <GoRoute>[
          GoRoute(
              path: 'detail',
              builder: (BuildContext context, GoRouterState state) {
                final params = state.extra as Memo?;
                return MemoDetailPage(memo: params);
              }),
        ],
      ),
    ],
  );
}
