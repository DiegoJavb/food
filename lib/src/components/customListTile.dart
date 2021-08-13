import 'package:flutter/material.dart';
import 'package:food/src/model/article_model.dart';
import 'package:food/src/pages/article_detail_page.dart';

Widget customListTile(Article article, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ArticleDetailPage(
            article: article,
          ),
        ),
      );
    },
    child: Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 200.0,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(article.urlToImage!),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              article.source!.name!,
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            article.title!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    ),
  );
}
