import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/domain.dart';

part 'news_state.freezed.dart';

@freezed
class NewsState with _$NewsState {
  const factory NewsState.initial() = NewsInitial;
  const factory NewsState.loading() = NewsLoading;
  const factory NewsState.loaded({
    required List<Article> latestArticles,
    required List<Article> featuredArticles,
  }) = NewsLoaded;
  const factory NewsState.error({required String message}) = NewsError;
}
