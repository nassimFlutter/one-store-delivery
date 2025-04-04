import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الملف الشخصي"),
        automaticallyImplyLeading:
            false, // Prevent back button on the profile page
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding for better UI
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile picture
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                  'assets/images/profile_image.png'), // Replace with actual image
            ),
            const SizedBox(height: 20),
            // User name
            const Text(
              "اسم المستخدم", // Replace with dynamic user name
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // User email
            const Text(
              "البريد الإلكتروني: example@domain.com", // Replace with dynamic user email
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),

            // Buttons for options: Edit Account, Privacy Settings, Logout
            ElevatedButton(
              onPressed: () {
                // Navigate to Edit Account page
                // Navigator.push(context, MaterialPageRoute(builder: (context) => EditAccountPage()));
              },
              child: const Text("تعديل الحساب"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // Full-width button
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // Navigate to Privacy Settings page
                // Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacySettingsPage()));
              },
              child: const Text("إعدادات الخصوصية"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // Full-width button
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // Handle logout functionality here
                // For example, log the user out and navigate to the login page:
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: const Text("تسجيل الخروج"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Red color for logout button
                minimumSize: Size(double.infinity, 50), // Full-width button
              ),
            ),
          ],
        ),
      ),
    );
  }
}
