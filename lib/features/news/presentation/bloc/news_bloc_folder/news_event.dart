import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_event.freezed.dart';

@freezed
class NewsEvent with _$NewsEvent {
  const factory NewsEvent.loadNews() = LoadNews;
  const factory NewsEvent.markAllRead() = MarkAllRead;
  const factory NewsEvent.markAllUnread() = MarkAllUnread;
  const factory NewsEvent.markRead({required String id}) = MarkRead;
  const factory NewsEvent.markUnread({required String id}) = MarkUnread;
}
