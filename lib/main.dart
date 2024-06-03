import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:era_developers_test_flutter/injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/news/presentation/presentation.dart';
import 'features/news/router/app_router.dart';
import 'theme.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            final bloc = di.getIt<NewsBloc>();
            bloc.add(const LoadNews());
            return bloc;
          },
        ),
        BlocProvider(
          create: (_) => NewsScrollBloc(),
        ),
      ],
      child: MaterialApp.router(
        title: 'News App',
        theme: appTheme,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
