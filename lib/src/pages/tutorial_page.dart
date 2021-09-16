import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food/src/components/customAppBar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TutorialPage extends StatefulWidget {
  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  int activeIndex = 0;
  String description = 'Inicia sesion como prefieras';

  final List<String> images = [
    'images/0.png',
    'images/1.png',
    'images/2.png',
    'images/3.png',
    'images/4.png',
    'images/5.png',
    'images/6.png',
    'images/7.png',
    'images/8.png',
    'images/9.png',
    'images/10.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: CustomAppBar(
        title: '',
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CarouselSlider.builder(
                options: CarouselOptions(
                  height: 400.0,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    switch (index) {
                      case 0:
                        setState(() {
                          activeIndex = index;
                          description = 'Inicia sesion como prefieras\n';
                        });
                        break;
                      case 1:
                        setState(() {
                          activeIndex = index;
                          description = 'Navega de manera sencilla\n';
                        });
                        break;
                      case 2:
                        setState(() {
                          activeIndex = index;
                          description =
                              'Mantente informado sobre tus\ncitas realizadas';
                        });
                        break;
                      case 3:
                        setState(() {
                          activeIndex = index;
                          description =
                              'Manten un control sobre los\nalimentos que consumes';
                        });
                        break;
                      case 4:
                        setState(() {
                          activeIndex = index;
                          description =
                              'Mantente informado sobre\nnoticias de salud';
                        });
                        break;
                      case 5:
                        setState(() {
                          activeIndex = index;
                          description =
                              'Actualiza tu información para\ninteractuar con mas usuarios';
                        });
                        break;
                      case 6:
                        setState(() {
                          activeIndex = index;
                          description = 'Añade algunos contactos a\ntu red';
                        });
                        break;
                      case 7:
                        setState(() {
                          activeIndex = index;
                          description =
                              'Administra tus contactos de\nforma sencilla';
                        });
                        break;
                      case 8:
                        setState(() {
                          activeIndex = index;
                          description =
                              'Envia un registro alimenticio\npara ser evaluado';
                        });
                        break;
                      case 9:
                        setState(() {
                          activeIndex = index;
                          description =
                              'Recive notificaciones del\nconsumo alimenticio evaluado';
                        });
                        break;
                      case 10:
                        setState(() {
                          activeIndex = index;
                          description = 'Accede a sus funciones\nrapidamente';
                        });
                        break;
                      default:
                    }
                  },
                ),
                itemCount: images.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  final image = images[index];
                  return buildImage(image, index);
                },
              ),
              SizedBox(height: 20.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              buildIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage(String image, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0),
      color: Colors.grey,
      child: Image.asset(
        image,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: images.length,
      effect: JumpingDotEffect(
        activeDotColor: Colors.blue.shade300,
        dotColor: Colors.pink.shade50,
      ),
    );
  }
}
