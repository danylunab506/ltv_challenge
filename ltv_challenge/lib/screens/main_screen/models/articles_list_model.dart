import 'package:ltv_challenge/utils/utils.dart';

class ArticlesListResponseModel {

  String? lastRev;
  List<Article>? articles;
  String? error;

  ArticlesListResponseModel({
    this.lastRev,
    this.articles,
  });

  ArticlesListResponseModel.withError(String errorMessage) {
    error = errorMessage;
  }

  factory ArticlesListResponseModel.fromJson(Map<String, dynamic> json) => ArticlesListResponseModel(
    lastRev: checkString(json["last_rev"]),
    articles: List<Article>.from(checkList(json["articles"]).map((x) => Article.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "last_rev": lastRev,
    "articles": List<Article>.from(articles!.map((x) => x.toJson())),
  };
}

class Article {

  String? title;
  String? description;
  String? author;
  String? image;
  String? articleDate;
  String? link;
  String? uuid;

  Article({
    this.title,
    this.description,
    this.author,
    this.image,
    this.articleDate,
    this.link,
    this.uuid,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
      title: checkString(json["title"]),
      description: checkString(json["description"]),
      author: checkString(json["author"]),
      image: checkString(json["image"]),
      articleDate: checkString(json["article_date"]),
      link: checkString(json["link"]),
      uuid: checkString(json["uuid"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "author": author,
    "image": image,
    "article_date": articleDate,
    "link": link,
    "uuid": uuid,
  };
}