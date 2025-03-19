import 'package:flutter/material.dart';
import 'package:shopx/core/size_config.dart';
import 'package:shopx/presentation/widgets/custom_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Sizecf().init(context);
    return Scaffold(
      body: Center(
        child: Customtext(
          text: 'Home Screen',
          size: Sizecf.blockSizeVertical! * 4,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
