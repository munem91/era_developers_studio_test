import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_scroll_state.freezed.dart';

@freezed
class NewsScrollState with _$NewsScrollState {
  const factory NewsScrollState.initial() = _Initial;
  const factory NewsScrollState.scrolled() = _Scrolled;
  const factory NewsScrollState.fixed() = _Fixed; // Новое состояние
}
