import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/slider_moder.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
class Slideshow extends StatelessWidget {
  final List<Widget> children;
  const Slideshow({
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SliderModel(),
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: _Slides(children),
            ),
            _Dots(children.length),
          ],
        ),
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> widgets;
  const _Slides(this.widgets);

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  late PageController controller;
  double page = 0.0;

  @override
  void initState() {
    controller = PageController();
    controller.addListener(() {

      Provider.of<SliderModel>(context, listen: false).currentPage =
          controller.page!;
          setState(() {
      page = controller.page ?? 0;
    });
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
    return PageView.builder(
      controller: controller,
      itemCount: widget.widgets.length,
      itemBuilder: (BuildContext context, int index) {
        double porcentaje = (page - index).abs();
          final double cub = (index < page) ? 1 : -1;
        return Transform(
            alignment:
                (cub == -1) ? Alignment.centerLeft : Alignment.centerRight,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(
                vector.radians(90 * cub) * porcentaje,
              ),
            child: _Slide(widget.widgets[index]),
          );
      },
    );
  }
}
//_Slide(widget.widgets[index])

class _Slide extends StatelessWidget {
  final Widget svg;
  const _Slide(this.svg);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.all(30),
      child: svg,
    );
  }
}

class _Dots extends StatelessWidget {
  final int quantity;
  const _Dots(this.quantity);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      //color: Colors.pink,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          quantity,
          (index) => _Dot(index),
        ),
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
