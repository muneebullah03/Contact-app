import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RoundedButton extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  bool loading;
  RoundedButton(
      {super.key,
      required this.title,
      required this.ontap,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ontap,
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: loading
          ? const Center(child: CircularProgressIndicator())
          : Center(child: Text(title)),
    );
  }
}
