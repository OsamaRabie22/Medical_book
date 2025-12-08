import '../home/booking_page.dart';
import '../home/bottom_navigation.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/responsive_utils.dart';
import '../home/doctor_card.dart';

class AppointmentsPageState extends State<AppointmentsPage> {
  int _selectedTab = 0; // 0: Saved, 1: Completed, 2: Cancelled

  // بيانات الأطباء المحفوظين
  List<Map<String, dynamic>> _savedDoctors = [
    {
      'id': 's1',
      'doctorName': "Dr. Khaled Omar",
      'specialty': "Surgeon",
      'rating': 4.6,
      'doctorImage':
          "assets/photogrid.photocollagemaker.photoeditor.squarepic_202422121565198.png",
      'location': "Alexandria",
      'consultationFee': 600.0,
      'nextAvailable': "Tomorrow, 4:00 PM",
      'isSaved': true,
    },
    {
      'id': 's2',
      'doctorName': "Dr. Nour El-Din",
      'specialty': "Neurologist",
      'rating': 4.8,
      'doctorImage':
          "assets/photogrid.photocollagemaker.photoeditor.squarepic_202422121565198.png",
      'location': "Cairo - Zamalek",
      'consultationFee': 450.0,
      'nextAvailable': "Dec 12, 10:00 AM",
      'isSaved': true,
    },
    {
      'id': 's3',
      'doctorName': "Dr. Ahmed Hassan",
      'specialty': "Cardiologist",
      'rating': 4.9,
      'doctorImage':
          "assets/photogrid.photocollagemaker.photoeditor.squarepic_202422121565198.png",
      'location': "Cairo - Maadi",
      'consultationFee': 400.0,
      'nextAvailable': "Today, 2:30 PM",
      'isSaved': true,
    },
  ];

  // بيانات الحجوزات المكتملة
  List<Map<String, dynamic>> _completedAppointments = [
    {
      'id': '2',
      'doctorName': "Dr. Ahmed Hassan",
      'specialty': "Cardiologist",
      'date': "Dec 5, 2024",
      'time': "11:00 AM",
      'status': "Completed",
      'statusColor': AppColors.success,
      'statusBackground': AppColors.success.withOpacity(0.1),
      'doctorImage':
          "assets/photogrid.photocollagemaker.photoeditor.squarepic_202422121565198.png",
      'rating': 4.9,
      'location': "Cairo - Nasr City",
      'consultationFee': 400.0,
      'isSaved': false,
    },
    {
      'id': '5',
      'doctorName': "Dr. Mona Samy",
      'specialty': "Dentist",
      'date': "Dec 3, 2024",
      'time': "09:00 AM",
      'status': "Completed",
      'statusColor': AppColors.success,
      'statusBackground': AppColors.success.withOpacity(0.1),
      'doctorImage':
          "assets/photogrid.photocollagemaker.photoeditor.squarepic_202422121565198.png",
      'rating': 4.9,
      'location': "Alfa Pharmacy - Heliopolis",
      'consultationFee': 250.0,
      'isSaved': false,
    },
  ];

