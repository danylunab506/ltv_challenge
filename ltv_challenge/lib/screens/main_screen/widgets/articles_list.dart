import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltv_challenge/screens/main_screen/bloc/articles_bloc/articles_bloc.dart';
import 'package:ltv_challenge/screens/main_screen/models/articles_list_model.dart';

import 'article_card.dart';

class ArticlesList extends StatefulWidget {
  const ArticlesList({super.key});

  @override
  State<ArticlesList> createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  final ArticlesBloc _articlesBloc = ArticlesBloc();

  @override
  void initState() {
    _articlesBloc.add(GetArticlesList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _articlesBloc,
        child: BlocListener<ArticlesBloc, ArticlesState>(
          listener: (context, state) {
            if (state is ArticlesListError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<ArticlesBloc, ArticlesState>(
            builder: (context, state) {
              if (state is ArticlesListInitial || state is ArticlesListLoading) {
                return const Center(child: CircularProgressIndicator());

              } else if (state is ArticlesListLoaded) {
                return _articlesListWidget(state.articlesListResponseModel);
                
              } else if (state is ArticlesListError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _articlesListWidget(ArticlesListResponseModel model) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ArticleCard(
                article: model.articles![index],
              );
            },
            childCount: model.articles!.length,
          ),
        ),
      ],
    );
  }
}