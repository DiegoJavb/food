import 'dart:convert';

import 'package:food/src/model/article_model.dart';
import 'package:http/http.dart';

//crearemos el HTTP request services
//nos permitira hacer peticiones a la api, recivir el articulo y
//regresar una lista de articulos

class ApiService {
  //let's add an Endpoint URL, you can check the website documentation
  //NOTA, recuerda usar tu propia APIKEY
  final endPointUrl =
      "http://newsapi.org/v2/everything?q=nutricion&apiKey=e901d9f5d21946cdb8ba81227e2c7312";

  //Now let's create the http request function
  // but first let's import the http package

  Future<List<Article>> getArticle() async {
    Response res = await get(Uri.parse(endPointUrl));

    //first of all let's check that we got a 200 statu code: this mean that the request was a succes
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      //this line will allow us to get the different articles from the json file and putting them into a list
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Can't get the Articles");
    }
  }
}
