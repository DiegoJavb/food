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
          _cardHistorial(),
          _cardRecomendaciones(),
          _cardNoticias(),
        ],
      ),
    );
  }

  Container _cardHistorial() {
    return Container(
      height: 250.0,
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/cherries.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Text(
              'HISTORIAL',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        onTap: () {
          Get.toNamed('record');
        },
      ),
    );
  }

  Container _cardRecomendaciones() {
    return Container(
      height: 250.0,
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/onions.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Text(
              'RECOMENDACIONES',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        onTap: () {
          Get.toNamed('recomendation');
        },
      ),
    );
  }

  Container _cardNoticias() {
    return Container(
      height: 250.0,
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/dark.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Text(
              'NOTICIAS',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        onTap: () {
          Get.toNamed('news');
        },
      ),
    );
  }
}
