import 'package:flutter/material.dart';
import 'package:pediapp/Classes/color.dart';

InputDecoration buildInputDecoration(IconData icon, String str) {
  return InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: MyColors.primary, width: 1)),
      hintText: str,
      prefixIcon: Icon(icon, color: MyColors.primary),
      hintStyle: const TextStyle(color: MyColors.primary, fontSize: 20),
      fillColor: Colors.white,
      filled: true,
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: MyColors.primary, width: 3)),
      contentPadding: const EdgeInsets.only(top: 5, bottom: 5, right: 40));
}
