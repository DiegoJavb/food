import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: MySliverAppBar(expandedHeight: 180),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  _cardTipo1(),
                  _cardTipo2(),
                  _cardTipo2(),
                  _cardTipo1(),
                  _cardTipo2(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _cardTipo2() {
    final card = Container(
      child: Column(
        children: [
          FadeInImage(
            image: NetworkImage(
                'https://s1.1zoom.me/big3/471/Painting_Art_Back_view_Photographer_575380_3840x2400.jpg'),
            placeholder: AssetImage('assets/jar-loading.gif'),
            fadeInDuration: Duration(milliseconds: 200),
            height: 300.0,
            fit: BoxFit.cover,
          ),
          Container(padding: EdgeInsets.all(10.0), child: Text('algo algo'))
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

  Widget _cardTipo1() {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.photo,
              color: Colors.blue,
            ),
            title: Text('Este es el título de la tarjeta'),
            subtitle: Text(
                'este sool es el  subtitulño que quiero que sea un tanto largo para poder apreciasr mejor la tarjeta'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: Text('Ver'),
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  MySliverAppBar({@required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Image.network(
          "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          fit: BoxFit.cover,
        ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            //Titulo que se mostrara en el app bar
            child: Text(
              "MySliverAppBar",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 23,
              ),
            ),
          ),
        ),
        Positioned(
          top: 30.0,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: CircleAvatar(
              radius: 60.0,
              child: FlutterLogo(),
            ),
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
