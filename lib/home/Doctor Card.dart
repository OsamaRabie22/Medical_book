import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String location;
  final double rating;
  final String image;

  const DoctorCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.location,
    required this.rating,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              image,
              width: 85,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.teal.shade800,
                        ),
                      ),
                    ),
                    Icon(Icons.bookmark_border, color: Colors.teal.shade700),
                    // ✅ زر Save
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  specialty,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.location_on,
                        size: 16, color: Colors.red.shade400),
                    const SizedBox(width: 4),
                    Text(location,
                        style: TextStyle(color: Colors.grey.shade700)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.star, size: 18, color: Colors.amber.shade700),
                    const SizedBox(width: 4),
                    Text("$rating", style: TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),

          ),
        ],
      ),
    );
  }
}
