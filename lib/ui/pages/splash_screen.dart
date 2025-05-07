import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:test_android_flutter/core/provider/splash_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final splashProvider = context.read<SplashProvider>();
    splashProvider.startAnimationSequence();
    Future.delayed(const Duration(seconds: 5), () => context.goNamed('login'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff1864D3), Color(0xff0C4AA6)],
          ),
        ),
        child: Selector<SplashProvider, bool>(
          selector: (_, provider) => provider.showSecond,
          builder: (_, showSecond, __) {
            return AnimatedCrossFade(
              firstCurve: Curves.bounceIn,
              secondCurve: Curves.easeOut,
              duration: const Duration(milliseconds: 250),
              crossFadeState: showSecond ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              alignment: Alignment.center,
              firstChild: const _LogoImage(size: 180),
              secondChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  _AnimatedLogo(),
                  SizedBox(height: 20),
                  _AnimatedLoader(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LogoImage extends StatelessWidget {
  final double size;
  const _LogoImage({required this.size});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/nextdata-logo-blanc.png',
      width: size,
    );
  }
}

class _AnimatedLogo extends StatelessWidget {
  const _AnimatedLogo();

  @override
  Widget build(BuildContext context) {
    return Selector<SplashProvider, bool>(
      selector: (_, provider) => provider.scale,
      builder: (_, scale, __) {
        return AnimatedScale(
          duration: const Duration(seconds: 1),
          curve: Curves.easeOutBack,
          scale: scale ? 0.8 : 1.0,
          child: const _LogoImage(size: 170),
        );
      },
    );
  }
}

class _AnimatedLoader extends StatelessWidget {
  const _AnimatedLoader();

  @override
  Widget build(BuildContext context) {
    return Selector<SplashProvider, bool>(
      selector: (_, provider) => provider.opacity,
      builder: (_, opacity, __) {
        return AnimatedOpacity(
          duration: const Duration(seconds: 1),
          opacity: opacity ? 1.0 : 0.0,
          child: const CircularProgressIndicator(color: Colors.white),
        );
      },
    );
  }
}
