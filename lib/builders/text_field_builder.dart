import 'package:flutter/material.dart';
import 'package:journijots/core/utils/constants.dart';

Widget buildTextField(String label, IconData icon, bool obscureText) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: kprimarycolor,
        ),
      ),
      const SizedBox(height: 5),
      TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: kscaffoldcolor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          hintText: 'Enter your $label',
          prefixIcon: Icon(icon, color: kprimarycolor),
        ),
      ),
    ],
  );
}
