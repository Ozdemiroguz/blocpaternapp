import 'package:equatable/equatable.dart';

abstract class RemoteArticleEvent extends Equatable {
  const RemoteArticleEvent();
}

class GetArticles extends RemoteArticleEvent {
  const GetArticles();
  @override
  List<Object> get props => [];
}
