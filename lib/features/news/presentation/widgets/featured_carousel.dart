import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/domain.dart';
import '../../router/app_router.dart';
import '../presentation.dart';

class FeaturedCarousel extends StatelessWidget {
  final List<Article> articles;
  final ScrollController scrollController;

  const FeaturedCarousel(
      {Key? key, required this.articles, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortedArticles = List<Article>.from(articles)
      ..sort((a, b) => b.rating.compareTo(a.rating));

    final PageController pageController = PageController();

    return BlocBuilder<NewsScrollBloc, NewsScrollState>(
      builder: (context, scrollState) {
        bool isScrolled = scrollState == const NewsScrollState.scrolled();

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification) {
              if (scrollNotification.metrics.axis == Axis.vertical &&
                  scrollNotification.metrics.pixels > 100) {
                context
                    .read<NewsScrollBloc>()
                    .add(const NewsScrollEvent.scrollUp());
              } else if (scrollNotification.metrics.axis == Axis.vertical &&
                  scrollNotification.metrics.pixels < 100) {
                context
                    .read<NewsScrollBloc>()
                    .add(const NewsScrollEvent.scrollDown());
              }
            }
            return false;
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isScrolled
                ? _buildScrolledView(context, sortedArticles)
                : _buildDefaultView(context, sortedArticles, pageController),
          ),
        );
      },
    );
  }

  Widget _buildDefaultView(BuildContext context, List<Article> articles,
      PageController pageController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Text(
            'Featured',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 300.0,
          child: PageView.builder(
            controller: pageController,
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () async {
                    await context.router.push(NewsDetailRoute(id: article.id));
                    context
                        .read<NewsBloc>()
                        .add(NewsEvent.markRead(id: article.id));
                  },
                  child: Container(
                    width: 358.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                        image: NetworkImage(article.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getFormattedTitle(article.title),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 10,
                                  color: Colors.black,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                          ),
                          if (article.readed) ...[
                            const Row(
                              children: [
                                Icon(Icons.check,
                                    color: Colors.green, size: 20),
                                SizedBox(width: 4),
                                Text(
                                  'This news read',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<NewsBloc>()
                                    .add(NewsEvent.markUnread(id: article.id));
                              },
                              child: const Row(
                                children: [
                                  Icon(Icons.undo, color: Colors.red, size: 20),
                                  SizedBox(width: 4),
                                  Text(
                                    'Make unread',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildScrolledView(BuildContext context, List<Article> articles) {
    final article = articles.first;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () async {
          await context.router.push(NewsDetailRoute(id: article.id));
          context.read<NewsBloc>().add(NewsEvent.markRead(id: article.id));
        },
        child: ArticleListItem(article: article, isFeatured: true),
      ),
    );
  }
}
