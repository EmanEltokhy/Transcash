import 'package:flutter/material.dart';

class DrawClip1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.95, 0);
    path.lineTo(size.width * 0.65, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.65 - 10, size.height * 0.3 + 10,
        size.width * 0.65, size.height * 0.4);
    path.lineTo(size.width * 0.75, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.75 + 10, size.height * 0.6 + 10,
        size.width * 0.75 + 20, size.height * 0.6 + 5);
    path.lineTo(size.width, size.height * 0.4 + 20);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class DrawClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.83, 0);
    path.lineTo(size.width * 0.58, size.height * 0.2);
    path.quadraticBezierTo(size.width * 0.58 - 10, size.height * 0.2 + 10,
        size.width * 0.58 - 3, size.height * 0.3);
    path.lineTo(size.width * 0.67, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.67 + 10, size.height * 0.6 + 10,
        size.width * 0.67 + 20, size.height * 0.6 + 5);
    path.lineTo(size.width, size.height * 0.4 + 20);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
