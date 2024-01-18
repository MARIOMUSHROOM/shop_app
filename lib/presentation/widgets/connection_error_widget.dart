import 'package:flutter/material.dart';
import 'package:shop_app/core/constants/theme.dart';
import 'package:shop_app/presentation/widgets/sizer.dart';

class ConnectionErrorWidget extends StatelessWidget {
  const ConnectionErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizer(context).w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: Sizer(context).h * 0.3),
          Icon(
            Icons.error_outline_outlined,
            size: 50,
            color: primaryColor,
          ),
          SizedBox(height: 10),
          Text("Lost Connection"),
        ],
      ),
    );
  }
}
