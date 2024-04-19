import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:slideshow/models/slider_moder.dart';

class SlideShowPage extends StatelessWidget {
  const SlideShowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SliderModel(),
      child: const Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: _Slides(),
              ),
              _Dots(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: 100,
      //color: Colors.pink,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Dot(0),
          _Dot(1),
          _Dot(2),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  const _Dot(this.index);

  @override
  Widget build(BuildContext context) {
    final int provider = Provider.of<SliderModel>(context).currentPage.round();
    final double size = (provider != index) ? 10 : 14;
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 200,
      ),
      height: size,
      width: size,
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        color: (provider != index) ? Colors.grey : Colors.pink,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  const _Slides();

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  late PageController controller;

  @override
  void initState() {
    controller = PageController();
    controller.addListener(() {
      Provider.of<SliderModel>(context, listen: false).currentPage =
          controller.page!;
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      children: const <_Slide>[
        _Slide('assets/svgs/slide-1.svg'),
        _Slide('assets/svgs/slide-2.svg'),
        _Slide('assets/svgs/slide-3.svg'),
      ],
    );
  }
}

class _Slide extends StatelessWidget {
  final String svg;
  const _Slide(this.svg);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.all(30),
      child: SvgPicture.asset(svg),
    );
  }
}
