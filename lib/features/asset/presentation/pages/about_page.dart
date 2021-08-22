import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation? _animation;

  final textStyle = TextStyle(
    color: Colors.black,
    fontSize: 30,
    fontFamily: GoogleFonts.indieFlower().fontFamily,
  );

  @override
  void initState() {
    super.initState();
    _setUpAnimation();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (_animationController == null) {
      return const SizedBox();
    }
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController!,
        builder: (BuildContext context, Widget? child) => Container(
          color: Colors.blueAccent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildCardAuthor(size),
                _buildCardVersion(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardAuthor(Size size) {
    return Transform(
      transform:
          Matrix4.translationValues(_animation!.value * size.width, 0.0, 0.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 16.0, left: 16.0),
              child: Text('Autor',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0)),
            ),
            ListTile(
              leading: const Icon(Icons.perm_identity, color: Colors.black),
              title: Text('Valdiney Menezes', style: textStyle),
            ),
            ListTile(
                leading: const Icon(Icons.email, color: Colors.black),
                title: const Text('Envie-nos um Email'),
                subtitle: Text(
                  'dineydm@gmail.com',
                  style: textStyle,
                ),
                onTap: () => launch(
                    'mailto:<dineydm@gmail.com>?subject=Asset%20Variation&body=Oi')),
          ],
        ),
      ),
    );
  }

  Widget _buildCardVersion(Size size) {
    return Transform(
      transform: Matrix4.translationValues(
          _animation!.value * 3.0 * size.width, 0.0, 0.0),
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.update, color: Colors.black),
              title: const Text('Versão'),
              subtitle: Text(
                '1.0.0',
                style: textStyle,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _setUpAnimation() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _animation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController!, curve: Curves.fastOutSlowIn));

    _animationController!.forward();
  }
}
