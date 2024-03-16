import 'package:cleanarchitecture/features/daily_news/domain/entities/article.dart';
import 'package:equatable/equatable.dart';

abstract class LocalArticlesEvent extends Equatable {
  final ArticleEntity? article;

  const LocalArticlesEvent({this.article});

  @override
  List<Object> get props => [article!];
}

class GetSavedArticles extends LocalArticlesEvent {
  const GetSavedArticles();
}

class SaveArticle extends LocalArticlesEvent {
  const SaveArticle({required article}) : super(article: article);
}

class RemoveArticle extends LocalArticlesEvent {
  const RemoveArticle({required ArticleEntity article})
      : super(article: article);
}
