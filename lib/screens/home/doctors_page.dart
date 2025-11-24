import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/responsive_utils.dart';
import '../../widgets/doctor_card.dart';
import 'booking_page.dart';


class DoctorsPage extends StatefulWidget {
  const DoctorsPage({super.key});

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> doctors = [
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
  ];

  List<Map<String, dynamic>> filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    filteredDoctors = List.from(doctors);
  }

  void filterDoctors(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredDoctors = List.from(doctors);
      } else {
        filteredDoctors = doctors.where((doctor) {
          final name = doctor['name'].toString().toLowerCase();
          final specialty = doctor['specialty'].toString().toLowerCase();
          final searchLower = query.toLowerCase();
          return name.contains(searchLower) || specialty.contains(searchLower);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Scaffold( // ← لازم يكون في Scaffold
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text(
          "Doctors",
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
          // Search Bar
          Padding(
            padding: EdgeInsets.all(16 * scale),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(18 * scale),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6 * scale,
                    offset: Offset(0, 2 * scale),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                onChanged: filterDoctors,
                decoration: InputDecoration(
                  hintText: "Search for a doctor or specialty",
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.search,
                    color: AppColors.primary,
                    size: isTablet ? 26 * scale : 22 * scale,
                  ),
                  hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.grey,
                    fontSize: isTablet ? 16 * scale : 14 * scale,
                  ),
                ),
              ),
            ),
          ),

          // نتائج البحث
          Expanded(
            child: filteredDoctors.isEmpty
                ? Center(
              child: Text(
                "No doctors found",
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.grey,
                ),
              ),
            )
                : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
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
                    onBookPressed: () {
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

// باقي الـ pages بردو لازم يكون في Scaffold
class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);
    return Scaffold( // ← مهم
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text(
          "Appointments",
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 24 * scale,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          "Appointments Page",
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 24 * scale,
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);
    return Scaffold( // ← مهم
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 24 * scale,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          "Profile Page",
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 24 * scale,
          ),
        ),
      ),
    );
  }
}