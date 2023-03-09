import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final Function()? ontap;

  const CustomTextButton({super.key, required this.label, this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.pink,
        ),
        padding: const EdgeInsets.all(10),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
