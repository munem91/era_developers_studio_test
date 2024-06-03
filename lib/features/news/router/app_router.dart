import 'package:auto_route/auto_route.dart';
import 'package:era_developers_test_flutter/features/news/presentation/pages/news_detail_page.dart';
import 'package:era_developers_test_flutter/features/news/presentation/pages/news_page.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: NewsRoute.page, initial: true),
        AutoRoute(page: NewsDetailRoute.page),
      ];
}
