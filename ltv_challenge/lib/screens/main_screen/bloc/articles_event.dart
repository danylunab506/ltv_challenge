part of 'articles_bloc.dart';


@immutable
abstract class ArticlesEvent  {
  const ArticlesEvent();
   
}

class GetArticlesList extends ArticlesEvent {}
