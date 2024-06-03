import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../presentation.dart';

@RoutePage()
class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                context.router.pop();
              },
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Notifications',
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
              ),
            ),
            BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsLoaded) {
                  final allRead = state.latestArticles
                          .every((article) => article.readed) &&
                      state.featuredArticles.every((article) => article.readed);
                  return GestureDetector(
                    onTap: () {
                      if (allRead) {
                        context
                            .read<NewsBloc>()
                            .add(const NewsEvent.markAllUnread());
                      } else {
                        context
                            .read<NewsBloc>()
                            .add(const NewsEvent.markAllRead());
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: Text(
                          allRead ? 'Mark all unread' : 'Mark all read',
                          style: Theme.of(context).appBarTheme.titleTextStyle,
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox(width: 16);
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (latestArticles, featuredArticles) =>
                NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                Future.delayed(const Duration(milliseconds: 100), () {
                  if (scrollNotification is ScrollUpdateNotification) {
                    if (scrollNotification.metrics.axis == Axis.vertical &&
                        scrollNotification.metrics.pixels > 100) {
                      context
                          .read<NewsScrollBloc>()
                          .add(const NewsScrollEvent.scrollUp());
                    } else if (scrollNotification.metrics.axis ==
                            Axis.vertical &&
                        scrollNotification.metrics.pixels < 100) {
                      context
                          .read<NewsScrollBloc>()
                          .add(const NewsScrollEvent.scrollDown());
                    }
                  }
                });
                return false;
              },
              child: ListView(
                controller: _scrollController,
                children: [
                  BlocBuilder<NewsScrollBloc, NewsScrollState>(
                    builder: (context, scrollState) {
                      return Column(
                        children: [
                          SizedBox(
                              height: scrollState ==
                                      const NewsScrollState.scrolled()
                                  ? 100
                                  : 0),
                          FeaturedCarousel(
                            articles: featuredArticles,
                            scrollController: _scrollController,
                          ),
                        ],
                      );
                    },
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Text(
                      'Latest news',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: latestArticles.length,
                    itemBuilder: (context, index) {
                      return ArticleListItem(article: latestArticles[index]);
                    },
                  ),
                ],
              ),
            ),
            error: (message) => Center(child: Text(message)),
          );
        },
      ),
    );
  }
}
