import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/home.dart';
import '../widgets/app_logo.dart';
import '../widgets/custom_input_field.dart';
import 'medical_info_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _selectedGender;
  DateTime? _selectedDate;

  // متغيرات لتتبع الأخطاء
  bool _nameError = false;
  bool _emailError = false;
  bool _phoneError = false;
  bool _passwordError = false;
  bool _confirmPasswordError = false;
  bool _genderError = false;
  bool _birthDateError = false;

  // دالة التحقق من الأرقام
  bool _isNumeric(String value) {
    if (value.isEmpty) return false;
    return double.tryParse(value) != null;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final baseSize = min(screenWidth, screenHeight);
    final scale = baseSize / 400;

    Future<void> _selectDate() async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
      if (picked != null && picked != _selectedDate) {
        setState(() {
          _selectedDate = picked;
          _birthDateError = false;
        });
      }
    }

    void _validateAllFields() {
      setState(() {
        // تحقق من كل الحقول
        _nameError = _nameController.text.isEmpty;
        _emailError = _emailController.text.isEmpty || !_emailController.text.contains('@');
        _phoneError = _phoneController.text.isEmpty || !_isNumeric(_phoneController.text);
        _passwordError = _passwordController.text.isEmpty || _passwordController.text.length < 6;
        _confirmPasswordError = _confirmPasswordController.text != _passwordController.text;
        _genderError = _selectedGender == null;
        _birthDateError = _selectedDate == null;
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 28 * scale,
          vertical: 40 * scale,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const Center(child: AppLogo()),

            SizedBox(height: 20 * scale),

            Container(
              height: 120 * scale,
              width: 120 * scale,
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person_add_alt_1,
                size: 40 * scale,
                color: Colors.teal.shade700,
              ),
            ),

            SizedBox(height: 20 * scale),

            Text(
              "Create Your Account",
              style: TextStyle(
                fontSize: 22 * scale,
                fontWeight: FontWeight.w600,
                color: Colors.teal.shade900,
              ),
            ),
            SizedBox(height: 8 * scale),
            Text(
              "Step 1: Basic Information",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14 * scale,
                color: Colors.teal.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: 30 * scale),

            // ✅ الاسم
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomInputField(
                  controller: _nameController,
                  hint: "Full Name *",
                  icon: Icons.person_outline,
                  scale: scale,
                  hasError: _nameError,
                ),
                if (_nameError)
                  Padding(
                    padding: EdgeInsets.only(left: 16 * scale, top: 4 * scale),
                    child: Text(
                      "Please enter your name",
                      style: TextStyle(
                        fontSize: 12 * scale,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16 * scale),

            // ✅ الإيميل
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomInputField(
                  controller: _emailController,
                  hint: "Email Address *",
                  icon: Icons.email_outlined,
                  scale: scale,
                  hasError: _emailError,
                ),
                if (_emailError)
                  Padding(
                    padding: EdgeInsets.only(left: 16 * scale, top: 4 * scale),
                    child: Text(
                      _emailController.text.isEmpty
                          ? "Please enter your email"
                          : "Please enter a valid email",
                      style: TextStyle(
                        fontSize: 12 * scale,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16 * scale),

            // ✅ رقم التليفون
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomInputField(
                  controller: _phoneController,
                  hint: "Phone Number *",
                  icon: Icons.phone_outlined,
                  scale: scale,
                  hasError: _phoneError,
                  keyboardType: TextInputType.phone,
                ),
                if (_phoneError)
                  Padding(
                    padding: EdgeInsets.only(left: 16 * scale, top: 4 * scale),
                    child: Text(
                      _phoneController.text.isEmpty
                          ? "Please enter your phone number"
                          : "Phone number must contain only numbers",
                      style: TextStyle(
                        fontSize: 12 * scale,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16 * scale),

            // ✅ تاريخ الميلاد
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: _birthDateError ? Colors.red.shade50 : Colors.teal.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(18 * scale),
                    border: Border.all(
                      color: _birthDateError ? Colors.red.shade300 : Colors.teal.withOpacity(0.3),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.cake_outlined,
                      size: 20 * scale,
                      color: _birthDateError ? Colors.red.shade700 : Colors.teal.shade700,
                    ),
                    title: Text(
                      _selectedDate == null
                          ? "Birth Date *"
                          : "Age: ${_calculateAge(_selectedDate!)} years",
                      style: TextStyle(
                        fontSize: 14 * scale,
                        color: _birthDateError
                            ? Colors.red.shade700
                            : _selectedDate == null
                            ? Colors.grey.shade500
                            : Colors.teal.shade800,
                      ),
                    ),
                    subtitle: _selectedDate != null
                        ? Text(
                      "Born: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                      style: TextStyle(
                        fontSize: 12 * scale,
                        color: Colors.grey.shade600,
                      ),
                    )
                        : null,
                    trailing: Icon(
                      Icons.calendar_today,
                      size: 18 * scale,
                      color: _birthDateError ? Colors.red.shade700 : Colors.teal.shade600,
                    ),
                    onTap: _selectDate,
                  ),
                ),
                if (_birthDateError)
                  Padding(
                    padding: EdgeInsets.only(left: 16 * scale, top: 4 * scale),
                    child: Text(
                      "Please select your birth date",
                      style: TextStyle(
                        fontSize: 12 * scale,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(height: 16 * scale),

            // ✅ النوع
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: _genderError ? Colors.red.shade50 : Colors.teal.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(18 * scale),
                    border: Border.all(
                      color: _genderError ? Colors.red.shade300 : Colors.teal.withOpacity(0.3),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                  child: DropdownButtonFormField<String>(
                    value: _selectedGender,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.people_outline,
                        size: 20 * scale,
                        color: _genderError ? Colors.red.shade700 : Colors.teal.shade700,
                      ),
                      hintText: "Gender *",
                      hintStyle: TextStyle(
                        fontSize: 14 * scale,
                        color: _genderError ? Colors.red.shade700 : Colors.grey.shade500,
                      ),
                    ),
                    items: ['Male', 'Female']
                        .map((gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(
                        gender,
                        style: TextStyle(fontSize: 14 * scale),
                      ),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                        _genderError = false;
                      });
                    },
                  ),
                ),
                if (_genderError)
                  Padding(
                    padding: EdgeInsets.only(left: 16 * scale, top: 4 * scale),
                    child: Text(
                      "Please select your gender",
                      style: TextStyle(
                        fontSize: 12 * scale,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(height: 16 * scale),

            // ✅ الباسوورد
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomInputField(
                  controller: _passwordController,
                  hint: "Password *",
                  icon: Icons.lock_outline,
                  isPassword: true,
                  scale: scale,
                  hasError: _passwordError,
                ),
                if (_passwordError)
                  Padding(
                    padding: EdgeInsets.only(left: 16 * scale, top: 4 * scale),
                    child: Text(
                      _passwordController.text.isEmpty
                          ? "Please enter your password"
                          : "Password must be at least 6 characters",
                      style: TextStyle(
                        fontSize: 12 * scale,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16 * scale),

            // ✅ تأكيد الباسوورد
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomInputField(
                  controller: _confirmPasswordController,
                  hint: "Confirm Password *",
                  icon: Icons.lock_outline,
                  isPassword: true,
                  scale: scale,
                  hasError: _confirmPasswordError,
                ),
                if (_confirmPasswordError)
                  Padding(
                    padding: EdgeInsets.only(left: 16 * scale, top: 4 * scale),
                    child: Text(
                      "Passwords do not match",
                      style: TextStyle(
                        fontSize: 12 * scale,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(height: 30 * scale),

            // ✅ زر Continue
            // في الجزء بتاع الأزرار - بعد زر Continue to Medical Info
            SizedBox(height: 30 * scale),

// ✅ زر Continue
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _validateAllFields();

                  // لو مفيش أخطاء، اروح للصفحة التانية
                  if (!_nameError && !_emailError && !_phoneError &&
                      !_passwordError && !_confirmPasswordError &&
                      !_genderError && !_birthDateError) {
                    Get.to(() => MedicalInfoPage(
                      patientData: PatientBasicInfo(
                        name: _nameController.text,
                        email: _emailController.text,
                        phone: _phoneController.text,
                        birthDate: _selectedDate!,
                        gender: _selectedGender!,
                        password: _passwordController.text,
                      ),
                    ));
                  } else {
                    // لو في أخطاء، اعمل vibrate للزر
                    Get.snackbar(
                      'Missing Information',
                      'Please fill all required fields correctly',
                      backgroundColor: Colors.red.shade100,
                      colorText: Colors.red.shade900,
                    );
                  }
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
                  "Continue to Medical Info",
                  style: TextStyle(
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(height: 12 * scale),

// ✅ زر Skip for Testing
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // بيانات تجريبية علشان التست
                  Get.to(() => MedicalInfoPage(
                    patientData: PatientBasicInfo(
                      name: _nameController.text.isNotEmpty ? _nameController.text : "Test User",
                      email: _emailController.text.isNotEmpty ? _emailController.text : "test@example.com",
                      phone: _phoneController.text.isNotEmpty ? _phoneController.text : "0123456789",
                      birthDate: _selectedDate ?? DateTime(1990, 1, 1),
                      gender: _selectedGender ?? "Male",
                      password: _passwordController.text.isNotEmpty ? _passwordController.text : "123456",
                    ),
                  ));
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.orange.shade700,
                  side: BorderSide(color: Colors.orange.shade700),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14 * scale),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14 * scale),
                ),
                child: Text(
                  "Skip for Testing →",
                  style: TextStyle(
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20 * scale),


            SizedBox(height: 20 * scale),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(
                    fontSize: 14 * scale,
                    color: Colors.grey.shade600,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 14 * scale,
                      color: Colors.teal.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age.toString();
  }
}

class PatientBasicInfo {
  final String name;
  final String email;
  final String phone;
  final DateTime birthDate;
  final String gender;
  final String password;

  PatientBasicInfo({
    required this.name,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.gender,
    required this.password,
  });
}