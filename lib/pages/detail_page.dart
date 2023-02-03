import 'package:animation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int groupValue = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              child: SizedBox(),
              preferredSize: Size(0, 20),
            ),
            pinned: false,
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            flexibleSpace: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/outfit.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 50,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 30,
                          ),
                        ),
                        Row(
                          children: [
                            FavouriateButton(),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.share,
                              size: 30,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(50),
                      ),
                    ),
                  ),
                  bottom: -1,
                  left: 0,
                  right: 0,
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 12,
                ),
                GeneralSection(),
                SizedBox(
                  height: 8,
                ),
                DescriptionSection(),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizeSection(
                    groupValue: groupValue,
                    sizeList: ['S', 'M', 'L', 'X', 'XL'],
                    onTap: (value) {
                      setState(() {
                        groupValue = value ?? 0;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: RelatedSection(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RelatedSection extends StatelessWidget {
  const RelatedSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Related outfit',
              style: TextStyle(
                  color: Theme.of(context).textTheme.titleMedium?.color,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              '..',
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            RecomendedItem(
              title: 'Shoes',
              image: 'assets/shoe.png',
              color: Colors.pink.shade100,
            ),
            RecomendedItem(
              title: 'Cactus',
              image: 'assets/cactus.png',
              color: Colors.blue.shade400,
            ),
            RecomendedItem(
              title: 'Cactus',
              image: 'assets/cactus.png',
              color: Colors.blue.shade400,
            ),
          ],
        ),
      ],
    );
  }
}

class FavouriateButton extends StatefulWidget {
  const FavouriateButton({
    Key? key,
  }) : super(key: key);

  @override
  State<FavouriateButton> createState() => _FavouriateButtonState();
}

class _FavouriateButtonState extends State<FavouriateButton>
    with TickerProviderStateMixin {
  bool isAnimationComplete = false;

  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller =
        AnimationController(duration: kAnnimationDurationFadeIn, vsync: this);

    _colorAnimation = ColorTween(begin: Colors.white, end: Colors.red)
        .animate(_controller.view);
    _rotateAnimation =
        Tween<double>(begin: 0, end: math.pi * 2).animate(_controller.view);

    _controller.addStatusListener((status) {
      isAnimationComplete = status == AnimationStatus.completed;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotateAnimation.value,
          child: IconButton(
            onPressed: () {
              if (isAnimationComplete) {
                _controller.reverse();
              } else {
                _controller.forward();
              }
            },
            icon: Icon(
              FontAwesomeIcons.solidHeart,
              size: 30,
              color: _colorAnimation.value,
            ),
          ),
        );
      },
    );
  }
}

class GeneralSection extends StatelessWidget {
  const GeneralSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'OUTFIT IDEAS',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Modern Blue Jacket',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleMedium?.color,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '\$ 19,39',
          style: TextStyle(
            color: Colors.indigo,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

class DescriptionSection extends StatelessWidget {
  const DescriptionSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        'Descriptions',
        style: TextStyle(
            color: Theme.of(context).textTheme.titleMedium?.color,
            fontSize: 16,
            fontWeight: FontWeight.w600),
      ),
      initiallyExpanded: true,
      shape: Border.all(style: BorderStyle.none),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            'Let’s see what extension methods are and what they doIn the simple word If I explain it to you then “It will get you rid of from the Utility class with lots of static methods you are creating all along.”And in a broad term, “Extension methods are methods added to an object after an original object compiled.”et’s see the example code of the utility class that we may are using currently.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class SizeSection extends StatelessWidget {
  const SizeSection({
    Key? key,
    required this.groupValue,
    required this.sizeList,
    required this.onTap,
  }) : super(key: key);

  final int groupValue;
  final List<String> sizeList;
  final Function(int?) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Size your size',
              style: TextStyle(
                  color: Theme.of(context).textTheme.titleMedium?.color,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'Size Guide',
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 50,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: sizeList.length,
            itemBuilder: (context, index) {
              var e = sizeList[index];

              return SizedItemView(
                size: e,
                index: index,
                color: index == groupValue ? Colors.indigo : Colors.white,
                onTap: (value) {
                  onTap(value);
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 12,
              );
            },
          ),
        ),
        // Wrap(
        //   spacing: 12,
        //   runSpacing: 12,
        //   children: sizeList.map((e) {
        //     index++;

        //     return TweenAnimationBuilder(
        //       duration: kAnnimationDurationFadeIn,
        //       tween: ColorTween(begin: Colors.white, end: Colors.blue),
        //       builder: (BuildContext context, Color? value, Widget? child) {
        //         return SizedItemView(
        //           size: e,
        //           index: index,
        //           color: index == groupValue ? value : Colors.white,
        //           onTap: (value) {
        //             setState(() {
        //               groupValue = value ?? 0;
        //             });
        //           },
        //         );
        //       },
        //     );
        //   }).toList(),
        // ),
      ],
    );
  }
}

class SizedItemView extends StatelessWidget {
  const SizedItemView({
    Key? key,
    this.size,
    this.color,
    this.index,
    required this.onTap,
  }) : super(key: key);

  final String? size;
  final Color? color;
  final int? index;
  final Function(int?) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(index);
      },
      child: Material(
        color: color,
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 48,
          height: 48,
          child: Center(
            child: Text(
              "$size",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
