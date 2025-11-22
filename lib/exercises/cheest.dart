
import 'package:flutter/material.dart';

class aaaa extends StatelessWidget {

final String img;
final String clam;

  const aaaa({super.key, required this.img, required this.clam});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      width: 350,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
          color: Colors.blueAccent
      ),
      child: Column(
        children: [
          Container(
            child:  Column(
              children: [
                CircleAvatar(
                  radius: 115,
                  backgroundImage: AssetImage(img),
                ),
                Text(clam,style:TextStyle(color: Colors.white60,fontSize: 30,),),
              ],
            ),
          ),
        ],
      ),
    );

  }
}
