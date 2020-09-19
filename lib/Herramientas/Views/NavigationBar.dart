import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pokedex/Herramientas/AppColors.dart';

class NavigationBar extends StatelessWidget {
  bool tipo = false;

  NavigationBar(this.tipo);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipPath(
      clipper: CustomShapeClipper(),
      child: Container(
        height: tipo ? 450 : 140,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.lightRed,
              AppColors.red,
              AppColors.darkRed,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height);

    var firstEndPoint = Offset(size.width * .5, size.height - 30.0);
    var firstControlpoint = Offset(size.width * 0.25, size.height - 50.0);
    path.quadraticBezierTo(firstControlpoint.dx, firstControlpoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 80.0);
    var secondControlPoint = Offset(size.width * .75, size.height - 10);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}