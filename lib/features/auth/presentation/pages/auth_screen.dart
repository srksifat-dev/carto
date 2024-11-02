import 'package:carto/core/utils/extensions/screen_size_extension.dart';
import 'package:carto/core/utils/extensions/widget_extensions.dart';
import 'package:carto/features/auth/presentation/widgets/login_content.dart';
import 'package:carto/features/auth/presentation/widgets/register_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late PageController pageController;
  double progress = 0;

  @override
  void initState() {
    pageController = PageController()
      ..addListener(() {
        setState(() {
          progress = pageController.page ?? 0;
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            SvgPicture.asset(
              "assets/svgs/auth_bg.svg",
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 40,
              child: Text(
                "CARTO",
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      letterSpacing: 8,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(32),
                      topLeft: Radius.circular(32),
                    ),
                  ),
                  height: context.screenHeight * 50 + progress * 100,
                  child: PageView(
                    controller: pageController,
                    children: [
                      LoginContent(
                        goRegisterScreen: () {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear,
                          );
                        },
                      ),
                      RegisterContent(
                        goLoginScreen: () {
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear,
                          );
                        },
                      ),
                    ],
                  ).paddingOnly(top: 16)),
            ),
          ],
        ),
    );
  }
}
