import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class SliderContainer extends StatelessWidget {
  final List<Widget> elements;
  final double height;

  SliderContainer({required this.elements, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Swiper(
        itemCount: elements.length,
        itemBuilder: (
          BuildContext context,
          int index,
        ) {
          return elements[index];
        },
        control: SwiperControl(),
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            activeSize: 9,
            size: 6,
            space: 3,
            color: Colors.white,
            activeColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
