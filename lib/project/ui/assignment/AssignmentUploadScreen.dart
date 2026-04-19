import 'package:flutter/material.dart';
import '../common/components/icon_button.dart';

class AssignmentUploadScreen extends StatelessWidget {
  final String title;
  const AssignmentUploadScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomIconButton(
            iconData: Icons.arrow_back_ios_new,
            onBackPress: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          "Submit Assignment",
          style: TextStyle(color: Color(0xFF1A1A2E), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF8A2373))),
            const SizedBox(height: 10),
            Text("Assignment #08 - Computer Networks", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),

            // Upload Area
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Color(0xFFF9F5FA),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFF8A2373).withOpacity(0.2), style: BorderStyle.solid),
              ),
              child: Column(
                children: [
                  Icon(Icons.cloud_upload_outlined, size: 50, color: Color(0xFF8A2373)),
                  const SizedBox(height: 10),
                  Text("Tap to upload your file", style: TextStyle(fontWeight: FontWeight.w600)),
                  Text("(PDF, DOCX up to 10MB)", style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),

            const Spacer(),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Upload Logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF8A2373),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: Text("Submit Now", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }
}