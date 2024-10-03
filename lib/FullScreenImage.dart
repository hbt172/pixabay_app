import 'package:flutter/material.dart';

class FullScreenImage extends StatefulWidget {
  final String likes;
  final String views;
  final String image;

  const FullScreenImage({Key? key,required this.likes,required this.views, required this.image}) : super(key: key);

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Screen Image'),
      ),
      body: Image.network(widget.image, fit: BoxFit.cover)
    );
  }
}