  // بيانات الحجوزات الملغاة
  List<Map<String, dynamic>> _cancelledAppointments = [
    {
      'id': '3',
      'doctorName': "Dr. Sara Mohamed",
      'specialty': "Dermatologist",
      'date': "Nov 30, 2024",
      'time': "02:00 PM",
      'status': "Cancelled",
      'statusColor': AppColors.error,
      'statusBackground': AppColors.error.withOpacity(0.1),
      'doctorImage':
          "assets/photogrid.photocollagemaker.photoeditor.squarepic_202422121565198.png",
      'rating': 4.7,
      'location': "Giza - Dokki",
      'consultationFee': 300.0,
      'isSaved': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text(
          "My Appointments",
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 24 * scale,
            color: AppColors.primaryDark,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.primaryDark,
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            margin: EdgeInsets.all(16 * scale),
            height: 50 * scale,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12 * scale),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4 * scale,
                  offset: Offset(0, 2 * scale),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildTabButton("Saved", 0, scale, isTablet),
                _buildTabButton("Completed", 1, scale, isTablet),
                _buildTabButton("Cancelled", 2, scale, isTablet),
              ],
            ),
          ),

          Expanded(
            child: _buildCurrentTabContent(scale, isTablet),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, int index, double scale, bool isTablet) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.white,
            borderRadius: BorderRadius.circular(12 * scale),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: isTablet ? 16 * scale : 14 * scale,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.white : AppColors.greyDark,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentTabContent(double scale, bool isTablet) {
    switch (_selectedTab) {
      case 0: // Saved
        return _buildSavedTab(scale, isTablet);
      case 1: // Completed
        return _buildAppointmentsTab(_completedAppointments, scale, isTablet);
      case 2: // Cancelled
        return _buildAppointmentsTab(_cancelledAppointments, scale, isTablet);
      default:
        return _buildSavedTab(scale, isTablet);
    }
  }

  Widget _buildSavedTab(double scale, bool isTablet) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Saved Doctors (${_savedDoctors.length})",
            style: AppTextStyles.headlineSmall.copyWith(
              fontSize: 20 * scale,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDark,
            ),
          ),
          SizedBox(height: 16 * scale),
          if (_savedDoctors.isNotEmpty)
            ..._savedDoctors.map((doctor) {
              return Padding(
                padding: EdgeInsets.only(bottom: 16 * scale),
                child: DoctorCard(
                  name: doctor['doctorName'],
                  specialty: doctor['specialty'],
                  location: doctor['location'],
                  rating: doctor['rating'],
                  image: doctor['doctorImage'],
                  isInitiallySaved: doctor['isSaved'],
                  onSaveChanged: () {
                    // إزالة الطبيب من القائمة عندما يضغط على unsave
                    setState(() {
                      doctor['isSaved'] = !doctor['isSaved'];
                      _savedDoctors.removeWhere((d) => !d['isSaved']);
                    });
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingPage(
                          doctorName: doctor['doctorName'],
                          specialty: doctor['specialty'],
                          doctorImage: doctor['doctorImage'],
                          rating: doctor['rating'],
                          location: doctor['location'],
                          consultationFee: doctor['consultationFee'],
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList()
          else
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_border,
                    size: 60 * scale,
                    color: AppColors.grey,
                  ),
                  SizedBox(height: 16 * scale),
                  Text(
                    "No saved doctors",
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  SizedBox(height: 8 * scale),
                  Text(
                    "Save your favorite doctors for quick access",
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAppointmentsTab(
      List<Map<String, dynamic>> appointments, double scale, bool isTablet) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Column(
        children: [
          if (appointments.isNotEmpty)
            ...appointments.map((appointment) {
              return _buildAppointmentCard(appointment, scale, isTablet);
            }).toList()
          else
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _selectedTab == 1
                        ? Icons.check_circle_outline
                        : Icons.cancel_outlined,
                    size: 60 * scale,
                    color: AppColors.grey,
                  ),
                  SizedBox(height: 16 * scale),
                  Text(
                    _selectedTab == 1
                        ? "No completed appointments"
                        : "No cancelled appointments",
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // في ملف appointments_page.dart
  Widget _buildAppointmentCard(
      Map<String, dynamic> appointment, double scale, bool isTablet) {
    return GestureDetector(
      onTap: () {
        // فقط للحجوزات المكتملة (Completed)
        if (_selectedTab == 1) {
          // 1 هو Completed tab
          _navigateToBookingPage(appointment);
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16 * scale),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6 * scale,
              offset: Offset(0, 3 * scale),
            ),
          ],
        ),
        child: Column(
          children: [
            // ... باقي الكود كما هو بدون تغيير
            // Header with status
            Container(
              padding: EdgeInsets.all(16 * scale),
              decoration: BoxDecoration(
                color: appointment['statusBackground'],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16 * scale),
                  topRight: Radius.circular(16 * scale),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12 * scale,
                      vertical: 6 * scale,
                    ),
                    decoration: BoxDecoration(
                      color: appointment['statusColor'],
                      borderRadius: BorderRadius.circular(20 * scale),
                    ),
                    child: Text(
                      appointment['status'],
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 12 * scale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (appointment['isSaved'])
                    Icon(
                      Icons.bookmark,
                      color: AppColors.primary,
                      size: 20 * scale,
                    ),
                ],
              ),
            ),

            // Appointment details
            Padding(
              padding: EdgeInsets.all(16 * scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Doctor info
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12 * scale),
                        child: Image.asset(
                          appointment['doctorImage'],
                          width: 70 * scale,
                          height: 70 * scale,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 16 * scale),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appointment['doctorName'],
                              style: AppTextStyles.headlineSmall.copyWith(
                                fontSize: 16 * scale,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryDark,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4 * scale),
                            Text(
                              appointment['specialty'],
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontSize: 14 * scale,
                                color: AppColors.greyDark,
                              ),
                            ),
                            SizedBox(height: 4 * scale),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16 * scale,
                                ),
                                SizedBox(width: 4 * scale),
                                Text(
                                  appointment['rating'].toString(),
                                  style: TextStyle(
                                    fontSize: 14 * scale,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16 * scale),

                  // Appointment details
                  _buildDetailRow(
                    "Date & Time",
                    "${appointment['date']} • ${appointment['time']}",
                    scale,
                    isTablet,
                  ),
                  _buildDetailRow(
                    "Location",
                    appointment['location'],
                    scale,
                    isTablet,
                  ),
                  _buildDetailRow(
                    "Fee",
                    "EGP ${appointment['consultationFee'].toStringAsFixed(0)}",
                    scale,
                    isTablet,
                  ),

                  // زر Rebook فقط للحجوزات الملغاة (Cancelled)
                  if (_selectedTab == 2) ...[
                    SizedBox(height: 16 * scale),
                    Divider(
                      color: AppColors.greyLight,
                      thickness: 1,
                    ),
                    SizedBox(height: 12 * scale),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          _navigateToBookingPage(appointment);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12 * scale),
                          side: BorderSide(color: AppColors.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12 * scale),
                          ),
                        ),
                        child: Text(
                          "Rebook Appointment",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 14 * scale,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// دالة جديدة للتنقل لصفحة الحجز
  void _navigateToBookingPage(Map<String, dynamic> appointment) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingPage(
          doctorName: appointment['doctorName'],
          specialty: appointment['specialty'],
          doctorImage: appointment['doctorImage'],
          rating: appointment['rating'],
          location: appointment['location'],
          consultationFee: appointment['consultationFee'],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      String label, String value, double scale, bool isTablet) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8 * scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100 * scale,
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 14 * scale,
                color: AppColors.greyDark,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 14 * scale,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
