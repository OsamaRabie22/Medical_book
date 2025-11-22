
import 'package:flutter/material.dart';

import 'cheest.dart';

class Chest extends StatelessWidget {
  const Chest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Chest Day",style: TextStyle(fontSize: 30,color: Colors.white,),),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                width: 370,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                    color: Colors.black12
                ),
                child: Column(
                    children: [
                      Container(
                        child:  CircleAvatar(
                          radius:  120,
                          backgroundColor: Colors.blueAccent,
                          child: CircleAvatar(
                            radius: 115,
                            backgroundImage: AssetImage("assets/chest_male_icon.png"),
                          ),
                        ),

                      ),
                      const SizedBox(height: 10,),
                      aaaa(
                        img: 'assets/chestex/damle.jpg', clam: 'tina 3*6',
                      ),
                      aaaa(
                        img: 'assets/chestex/barflat.jpg', clam: 'mira',
                      ),
                      aaaa(
                        img: 'assets/chestex/barflat.jpg', clam: 'osama',
                      ),
                      aaaa(
                        img: 'assets/chestex/barflat.jpg', clam: 'anas',
                      ),   aaaa(
                        img: 'assets/chestex/barflat.jpg', clam: 'ramez',
                      ),

                    ]
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
