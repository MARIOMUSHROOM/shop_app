import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/auth.dart';
import 'package:shop_app/constants/theme.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      checkSignedIn();
    });
  }

  void checkSignedIn() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Authenticate()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const FlutterLogo(size: 100),
            const SizedBox(height: 20),
            Container(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(color: primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
