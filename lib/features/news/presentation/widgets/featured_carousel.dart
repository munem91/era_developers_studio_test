// This file defines the FeaturedCarousel widget, which displays a carousel of featured articles.
// The articles are sorted based on their rating before being displayed.
// The widget listens for scroll notifications to determine if the user has scrolled up or down,
// and triggers corresponding events in the NewsScrollBloc.
// The appearance of the carousel changes based on whether the user has scrolled or not.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/domain.dart';
import '../presentation.dart';

class FeaturedCarousel extends StatelessWidget {
  final List<Article> articles;
  final ScrollController scrollController;

  const FeaturedCarousel({
    Key? key,
    required this.articles,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortedArticles = List<Article>.from(articles)
      ..sort((a, b) => b.rating.compareTo(a.rating));

    final PageController pageController = PageController();

    return BlocBuilder<NewsScrollBloc, NewsScrollState>(
      builder: (context, scrollState) {
        bool isScrolled = scrollState == const NewsScrollState.scrolled();

        return ScrollNotificationListener(
          onScrollUp: () => context
              .read<NewsScrollBloc>()
              .add(const NewsScrollEvent.scrollUp()),
          onScrollDown: () => context
              .read<NewsScrollBloc>()
              .add(const NewsScrollEvent.scrollDown()),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isScrolled
                ? buildScrolledView(context, sortedArticles)
                : buildDefaultView(context, sortedArticles, pageController),
          ),
        );
      },
    );
  }
}
