import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoaderWidget extends StatefulWidget {
  @override
  _LoaderWidgetState createState() => _LoaderWidgetState();
}

class _LoaderWidgetState extends State<LoaderWidget> {
  @override
  Widget build(BuildContext context) {
   return Container(
         color: Colors.transparent,
         constraints: const BoxConstraints(maxHeight: 200.0,maxWidth: 150),
         child: Center(
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Image.asset(
               "assets/loader/loading.gif",
               height: 180,
               width: 250,
             ),
           ),
         ),
     );
   }
  }

