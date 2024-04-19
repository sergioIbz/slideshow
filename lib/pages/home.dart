import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slideshow/widgets/slideshow.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      body: Slideshow(
        children: [
          SvgPicture.asset('assets/svgs/slide-1.svg'),
          SvgPicture.asset('assets/svgs/slide-2.svg'),
          SvgPicture.asset('assets/svgs/slide-3.svg'),
          SvgPicture.asset('assets/svgs/slide-4.svg'),
          SvgPicture.asset('assets/svgs/slide-5.svg'),
        ],
      ),
    );
  }
}
