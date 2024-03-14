import 'package:cleanarchitecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:cleanarchitecture/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:cleanarchitecture/features/daily_news/presentation/widgets/news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text('Daily News'),
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticlesBloc, RemoteArticleState>(
        builder: (_, state) {
      if (state is RemoteArticlesLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is RemoteArticlesDone) {
        return ListView.builder(
          itemCount: state.articles!.length,
          itemBuilder: (context, index) {
            return News(article: state.articles![index]);
          },
        );
      }
      if (state is RemoteArticlesError) {
        return Center(
          child: Center(
            child: Icon(Icons.refresh),
          ),
        );
      }
      return const SizedBox();
    });
  }
}
