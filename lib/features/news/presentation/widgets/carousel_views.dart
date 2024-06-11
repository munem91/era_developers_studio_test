// This file contains the helper functions that build the views for the FeaturedCarousel widget.
// `buildDefaultView` constructs the default view of the carousel with a list of articles displayed in a PageView.
// `buildScrolledView` constructs the view that is displayed when the user has scrolled,
// showing only the top article in a simplified format.

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/domain.dart';
import '../../router/app_router.dart';
import '../presentation.dart';

Widget buildDefaultView(BuildContext context, List<Article> articles,
    PageController pageController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child:
            Text('Featured', style: Theme.of(context).textTheme.displayLarge),
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
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(addLineBreakBeforeLastTwoWords(article.title),
                            style: Theme.of(context).textTheme.displayMedium),
                        if (article.readed) ...[
                          const Row(
                            children: [
                              Icon(Icons.check, color: Colors.green, size: 20),
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

Widget buildScrolledView(BuildContext context, List<Article> articles) {
  final article = articles.first;

  return GestureDetector(
    onTap: () async {
      await context.router.push(NewsDetailRoute(id: article.id));
      context.read<NewsBloc>().add(NewsEvent.markRead(id: article.id));
    },
    child: ArticleListItem(article: article, isFeatured: true),
  );
}
