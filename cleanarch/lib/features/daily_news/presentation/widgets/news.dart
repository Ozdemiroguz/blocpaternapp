import 'package:cleanarchitecture/features/daily_news/domain/entities/article.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class News extends StatelessWidget {
  final ArticleEntity article;
  final bool isRemovable;
  final void Function(ArticleEntity article)? onRemove;
  final void Function(ArticleEntity article)? onArticlePressed;

  const News({
    Key? key,
    required this.article,
    this.isRemovable = false,
    this.onRemove,
    this.onArticlePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _onTap,
        child: Container(
            padding: const EdgeInsetsDirectional.only(
                start: 14, end: 14, bottom: 7, top: 7),
            height: MediaQuery.of(context).size.width / 2.2,
            child: Row(
              children: [
                _buildImage(context),
                _buildTitleAndDescription(),
              ],
            )));
  }

  Widget _buildImage(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: article!.urlToImage!,
        imageBuilder: (context, imageProvider) => Padding(
              padding: const EdgeInsetsDirectional.only(end: 14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.08),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
              ),
            ),
        progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
              padding: const EdgeInsetsDirectional.only(end: 14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: double.maxFinite,
                  child: CupertinoActivityIndicator(),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.08),
                  ),
                ),
              ),
            ),
        errorWidget: (context, url, error) => Padding(
              padding: const EdgeInsetsDirectional.only(end: 14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: double.maxFinite,
                  child: Icon(Icons.error),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.08),
                  ),
                ),
              ),
            ));
  }

  Widget _buildTitleAndDescription() {
    //articlein içinkdei herşeyi yazdırdım

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              article.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),

            // Description
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  article!.description ?? '',
                  maxLines: 2,
                ),
              ),
            ),

            // Datetime
            Row(
              children: [
                const Icon(Icons.timeline_outlined, size: 16),
                const SizedBox(width: 4),
                Text(
                  article.publishedAt,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onTap() {
    if (onArticlePressed != null) {
      onArticlePressed!(article!);
    }
  }
}
