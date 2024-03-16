import 'package:cleanarchitecture/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:cleanarchitecture/features/daily_news/domain/usecases/remove_article.dart';
import 'package:cleanarchitecture/features/daily_news/domain/usecases/save_article.dart';
import 'package:cleanarchitecture/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:cleanarchitecture/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalArticleBloc extends Bloc<LocalArticlesEvent, LocalArticleState> {
  final GetSavedArticleUsecase _getSavedArticlesUsecase;
  final SaveArticleUseCase _saveArticleUsecase;
  final RemoveArticleUsecase _removeArticleUsecase;

  LocalArticleBloc(this._getSavedArticlesUsecase, this._saveArticleUsecase,
      this._removeArticleUsecase)
      : super(LocalArticlesLoading()) {
    on<GetSavedArticles>(onGetSavedArticles);
    on<SaveArticle>(onSaveArticle);
    on<RemoveArticle>(onRemoveArticle);
  }

  void onGetSavedArticles(
      GetSavedArticles event, Emitter<LocalArticleState> emit) async {
    final articles = await _getSavedArticlesUsecase();
    emit(LocalArticlesDone(articles: articles));
  }

  void onSaveArticle(SaveArticle event, Emitter<LocalArticleState> emit) async {
    await _saveArticleUsecase(params: event.article);

    final articles = await _getSavedArticlesUsecase();
    emit(LocalArticlesDone(articles: articles));
  }

  void onRemoveArticle(
      RemoveArticle event, Emitter<LocalArticleState> emit) async {
    await _removeArticleUsecase();
    final articles = await _getSavedArticlesUsecase();
    emit(LocalArticlesDone(articles: articles));
  }
}
