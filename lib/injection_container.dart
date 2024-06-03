import 'package:get_it/get_it.dart';

import 'features/news/data/data.dart';
import 'features/news/domain/domain.dart';
import 'features/news/presentation/presentation.dart';

final getIt = GetIt.I;

void init() {
  // Register Repository
  getIt.registerLazySingleton<AbstractNewsRepository>(
    () => MockNewsRepository(),
  );

  // Register Use Cases
  getIt.registerLazySingleton(() => GetLatestArticles(getIt<AbstractNewsRepository>()));
  getIt.registerLazySingleton(() => GetFeaturedArticles(getIt<AbstractNewsRepository>()));

  // Register BLoC
  getIt.registerFactory(() => NewsBloc(
        getLatestArticles: getIt<GetLatestArticles>(),
        getFeaturedArticles: getIt<GetFeaturedArticles>(),
      ));
}