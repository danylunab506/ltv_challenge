import 'package:flutter/material.dart';
import 'package:ltv_challenge/screens/article_screen/article_screen.dart';
import 'package:ltv_challenge/screens/main_screen/models/articles_list_model.dart';
import 'package:ltv_challenge/utils/utils.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({
    super.key,
    required this.article
  });

  @override
  Widget build(BuildContext context) {
    final String imageUrl = generateCorrectUrlForImages(
      imageUrl: article.image
    );

    return InkWell(
      onTap: (){
        Navigator. of( context).push(
          MaterialPageRoute (builder: (BuildContext context){
            return ArticleScreen(
              article: article,
            );
          }
          )
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  imageUrl,
                  fit: BoxFit.fitHeight,
                  height: 60.0,
                  width: 60.0,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox.shrink();
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0, 
                      right: 10.0
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${article.title}',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          '${article.description}',
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          margin: const EdgeInsets.only(
                            bottom: 5.0
                          ),
                          child: Text(
                            '${article.author}',
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.normal
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            '${article.articleDate}',
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.normal
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                )
    
                // Text("${article.title}"),
                // Text( "${article.author}"),
                // Text("${article.articleDate}"),
                // Text("${article.description}"),
              ],
            )
          ),
          const Divider(
            height: 10.0,
            color: Colors.blueGrey,
          )
        ],
      ),
    );
  }
}