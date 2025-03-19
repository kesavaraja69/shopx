import 'package:flutter/material.dart';
import 'package:shopx/core/theme/app_colors.dart';

import '../../core/size_config.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Sizecf().init(context);
    return Scaffold(
      body: Center(
        child: Text(
          "SHOPX",
          style: TextStyle(
            fontSize: Sizecf.blockSizeHorizontal! * 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primarycolor,
          ),
        ),
      ),
    );
  }
}
