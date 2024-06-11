import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../domain/domain.dart';
import '../widgets/widgets.dart';

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
        final title = addLineBreakBeforeLastTwoWords(article.title);

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: IconButton(
                icon: Image.asset('assets/icons/back_two.png'),
                color: Colors.white,
                onPressed: () {
                  context.router.pop();
                },
              ),
            ),
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 450,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(article.imageUrl),
                        fit: BoxFit.cover,
                        onError: (context, error) => const Icon(Icons.error),
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.only(
                        bottom: 30.0,
                        left: 40,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        gradient: const LinearGradient(
                          colors: [Colors.black54, Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: Text(title,
                          style: Theme.of(context).textTheme.displayMedium),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        article.description
                                ?.split('\n')
                                .map((line) => line.trimLeft())
                                .join('\n\n') ??
                            '',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
