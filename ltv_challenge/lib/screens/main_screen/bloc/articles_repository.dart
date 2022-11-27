import 'package:ltv_challenge/base_provider/base_provider.dart';
import 'package:ltv_challenge/constants/api_contants.dart';
import 'package:ltv_challenge/screens/main_screen/models/articles_list_model.dart';

class ArticlesRepository{

  final BaseProvider _baseProvider = BaseProvider();

  Future<ArticlesListResponseModel> getArticlesList() async {
    final Map<String, dynamic> response = await _baseProvider.get(
      service: ApiConstants.articlesService,
      parameters: {},
    );

    ArticlesListResponseModel articlesListResponseModel = ArticlesListResponseModel.fromJson(response);
    return articlesListResponseModel;
  }
}

class NetworkError extends Error {}