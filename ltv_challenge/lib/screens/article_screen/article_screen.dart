import 'package:flutter/material.dart';
import 'package:ltv_challenge/screens/main_screen/models/articles_list_model.dart';
import 'package:webviewx/webviewx.dart';

class ArticleScreen extends StatefulWidget {
  final Article article;

  const ArticleScreen({
    super.key,
    required this.article
  });

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {

  late WebViewXController webviewController;
  ValueNotifier<bool> loadingNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.article.title.toString(),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        )
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            children: [
              SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: _buildWebViewX(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight
                )
              ),
              ValueListenableBuilder(
                valueListenable: loadingNotifier,
                builder: (context, loadingValue, child) {
                  return loadingValue ? const Center(child: CircularProgressIndicator()) : const SizedBox.shrink();
                }
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildWebViewX({
    required double width,
    required double height,
  }) {
    return WebViewX(
      key: UniqueKey(),
      initialContent: widget.article.link.toString(),
      initialSourceType: SourceType.url,
      height: height,
      width: width,
      onWebViewCreated: (controller) => webviewController = controller,
      mobileSpecificParams: const MobileSpecificParams(
        androidEnableHybridComposition: true,
      ),
      onPageFinished: (src) {
        loadingNotifier.value = false;
      },
      navigationDelegate: (navigation) {
        debugPrint(navigation.content.sourceType.toString());
        return NavigationDecision.navigate;
      },
    );
  }
}