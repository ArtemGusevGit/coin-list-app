import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CryptoCoinSkeleton extends StatelessWidget {
  const CryptoCoinSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        title: Container(
          height: 16,
          width: double.infinity,
          color: Colors.grey,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            height: 14,
            width: 80,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
