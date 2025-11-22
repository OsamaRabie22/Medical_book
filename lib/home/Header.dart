import 'package:flutter/material.dart';

Widget buildHeader() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Row(
        children: [
          SizedBox(height: 80),
          CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage(
                "assets/photogrid.photocollagemaker.photoeditor.squarepic_202422121565198.png"),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, Osama👋",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
      Row(
        children: [
          Icon(Icons.notifications_none, size: 28, color: Colors.teal.shade700),
        ],
      ),
    ],
  );
}
