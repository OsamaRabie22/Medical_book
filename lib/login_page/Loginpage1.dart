import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/home/home.dart';
import 'package:project/login_page/sign_up.dart';
import 'package:project/widgets/custom_input_field.dart';

class LoginPage1 extends StatefulWidget {
  const LoginPage1({super.key});

  @override
  State<LoginPage1> createState() => _LoginPage1State();
}

class _LoginPage1State extends State<LoginPage1> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    Get.to(const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // مقاسات التصميم الأصلية (iPhone 14 Pro Max)
    const baseWidth = 430.0;
    const baseHeight = 932.0;

    // نسب التناسب
    final w = screenWidth / baseWidth;
    final h = screenHeight / baseHeight;
    final scale = min(w, h);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 28 * w,
          vertical: 40 * h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ✅ اللوجو
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 32 * scale,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  const TextSpan(
                    text: "Medical ",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: "Book",
                    style: TextStyle(color: Colors.teal.shade700),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20 * h),

            // ✅ الصورة
            Container(
              height: 200 * h,
              width: 200 * w,
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(25 * scale),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withOpacity(0.1),
                    blurRadius: 10 * scale,
                    offset: Offset(0, 4 * scale),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25 * scale),
                child: Image.asset(
                  'assets/ChatGPT Image 3 نوفمبر 2025، 05_11_39 ص.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 30 * h),

            // ✅ الترحيب
            Text(
              "Welcome Back 👋",
              style: TextStyle(
                fontSize: 26 * scale,
                fontWeight: FontWeight.w600,
                color: Colors.teal.shade900,
              ),
            ),
            SizedBox(height: 8 * h),
            Text(
              "Stay connected to your health records\nlogin to continue",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16 * scale,
                color: Colors.grey.shade600,
                height: 1.4,
              ),
            ),

            SizedBox(height: 40 * h),

            // ✅ حقول الإدخال
            CustomInputField(
              controller: _usernameController,
              hint: "Username",
              icon: Icons.person_outline,
              scale: scale, // ✅ نمرر الـ scale للـ custom widget
            ),
            SizedBox(height: 16 * h),
            CustomInputField(
              controller: _passwordController,
              hint: "Password",
              icon: Icons.lock_outline,
              isPassword: true,
              scale: scale,
            ),

            SizedBox(height: 10 * h),

            // ✅ نسيت كلمة المرور
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot password?",
                  style: TextStyle(
                    fontSize: 14 * scale,
                    color: Colors.teal.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            SizedBox(height: 30 * h),

            // ✅ زر تسجيل الدخول
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14 * scale),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16 * h),
                  elevation: 4 * scale,
                  shadowColor: Colors.teal.withOpacity(0.3),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 18 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(height: 60 * h),

            // ✅ إنشاء حساب جديد
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyle(
                    fontSize: 14 * scale,
                    color: Colors.grey.shade600,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(const SignupPage());
                  },
                  child: Text(
                    "Sign Up",
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
}