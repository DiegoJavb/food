import 'package:flutter/material.dart';
import 'package:food/src/components/customListTile.dart';
import 'package:food/src/model/article_model.dart';
import 'package:food/src/services/api_services.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  ApiService client = ApiService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: client.getArticle(),
      builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
        //verificamos si estamos recibiendo una respuesta
        if (snapshot.hasData) {
          List<Article> articles = snapshot.data!;
          return ListView.separated(
            //crearemos un ListTile personalizado
            itemCount: articles.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.0),
            itemBuilder: (context, index) {
              return customListTile(articles[index], context);
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
