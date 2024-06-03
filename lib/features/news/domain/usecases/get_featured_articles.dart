import '../domain.dart';

class GetFeaturedArticles {
  final AbstractNewsRepository repository;

  GetFeaturedArticles(this.repository);

  Future<List<Article>> call() async {
    final articles = await repository.getFeaturedArticles();
    return articles;
  }
}
