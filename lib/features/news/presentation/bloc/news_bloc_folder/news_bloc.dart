import 'package:era_developers_test_flutter/config/logger_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/domain.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetLatestArticles getLatestArticles;
  final GetFeaturedArticles getFeaturedArticles;

  NewsBloc({
    required this.getLatestArticles,
    required this.getFeaturedArticles,
  }) : super(const NewsState.initial()) {
    on<LoadNews>(_onLoadNews);
    on<MarkAllRead>(_onMarkAllRead);
    on<MarkAllUnread>(_onMarkAllUnread); 
    on<MarkRead>(_onMarkRead); 
    on<MarkUnread>(_onMarkUnread); 
  }

  Future<void> _onLoadNews(LoadNews event, Emitter<NewsState> emit) async {
    emit(const NewsState.loading());
    try {
      logger.i('NewsBloc: Loading latest articles...');
      final latestArticles = await getLatestArticles();
      logger.i('NewsBloc: Latest articles loaded: ${latestArticles.length}');

      logger.i('NewsBloc: Loading featured articles...');
      final featuredArticles = await getFeaturedArticles();
      logger.i('NewsBloc: Featured articles loaded: ${featuredArticles.length}');

      emit(NewsState.loaded(
        latestArticles: latestArticles,
        featuredArticles: featuredArticles,
      ));
      logger.i('NewsBloc: News loaded state emitted.');
    } catch (e) {
      logger.e('NewsBloc: Error loading news', error: e);
      emit(NewsState.error(message: e.toString()));
    }
  }

  void _onMarkAllRead(MarkAllRead event, Emitter<NewsState> emit) {
    if (state is NewsLoaded) {
      final currentState = state as NewsLoaded;
      final updatedLatestArticles = currentState.latestArticles
          .map((article) => article.copyWith(readed: true))
          .toList();
      final updatedFeaturedArticles = currentState.featuredArticles
          .map((article) => article.copyWith(readed: true))
          .toList();
      emit(NewsState.loaded(
        latestArticles: updatedLatestArticles,
        featuredArticles: updatedFeaturedArticles,
      ));
    }
  }

  void _onMarkAllUnread(MarkAllUnread event, Emitter<NewsState> emit) {
    if (state is NewsLoaded) {
      final currentState = state as NewsLoaded;
      final updatedLatestArticles = currentState.latestArticles
          .map((article) => article.copyWith(readed: false))
          .toList();
      final updatedFeaturedArticles = currentState.featuredArticles
          .map((article) => article.copyWith(readed: false))
          .toList();
      emit(NewsState.loaded(
        latestArticles: updatedLatestArticles,
        featuredArticles: updatedFeaturedArticles,
      ));
    }
  }

  void _onMarkRead(MarkRead event, Emitter<NewsState> emit) {
    if (state is NewsLoaded) {
      final currentState = state as NewsLoaded;
      final updatedLatestArticles = currentState.latestArticles
          .map((article) => article.id == event.id
              ? article.copyWith(readed: true)
              : article)
          .toList();
      final updatedFeaturedArticles = currentState.featuredArticles
          .map((article) => article.id == event.id
              ? article.copyWith(readed: true)
              : article)
          .toList();
      emit(NewsState.loaded(
        latestArticles: updatedLatestArticles,
        featuredArticles: updatedFeaturedArticles,
      ));
    }
  }

  void _onMarkUnread(MarkUnread event, Emitter<NewsState> emit) {
    if (state is NewsLoaded) {
      final currentState = state as NewsLoaded;
      final updatedLatestArticles = currentState.latestArticles
          .map((article) => article.id == event.id
              ? article.copyWith(readed: false)
              : article)
          .toList();
      final updatedFeaturedArticles = currentState.featuredArticles
          .map((article) => article.id == event.id
              ? article.copyWith(readed: false)
              : article)
          .toList();
      emit(NewsState.loaded(
        latestArticles: updatedLatestArticles,
        featuredArticles: updatedFeaturedArticles,
      ));
    }
  }
}
