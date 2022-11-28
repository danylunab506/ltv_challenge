part of 'articles_bloc.dart';

abstract class ArticlesState {
  const ArticlesState();
}

class ArticlesListInitial extends ArticlesState {}

class ArticlesListLoading extends ArticlesState {}

class ArticlesListLoaded extends ArticlesState {

  final ArticlesListResponseModel articlesListResponseModel;

  const ArticlesListLoaded(
    this.articlesListResponseModel
  );
}

class ArticlesListError extends ArticlesState {
  final String? message;

  const ArticlesListError(
    this.message
  );
}
