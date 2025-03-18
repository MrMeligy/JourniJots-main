import 'package:flutter/material.dart';

class TripsViewBody extends StatelessWidget {
  final ScrollController scrollController;

  const TripsViewBody({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No Trips Added'),
    );
  }
}
