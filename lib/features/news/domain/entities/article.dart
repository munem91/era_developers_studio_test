import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';

@freezed
class Article with _$Article {
  const factory Article({
    required String id,
    required String title,
    required DateTime publicationDate,
    required String imageUrl,
    @Default(false) bool readed,
    @Default(0.0) double rating,
    String? description,
  }) = _Article;
}
