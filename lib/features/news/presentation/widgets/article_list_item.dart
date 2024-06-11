import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../domain/domain.dart';
import '../../router/app_router.dart';
import '../presentation.dart';

class ArticleListItem extends StatelessWidget {
  final Article article;
  final bool isFeatured;

  const ArticleListItem(
      {Key? key, required this.article, this.isFeatured = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await context.router.push(NewsDetailRoute(id: article.id));
        context.read<NewsBloc>().add(NewsEvent.markRead(id: article.id));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                article.imageUrl,
                width: 103.0,
                height: 103.0,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (article.readed) ...[
                    Row(
                      children: [
                        const Icon(Icons.check, color: Colors.green, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'This news read',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.green,
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
                      child: Row(
                        children: [
                          const Icon(Icons.undo, color: Colors.red, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            'Make unread',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.red,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                  ],
                  Text(
                    getFormattedTitle(article.title),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  if (!isFeatured) ...[
                    const SizedBox(height: 8.0),
                    Text(
                      timeago.format(article.publicationDate),
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
