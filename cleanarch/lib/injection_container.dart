import 'package:cleanarchitecture/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:cleanarchitecture/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:cleanarchitecture/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:cleanarchitecture/features/daily_news/domain/repository/article.repository.dart';
import 'package:cleanarchitecture/features/daily_news/domain/usecases/get_article.dart';
import 'package:cleanarchitecture/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:cleanarchitecture/features/daily_news/domain/usecases/remove_article.dart';
import 'package:cleanarchitecture/features/daily_news/domain/usecases/save_article.dart';
import 'package:cleanarchitecture/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:cleanarchitecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import "package:get_it/get_it.dart";
import 'package:dio/dio.dart';

final sl = GetIt.instance; // Service Locator

Future<void> initalizeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);
//dio
  sl.registerSingleton<Dio>(Dio());

  //dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl(), sl()));

  //usecases
  sl.registerSingleton<GetArticleUsecase>(GetArticleUsecase(sl()));

  sl.registerSingleton<GetSavedArticleUsecase>(GetSavedArticleUsecase(sl()));

  sl.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(sl()));

  sl.registerSingleton<RemoveArticleUsecase>(RemoveArticleUsecase(sl()));

  //bloc
  sl.registerFactory<RemoteArticlesBloc>(() => RemoteArticlesBloc(sl()));

  sl.registerFactory<LocalArticleBloc>(
      () => LocalArticleBloc(sl(), sl(), sl()));
}
