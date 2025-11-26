import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/responsive_utils.dart';
import 'booking_page.dart';
import 'doctor_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  String? selectedSpecialty;

  final Map<String, List<String>> specialties = {
    'Most Searched': [
      'Dermatology',
      'Dentist',
      'Psychiatry',
    ],
    'Pediatrics & Newborn': [
      'Pediatrics',
      'Newborn Care',
      'Vaccination',
    ],
    'Women Health': [
      'Obstetrics',
      'Gynecology',
      'Fertility',
    ],
    'Surgery': [
      'Orthopedics',
      'General Surgery',
      'Plastic Surgery',
    ],
    'ENT': [
      'Ear, Nose & Throat',
    ],
    'Internal Medicine': [
      'Cardiology',
      'Diabetes',
      'Gastroenterology',
    ],
  };

  List<Map<String, dynamic>> allDoctors = [
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

  List<Map<String, dynamic>> filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    filteredDoctors = List.from(allDoctors);
  }

  void filterDoctors(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredDoctors = List.from(allDoctors);
      } else {
        filteredDoctors = allDoctors.where((doctor) {
          final name = doctor['name'].toString().toLowerCase();
          final specialty = doctor['specialty'].toString().toLowerCase();
          final searchLower = query.toLowerCase();
          return name.contains(searchLower) || specialty.contains(searchLower);
        }).toList();
      }
    });
  }

  void filterBySpecialty(String specialty) {
    setState(() {
      selectedSpecialty = specialty;
      filteredDoctors = allDoctors.where((doctor) {
        return doctor['specialty'].toString().toLowerCase().contains(specialty.toLowerCase());
      }).toList();
    });
  }

  void clearFilters() {
    setState(() {
      selectedSpecialty = null;
      searchController.clear();
      filteredDoctors = List.from(allDoctors);
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
          "Find a Doctor",
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 24 * scale,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.primaryDark,
        actions: [
          if (selectedSpecialty != null || searchController.text.isNotEmpty)
            IconButton(
              onPressed: clearFilters,
              icon: Icon(Icons.clear_all, size: isTablet ? 28 * scale : 24 * scale),
            ),
        ],
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
                  hintText: "Search by specialty, doctor name, or hospital",
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

          // Selected Specialty
          if (selectedSpecialty != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
              child: Row(
                children: [
                  Text(
                    "Showing results for: ",
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  Text(
                    selectedSpecialty!,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  // Tabs
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 8 * scale),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12 * scale),
                    ),
                    child: TabBar(
                      labelColor: AppColors.primary,
                      unselectedLabelColor: AppColors.grey,
                      indicator: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10 * scale),
                      ),
                      tabs: [
                        Tab(text: "Specialties"),
                        Tab(text: "Doctors (${filteredDoctors.length})"),
                      ],
                    ),
                  ),

                  Expanded(
                    child: TabBarView(
                      children: [
                        // Specialties Tab
                        SingleChildScrollView(
                          padding: EdgeInsets.all(16 * scale),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var category in specialties.entries)
                                _buildSpecialtyCategory(
                                  context,
                                  category.key,
                                  category.value,
                                ),
                            ],
                          ),
                        ),

                        // Doctors Tab
                        filteredDoctors.isEmpty
                            ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
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
                                "Try a different search or specialty",
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialtyCategory(BuildContext context, String category, List<String> specialties) {
    final scale = ResponsiveUtils.getScale(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: AppTextStyles.headlineSmall.copyWith(
            fontSize: isTablet ? 20 * scale : 18 * scale,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12 * scale),
        Wrap(
          spacing: 12 * scale,
          runSpacing: 12 * scale,
          children: specialties.map((specialty) {
            return GestureDetector(
              onTap: () => filterBySpecialty(specialty),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16 * scale,
                  vertical: 12 * scale,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12 * scale),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4 * scale,
                      offset: Offset(0, 2 * scale),
                    ),
                  ],
                ),
                child: Text(
                  specialty,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 24 * scale),
      ],
    );
  }
}