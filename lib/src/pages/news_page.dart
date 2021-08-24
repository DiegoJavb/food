import 'package:flutter/material.dart';
import 'package:food/src/components/customAppBar.dart';
import 'package:food/src/widgets/news_list.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Noticias',
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: NewsList(),
      ),
    );
  }
}
