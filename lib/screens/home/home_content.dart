import 'package:flutter/material.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/doctor_card.dart';
import 'header.dart';

class HomeContent extends StatelessWidget
{ const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ✅ اللوجو
            const Center(child: AppLogo()),

            // ✅ Header (رجعناه)
            buildHeader(),
            const SizedBox(height: 25),
            // ✅ Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search for a doctor or specialty",
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.teal.shade700),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ✅ Section Title
            Text(
              "Top Doctors",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.teal.shade800,
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Doctor Cards
            DoctorCard(
              name: "Dr. Ahmed Hassan",
              specialty: "Cardiologist",
              location: "Cairo – Maadi",
              rating: 4.9,
              image: "assets/photogrid.photocollagemaker.photoeditor.squarepic_202422121565198.png",
            ),
            const SizedBox(height: 18),
            DoctorCard(
              name: "Dr. Sara Mohamed",
              specialty: "Dermatologist",
              location: "Cairo – Nasr City",
              rating: 4.8,
              image: "assets/photogrid.photocollagemaker.photoeditor.squarepic_202422121565198.png",
            ),
            const SizedBox(height: 18),
            DoctorCard(
              name: "Dr. Ahmed Hassan",
              specialty: "Cardiologist",
              location: "Cairo – Maadi",
              rating: 4.9,
              image: "assets/photogrid.photocollagemaker.photoeditor.squarepic_202422121565198.png",
            ),
            const SizedBox(height: 18),
            DoctorCard(
              name: "Dr. Ahmed Hassan",
              specialty: "Cardiologist",
              location: "Cairo – Maadi",
              rating: 4.9,
              image: "assets/photogrid.photocollagemaker.photoeditor.squarepic_202422121565198.png",
            ),
            const SizedBox(height: 18),
            DoctorCard(
              name: "Dr. Ahmed Hassan",
              specialty: "Cardiologist",
              location: "Cairo – Maadi",
              rating: 4.9,
              image: "assets/photogrid.photocollagemaker.photoeditor.squarepic_202422121565198.png",
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

}
