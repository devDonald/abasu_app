import 'package:abasu_app/features/authentication/pages/register_as.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../core/widgets/intro_button.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'Buy Building and Construction Material',
              body:
                  'You can purchase every kind of Building and Construction materials at affordable prices',
              image: buildImage('images/construction.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Construction Material Delivery',
              body:
                  'Get your purchased building and construction materials delivered to your preferred location at an affordable rate',
              image: buildImage('images/delivery.jpeg'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Hire Skilled Artisan',
              body:
                  'You can hire a skilled Artisans from our list of verified professional artisans',
              image: buildImage('images/artisan.jpeg'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Give us your Projects to Handle',
              body:
                  'You can contract us to handle your building and construction project from start to finish',
              image: buildImage('images/contract.jpeg'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Get Started',
              body: 'Start shopping and hiring verified professionals',
              footer: ButtonWidget(
                text: 'Get Started',
                onClicked: () => goToHome(context),
              ),
              image: buildImage('images/logo2.png'),
              decoration: getPageDecoration(),
            ),
          ],
          done: const Text('Start Now',
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.green)),
          onDone: () => goToHome(context),
          showSkipButton: true,
          skip: const Text('Skip'),
          onSkip: () => goToHome(context),
          next: const Icon(Icons.arrow_forward),
          dotsDecorator: getDotDecoration(),
          onChange: (index) => print('Page $index selected'),
          globalBackgroundColor: Theme.of(context).primaryColor,
          nextFlex: 0,
        ),
      );

  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LogInAs()),
      );

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: const Color(0xFFBDBDBD),
        //activeColor: Colors.orange,
        size: const Size(10, 10),
        activeSize: const Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle:
            const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: const TextStyle(fontSize: 20),
        bodyPadding: const EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: const EdgeInsets.all(24),
        pageColor: Colors.white,
      );
}
