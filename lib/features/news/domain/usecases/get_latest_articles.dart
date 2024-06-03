import '../domain.dart';

class GetLatestArticles {
  final AbstractNewsRepository repository;

  GetLatestArticles(this.repository);

  Future<List<Article>> call() async {
    final articles = await repository.getLatestArticles();
    return articles;
  }
}