import 'package:bloc/bloc.dart';
import 'package:ltv_challenge/screens/main_screen/models/articles_list_model.dart';
import 'package:meta/meta.dart';

import 'articles_repository.dart';
part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  
  ArticlesBloc() : super(ArticlesListInitial()) {
    final ArticlesRepository articlesRepository = ArticlesRepository();

    on<GetArticlesList>((event, emit) async {
      try {
        emit(ArticlesListLoading());
        final ArticlesListResponseModel articlesListResponse = await articlesRepository.getArticlesList();
        emit(ArticlesListLoaded(articlesListResponse));
        if (articlesListResponse.error != null) {
          emit(ArticlesListError(articlesListResponse.error));
        }
      } on NetworkError {
        emit(const ArticlesListError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
