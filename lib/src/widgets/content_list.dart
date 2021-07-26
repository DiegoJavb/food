import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Contentlist extends StatelessWidget {
  const Contentlist({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: _cardTipo1(),
          ),
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: _cardTipo2(),
          ),
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: _cardTipo3(),
          ),
        ],
      ),
    );
  }

  Widget _cardTipo1() {
    final card = Container(
      width: 250.0,
      child: Row(
        children: [
          FadeInImage(
            image: NetworkImage(
                'https://s1.1zoom.me/big3/471/Painting_Art_Back_view_Photographer_575380_3840x2400.jpg'),
            placeholder: AssetImage('assets/jar-loading.gif'),
            fadeInDuration: Duration(milliseconds: 200),
            height: 80.0,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextButton(
              onPressed: () {
                Get.toNamed('record');
              },
              child: Text(
                'Historial',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: Offset(2.0, 8.0))
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: card,
      ),
    );
  }

  Widget _cardTipo2() {
    final card = Container(
      width: 250.0,
      child: Row(
        children: [
          FadeInImage(
            image: NetworkImage(
                'https://s1.1zoom.me/big3/471/Painting_Art_Back_view_Photographer_575380_3840x2400.jpg'),
            placeholder: AssetImage('assets/jar-loading.gif'),
            fadeInDuration: Duration(milliseconds: 200),
            height: 80.0,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextButton(
              onPressed: () {
                Get.toNamed('recomendation');
              },
              child: Text(
                'recomendaciones',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: Offset(2.0, 8.0))
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: card,
      ),
    );
  }

  Widget _cardTipo3() {
    final card = Container(
      width: 250.0,
      child: Row(
        children: [
          FadeInImage(
            image: NetworkImage(
                'https://s1.1zoom.me/big3/471/Painting_Art_Back_view_Photographer_575380_3840x2400.jpg'),
            placeholder: AssetImage('assets/jar-loading.gif'),
            fadeInDuration: Duration(milliseconds: 200),
            height: 80.0,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Noticias',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: Offset(2.0, 8.0))
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: card,
      ),
    );
  }
}
