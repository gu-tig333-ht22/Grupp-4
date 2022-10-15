import 'package:flutter/material.dart';

class ShimmerLoader extends StatefulWidget {
  const ShimmerLoader({Key? key}) : super(key: key);

  @override
  State<ShimmerLoader> createState() => _ShimmerLoaderState();
}

class _ShimmerLoaderState extends State<ShimmerLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController shimmerController;
  late LinearGradient shimmerGradient;

  @override
  void initState() {
    super.initState();

    shimmerController = AnimationController(vsync: this)
      ..repeat(min: 0, max: 1, period: const Duration(milliseconds: 2000))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    shimmerGradient = LinearGradient(
        colors: const [
          Color.fromARGB(255, 76, 76, 82),
          Color.fromARGB(255, 194, 187, 187),
          Color.fromARGB(255, 76, 76, 82)
        ],
        stops: [
          shimmerController.value - 0.2,
          shimmerController.value,
          shimmerController.value + 0.2
        ],
        begin: const Alignment(-1.5, -1),
        end: const Alignment(1.5, 1),
        tileMode: TileMode.clamp);

    return ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (bounds) {
          return shimmerGradient.createShader(bounds);
        },
        child: Container(height: 200, width: 200, color: Colors.white));
  }

  @override
  void dispose() {
    shimmerController.dispose();
    super.dispose();
  }
}
