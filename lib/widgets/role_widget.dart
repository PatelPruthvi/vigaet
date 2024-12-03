// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class RoleWidget extends StatelessWidget {
  final String imageAsset;
  final String label;
  final void Function() onTap;
  const RoleWidget(
      {super.key,
      required this.imageAsset,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(30)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(imageAsset,
                height: MediaQuery.of(context).size.height * 0.2),
            Text(label)
          ],
        ),
      ),
    );
  }
}
