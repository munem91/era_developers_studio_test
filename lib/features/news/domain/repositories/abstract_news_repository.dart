import '../domain.dart';

abstract class AbstractNewsRepository {
  /// Returns a list of the latest articles.
  Future<List<Article>> getLatestArticles();

  /// Returns a list of the featured articles.
  Future<List<Article>> getFeaturedArticles();

  /// Returns the article with the specified [id].
  Future<Article> getArticle(String id);
}
