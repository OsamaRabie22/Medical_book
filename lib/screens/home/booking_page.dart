import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/responsive_utils.dart';

class BookingPage extends StatefulWidget {
  final String doctorName;
  final String specialty;
  final String doctorImage;

  const BookingPage({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.doctorImage,
  });

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text(
          "Book Appointment",
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 24 * scale,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.primaryDark,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // معلومات الدكتور
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16 * scale),
              ),
              child: Padding(
                padding: EdgeInsets.all(16 * scale),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12 * scale),
                      child: Image.asset(
                        widget.doctorImage,
                        width: 60 * scale,
                        height: 60 * scale,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 16 * scale),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.doctorName,
                            style: AppTextStyles.headlineSmall.copyWith(
                              fontSize: isTablet ? 19 * scale : 17 * scale,
                            ),
                          ),
                          SizedBox(height: 4 * scale),
                          Text(
                            widget.specialty,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.grey,
                              fontSize: isTablet ? 16 * scale : 14 * scale,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24 * scale),

            // اختيار التاريخ
            Text(
              "Select Date",
              style: AppTextStyles.headlineSmall.copyWith(
                fontSize: isTablet ? 19 * scale : 17 * scale,
              ),
            ),
            SizedBox(height: 8 * scale),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _selectDate(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  foregroundColor: AppColors.primaryDark,
                  padding: EdgeInsets.symmetric(vertical: 16 * scale),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12 * scale),
                    side: BorderSide(color: AppColors.primary),
                  ),
                ),
                child: Text(
                  selectedDate != null
                      ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                      : "Choose Date",
                  style: AppTextStyles.bodyMedium,
                ),
              ),
            ),

            SizedBox(height: 16 * scale),

            // اختيار الوقت
            Text(
              "Select Time",
              style: AppTextStyles.headlineSmall.copyWith(
                fontSize: isTablet ? 19 * scale : 17 * scale,
              ),
            ),
            SizedBox(height: 8 * scale),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _selectTime(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  foregroundColor: AppColors.primaryDark,
                  padding: EdgeInsets.symmetric(vertical: 16 * scale),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12 * scale),
                    side: BorderSide(color: AppColors.primary),
                  ),
                ),
                child: Text(
                  selectedTime != null
                      ? "${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}"
                      : "Choose Time",
                  style: AppTextStyles.bodyMedium,
                ),
              ),
            ),

            SizedBox(height: 16 * scale),

            // طريقة الدفع
            Text(
              "Payment Method",
              style: AppTextStyles.headlineSmall.copyWith(
                fontSize: isTablet ? 19 * scale : 17 * scale,
              ),
            ),
            SizedBox(height: 8 * scale),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12 * scale),
                border: Border.all(color: AppColors.primary),
              ),
              child: DropdownButtonFormField<String>(
                value: selectedPaymentMethod,
                items: ['Cash', 'Credit Card', 'Insurance']
                    .map((method) => DropdownMenuItem(
                          value: method,
                          child: Text(
                            method,
                            style: AppTextStyles.bodyMedium,
                          ),
                        ))
                    .toList(),
                onChanged: (value) =>
                    setState(() => selectedPaymentMethod = value),
                decoration: InputDecoration(
                  hintText: "Select Payment Method",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16 * scale),
                ),
                dropdownColor: AppColors.white,
              ),
            ),

            SizedBox(height: 40 * scale),

            // زر تأكيد الحجز
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _confirmBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16 * scale),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12 * scale),
                  ),
                  elevation: 4,
                ),
                child: Text(
                  "Confirm Booking",
                  style: AppTextStyles.buttonMedium.copyWith(
                    fontSize: isTablet ? 18 * scale : 16 * scale,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() => selectedTime = picked);
    }
  }

  void _confirmBooking() {
    if (selectedDate == null ||
        selectedTime == null ||
        selectedPaymentMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill all fields"),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // تأكيد الحجز
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Booking Confirmed!",
          style: AppTextStyles.headlineSmall,
        ),
        content: Text(
          "Your appointment with ${widget.doctorName} is confirmed for ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year} at ${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}",
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to doctors page
            },
            child: Text(
              "OK",
              style:
                  AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
