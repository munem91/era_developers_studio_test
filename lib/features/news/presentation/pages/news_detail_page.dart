import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../domain/domain.dart';

@RoutePage()
class NewsDetailPage extends StatelessWidget {
  final String id;

  const NewsDetailPage({Key? key, @PathParam('id') required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository = GetIt.I<AbstractNewsRepository>();

    return FutureBuilder<Article?>(
      future: repository.getArticle(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return const Scaffold(
            body: Center(child: Text('Article not found')),
          );
        }

        final article = snapshot.data!;
        final title = _addLineBreakBeforeLastWord(article.title);

        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 400,
                            width: double.infinity,
                            child: Image.network(
                              article.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          Positioned(
                            bottom: 16.0,
                            left: 16.0,
                            right: 16.0,
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                title,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    const Shadow(
                                      blurRadius: 10,
                                      color: Colors.black,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              article.description?.replaceAll('\n', '\n\n') ??
                                  '',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 40.0,
                  left: 16.0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () {
                      context.router.pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _addLineBreakBeforeLastWord(String text) {
    List<String> words = text.split(' ');
    if (words.length > 1) {
      String lastWord = words.removeLast();
      return words.join(' ') + '\n' + lastWord;
    }
    return text;
  }
}
