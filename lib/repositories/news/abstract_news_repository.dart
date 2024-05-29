import 'package:era_developers_test_flutter/repositories/news/models/models.dart';


/// Abstract class for the News Repository. It provides the necessary methods
/// to get latest articles, featured articles and a specific article.
///
/// The class is abstract, so it can't be instantiated. It's meant to be extended
/// by a concrete implementation of the repository.
abstract class AbstractNewsRepository {
  
  /// Returns a list of the latest articles.
  Future<List<Article>> getLatestArticles();
  
  /// Returns a list of the featured articles.
  Future<List<Article>> getFeaturedArticles();
  
  /// Returns the article with the specified [id].
  Future<Article> getArticle(String id);
}

