import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_scroll_event.freezed.dart';

@freezed
class NewsScrollEvent with _$NewsScrollEvent {
  const factory NewsScrollEvent.scrollUp() = ScrollUp;
  const factory NewsScrollEvent.scrollDown() = ScrollDown;
  const factory NewsScrollEvent.fixScrollState() = FixScrollState; // Новое событие
}
  