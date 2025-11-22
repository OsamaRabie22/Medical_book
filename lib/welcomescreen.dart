import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/intro_pages/intro_page1.dart';
import 'package:project/intro_pages/intro_page2.dart';
import 'package:project/intro_pages/intro_page3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'login_page/Loginpage1.dart';
import 'package:get/get.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get _accentColor => Colors.teal.shade800;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // صفحات الـ onboarding
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children:  [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),

          // شريط التنقّل السفلي
          Positioned(
            left: 0,
            right: 0,
            bottom: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // زر Skip
                  TextButton(
                    onPressed: () {Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const LoginPage1(),
                      ),
                    );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: _accentColor,
                      textStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    child: const Text("Skip"),
                  ),

                  // مؤشر الصفحات
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: WormEffect(
                      dotHeight: 12,
                      dotWidth: 12,
                      spacing: 10,
                      activeDotColor: _accentColor,
                      dotColor: _accentColor.withOpacity(0.25),
                    ),
                  ),

                  // زر Next / Done
                  TextButton(
                    onPressed: () {
                      if (onLastPage) {
                        Get.off(LoginPage1());
                      } else {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: _accentColor,
                      textStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    child: Text(onLastPage ? "Done!" : "Next"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
