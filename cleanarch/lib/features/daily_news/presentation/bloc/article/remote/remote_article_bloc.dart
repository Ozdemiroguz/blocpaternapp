import 'package:cleanarchitecture/core/resources/data_state.dart';
import 'package:cleanarchitecture/features/daily_news/domain/usecases/get_article.dart';
import 'package:cleanarchitecture/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:cleanarchitecture/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteArticlesBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticleUsecase _getArticleUsecase;
  RemoteArticlesBloc(this._getArticleUsecase)
      : super(const RemoteArticlesLoading()) {
    on<GetArticles>(onGetArticles);
  }
  void onGetArticles(
      GetArticles event, Emitter<RemoteArticleState> emit) async {
    final dataState = await _getArticleUsecase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticlesDone(articles: dataState.data!));
    }
    if (dataState is DataFailed) {
      print("Error: ${dataState.error}");
      emit(RemoteArticlesError(exception: dataState.error!));
    }
  }
}
