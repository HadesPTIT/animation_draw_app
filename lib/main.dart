import 'package:animation_draw_app/app_animation.dart';
import 'package:animation_draw_app/app_draw.dart';
import 'package:animation_draw_app/components/app_button.dart';
import 'package:animation_draw_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Image image;

  @override
  void initState() {
    super.initState();
    image = Image.asset(Assets.images.imIntro.path);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(image.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Builder(
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppButton(
                  title: 'Draw',
                  onTap: () {
                    navigateToDraw(context);
                  },
                ),
                const SizedBox(height: 10),
                AppButton(
                  title: 'Animation',
                  onTap: () {
                    navigateToAnimation(context);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void navigateToDraw(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const AppDraw();
        },
      ),
    );
  }

  void navigateToAnimation(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const AppAnimation();
        },
      ),
    );
  }
}
