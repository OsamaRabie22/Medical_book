import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/responsive_utils.dart';
import 'booking_page.dart';
import 'doctor_card.dart';

class SpecialtyDoctorsPage extends StatefulWidget {
  final String specialty;

  const SpecialtyDoctorsPage({
    super.key,
    required this.specialty,
  });

  @override
  State<SpecialtyDoctorsPage> createState() => _SpecialtyDoctorsPageState();
}

class _SpecialtyDoctorsPageState extends State<SpecialtyDoctorsPage> {
  List<Map<String, dynamic>> filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    _filterDoctorsBySpecialty();
  }

  void _filterDoctorsBySpecialty() {
    final allDoctors = [
      {
        'name': "Dr. Ahmed Hassan",
        'specialty': "Cardiologist",
        'location': "Cairo – Maadi",
        'rating': 4.9,
        'image': "assets/photogrid.photocollagemaker.photoeditor.squarepic_202422121565198.png",
      },
      {
        'name': "Dr. Sara Mohamed",
        'specialty': "Dermatologist",
        'location': "Cairo – Nasr City",
        'rating': 4.8,
        'image': "assets/photogrid.photocollagemaker.photoeditor.squarepic_202422121565198.png",
      },
      {
        'name': "Dr. Mahmoud Ali",
        'specialty': "Pediatrician",
        'location': "Giza – Dokki",
        'rating': 4.7,
        'image': "assets/photogrid.photocollagemaker.photoeditor.squarepic_202422121565198.png",
      },
      {
        'name': "Dr. Mona Samy",
        'specialty': "Dentist",
        'location': "Cairo – Heliopolis",
        'rating': 4.9,
        'image': "assets/photogrid.photocollagemaker.photoeditor.squarepic_202422121565198.png",
      },
      {
        'name': "Dr. Khaled Omar",
        'specialty': "Surgeon",
        'location': "Alexandria",
        'rating': 4.6,
        'image': "assets/photogrid.photocollagemaker.photoeditor.squarepic_202422121565198.png",
      },
    ];

    setState(() {
      filteredDoctors = allDoctors.where((doctor) {
        return doctor['specialty'].toString().toLowerCase().contains(
          widget.specialty.toLowerCase(),
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text(
          widget.specialty,
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 24 * scale,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.primaryDark,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16 * scale),
            child: Row(
              children: [
                Text(
                  "${filteredDoctors.length} Doctors found",
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredDoctors.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.medical_services,
                    size: 60 * scale,
                    color: AppColors.grey,
                  ),
                  SizedBox(height: 16 * scale),
                  Text(
                    "No doctors found",
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  SizedBox(height: 8 * scale),
                  Text(
                    "Try a different specialty",
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: EdgeInsets.all(16 * scale),
              itemCount: filteredDoctors.length,
              itemBuilder: (context, index) {
                final doctor = filteredDoctors[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 12 * scale),
                  child: DoctorCard(
                    name: doctor['name'],
                    specialty: doctor['specialty'],
                    location: doctor['location'],
                    rating: doctor['rating'],
                    image: doctor['image'],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingPage(
                            doctorName: doctor['name'],
                            specialty: doctor['specialty'],
                            doctorImage: doctor['image'],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}