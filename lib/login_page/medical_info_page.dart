import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/home.dart';
import '../widgets/app_logo.dart';
import '../widgets/custom_input_field.dart';
import 'sign_up.dart';

class MedicalInfoPage extends StatefulWidget {
  final PatientBasicInfo patientData;

  const MedicalInfoPage({super.key, required this.patientData});

  @override
  State<MedicalInfoPage> createState() => _MedicalInfoPageState();
}

class _MedicalInfoPageState extends State<MedicalInfoPage> {
  final _cityController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  String? _selectedBloodType;
  String? _selectedResidenceType;
  bool _hasHypertension = false;
  bool _hasDiabetes = false;
  bool _hasAnemia = false;
  bool _isMarried = false;

  final List<String> _bloodTypes = [
    'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final baseSize = min(screenWidth, screenHeight);
    final scale = baseSize / 400;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 28 * scale,
          vertical: 20 * scale,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ زر Skip صغير في الأعلى

            SizedBox(height: 15 * scale),
            const Center(child: AppLogo()),
            SizedBox(height: 10 * scale),

            Center(
              child: Text(
                "You can skip and complete later from your profile",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14 * scale,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            SizedBox(height: 15 * scale),

            // ✅ المعلومات الديموجرافية
            Text(
              "Demographic Information (Optional)",
              style: TextStyle(
                fontSize: 16 * scale,
                fontWeight: FontWeight.w600,
                color: Colors.teal.shade800,
              ),
            ),
            SizedBox(height: 16 * scale),

            CustomInputField(
              controller: _cityController,
              hint: "City",
              icon: Icons.location_city_outlined,
              scale: scale,
            ),
            SizedBox(height: 16 * scale),

            Container(
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.05),
                borderRadius: BorderRadius.circular(18 * scale),
                border: Border.all(
                  color: Colors.teal.withOpacity(0.3),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
              child: DropdownButtonFormField<String>(
                value: _selectedBloodType,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.bloodtype_outlined,
                    size: 20 * scale,
                    color: Colors.teal.shade700,
                  ),
                  hintText: "Blood Type",
                  hintStyle: TextStyle(
                    fontSize: 14 * scale,
                    color: Colors.grey.shade500,
                  ),
                ),
                items: _bloodTypes
                    .map((bloodType) => DropdownMenuItem(
                  value: bloodType,
                  child: Text(
                    bloodType,
                    style: TextStyle(fontSize: 14 * scale),
                  ),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedBloodType = value;
                  });
                },
              ),
            ),
            SizedBox(height: 16 * scale),

            Container(
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.05),
                borderRadius: BorderRadius.circular(18 * scale),
                border: Border.all(
                  color: Colors.teal.withOpacity(0.3),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
              child: DropdownButtonFormField<String>(
                value: _selectedResidenceType,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.home_outlined,
                    size: 20 * scale,
                    color: Colors.teal.shade700,
                  ),
                  hintText: "Residence Type",
                  hintStyle: TextStyle(
                    fontSize: 14 * scale,
                    color: Colors.grey.shade500,
                  ),
                ),
                items: ['Urban', 'Rural']
                    .map((type) => DropdownMenuItem(
                  value: type,
                  child: Text(
                    type,
                    style: TextStyle(fontSize: 14 * scale),
                  ),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedResidenceType = value;
                  });
                },
              ),
            ),

            SizedBox(height: 25 * scale),

            // ✅ الحالة الاجتماعية
            Text(
              "Social Information (Optional)",
              style: TextStyle(
                fontSize: 16 * scale,
                fontWeight: FontWeight.w600,
                color: Colors.teal.shade800,
              ),
            ),
            SizedBox(height: 16 * scale),

            SwitchListTile(
              title: Text(
                "Married",
                style: TextStyle(fontSize: 14 * scale),
              ),
              value: _isMarried,
              onChanged: (value) {
                setState(() {
                  _isMarried = value;
                });
              },
              activeColor: Colors.teal.shade700,
              secondary: Icon(
                Icons.family_restroom_outlined,
                color: Colors.teal.shade700,
              ),
            ),

            SizedBox(height: 25 * scale),

            // ✅ القياسات الحيوية
            Text(
              "Body Measurements (Optional)",
              style: TextStyle(
                fontSize: 16 * scale,
                fontWeight: FontWeight.w600,
                color: Colors.teal.shade800,
              ),
            ),
            SizedBox(height: 16 * scale),

            Row(
              children: [
                Expanded(
                  child: CustomInputField(
                    controller: _heightController,
                    hint: "Height (cm)",
                    icon: Icons.height_outlined,
                    scale: scale,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 12 * scale),
                Expanded(
                  child: CustomInputField(
                    controller: _weightController,
                    hint: "Weight (kg)",
                    icon: Icons.monitor_weight_outlined,
                    scale: scale,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

            SizedBox(height: 25 * scale),

            // ✅ الأمراض المزمنة
            Text(
              "Chronic Conditions (Optional)",
              style: TextStyle(
                fontSize: 16 * scale,
                fontWeight: FontWeight.w600,
                color: Colors.teal.shade800,
              ),
            ),
            SizedBox(height: 12 * scale),

            _buildConditionSwitch(
              "Hypertension",
              _hasHypertension,
              Icons.monitor_heart_outlined,
                  (value) => setState(() => _hasHypertension = value),
              scale,
            ),
            _buildConditionSwitch(
              "Diabetes",
              _hasDiabetes,
              Icons.bloodtype_outlined,
                  (value) => setState(() => _hasDiabetes = value),
              scale,
            ),
            _buildConditionSwitch(
              "Anemia",
              _hasAnemia,
              Icons.air_outlined,
                  (value) => setState(() => _hasAnemia = value),
              scale,
            ),

            SizedBox(height: 40 * scale),

            // ✅ زر إنهاء التسجيل
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(const HomePage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14 * scale),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16 * scale),
                  elevation: 4,
                ),
                child: Text(
                  "Complete Registration",
                  style: TextStyle(
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20 * scale),
          ],
        ),
      ),
    );
  }

  Widget _buildConditionSwitch(
      String title,
      bool value,
      IconData icon,
      Function(bool) onChanged,
      double scale,
      ) {
    return Card(
      margin: EdgeInsets.only(bottom: 8 * scale),
      elevation: 2,
      child: SwitchListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 14 * scale),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: Colors.teal.shade700,
        activeTrackColor: Colors.teal.shade300,
        inactiveThumbColor: Colors.grey.shade400,
        inactiveTrackColor: Colors.grey.shade300,
        secondary: Icon(
          icon,
          color: Colors.teal.shade700,
          size: 20 * scale,
        ),
      ),
    );
  }

  void _completeRegistration() {
    // هنا هتجميع كل البيانات وترسلها للـ backend
    final patientFullData = {
      'basic_info': widget.patientData,
      'medical_info': {
        'city': _cityController.text,
        'blood_type': _selectedBloodType,
        'residence_type': _selectedResidenceType,
        'height': _heightController.text,
        'weight': _weightController.text,
        'is_married': _isMarried,
        'conditions': {
          'hypertension': _hasHypertension,
          'diabetes': _hasDiabetes,
          'anemia': _hasAnemia,
        },
      },
    };

    // عرض بيانات المريض (للتأكد)
    print('Patient Data: $patientFullData');

    Get.snackbar(
      'Registration Complete!',
      'Welcome ${widget.patientData.name}',
      backgroundColor: Colors.green.shade100,
      colorText: Colors.green.shade900,
    );

    // التوجيه للصفحة الرئيسية بعد ثانيتين
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(const HomePage());
    });
  }
}