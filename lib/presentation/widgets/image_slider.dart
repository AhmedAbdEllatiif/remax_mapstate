import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/screen_utils/screen_util.dart';
import '../../di/git_it.dart';
import '../logic/cubit/project_scrollable_indicator/indicator_position_cubit.dart';
import '../themes/theme_color.dart';

class ImageSliderWidget extends StatefulWidget {
  final List<String> images;

  const ImageSliderWidget({Key? key, required this.images}) : super(key: key);

  @override
  State<ImageSliderWidget> createState() => _ImageSliderWidgetState();
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> {

  late final PageController _pageController;

  late final IndicatorPositionCubit indicatorPositionCubit;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      keepPage: false,
      //viewportFraction: 0.7,
    );

    /// init indicatorPositionCubit
    indicatorPositionCubit = getItInstance<IndicatorPositionCubit>();
  }

  @override
  void dispose() {
    indicatorPositionCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Images >> ${widget.images}");
    return BlocProvider(
      create: (context) => indicatorPositionCubit,
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              onPageChanged: (index,_){
                indicatorPositionCubit.updatePosition(index.toDouble());
              },
              disableCenter: true,
              height: ScreenUtil.screenHeight * 0.25,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              scrollPhysics: const BouncingScrollPhysics(),
              enlargeFactor: 0.35,
              enableInfiniteScroll: true,
              reverse: false,
             autoPlay: true,
              // autoPlayInterval: Duration(seconds: 5),
              // autoPlayAnimationDuration: Duration(milliseconds: 2000),
              // autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              //onPageChanged: callbackFunction,
              scrollDirection: Axis.horizontal,
            ),
            items: widget.images.map((singleImg) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: double.infinity,
                      //margin: const EdgeInsets.symmetric(horizontal: 3.0),
                      color: AppColor.white,
                      child: CachedNetworkImage(
                        imageUrl: singleImg,
                        fit: BoxFit.cover,
                      )
                  );
                },
              );
            }).toList(),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 2,
            child:
            BlocBuilder<IndicatorPositionCubit, IndicatorPositionState>(
              builder: (context, state) {
                return DotsIndicator(
                  dotsCount: 5,
                  position: state.currentPosition,
                  decorator: DotsDecorator(
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    color: AppColor.black,
                    // Inactive color
                    activeColor: AppColor.geeBung,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
