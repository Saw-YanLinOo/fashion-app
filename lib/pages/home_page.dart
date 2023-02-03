import 'package:animation/blocs/theme_bloc.dart';
import 'package:animation/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animation/extensions/widget.dart';
import 'package:provider/provider.dart';

const kAnnimationDurationFadeIn = Duration(milliseconds: 1000);

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(
                    height: 110,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TweenAnimationBuilder(
                    duration: kAnnimationDurationFadeIn,
                    tween: Tween<double>(begin: -1, end: 0),
                    builder: (context, double value, child) {
                      return Transform.translate(
                        offset: Offset(value * 50, 0.0),
                        child: child,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: TrendingSection(
                        onTap: () {
                          toNextScreen(context, DetailPage());
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TweenAnimationBuilder(
                    duration: kAnnimationDurationFadeIn,
                    tween: Tween<double>(begin: 1, end: 0),
                    builder: (context, double value, child) {
                      return Opacity(
                        opacity: 1 - value,
                        child: Transform.translate(
                          offset: Offset(0.0, value * 50),
                          child: child,
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: RecomendedSection(),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            )
          ]),
          TweenAnimationBuilder(
            duration: kAnnimationDurationFadeIn,
            tween: Tween<double>(begin: -1, end: 0),
            builder: (context, double opacity, child) {
              return Opacity(
                opacity: 1 + opacity,
                child: Transform.translate(
                  offset: Offset(0.0, opacity * 50.0),
                  child: child,
                ),
              );
            },
            child: Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.only(left: 32, top: 32),
              child: HomeAppBarTitle(),
            ),
          ),
          HomeBottomNavigationBar(),
        ],
      ),
    );
  }
}

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      width: MediaQuery.of(context).size.width,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48),
        ),
        child: Material(
          elevation: 6,
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.home_filled),
                Icon(Icons.search),
                Icon(Icons.shopping_basket_rounded),
                Icon(Icons.bookmark_outline_sharp),
                Container(
                  width: 32,
                  height: 32,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/profile.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecomendedSection extends StatelessWidget {
  const RecomendedSection({
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
              'Recomended',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).textTheme.titleMedium?.color,
              ),
            ),
            Icon(FontAwesomeIcons.ellipsis),
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

class RecomendedItem extends StatelessWidget {
  const RecomendedItem({
    Key? key,
    this.title,
    this.image,
    required this.color,
  }) : super(key: key);

  final String? title;
  final String? image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      height: MediaQuery.of(context).size.width * 0.35,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: Image.asset(image ?? 'assets/shoe.png'),
            ),
            Text(
              title ?? 'Shoes',
              style: TextStyle(
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrendingSection extends StatelessWidget {
  const TrendingSection({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Trending For You',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).textTheme.titleMedium?.color,
              ),
            ),
            Icon(FontAwesomeIcons.ellipsis),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        GestureDetector(
          onTap: () {
            onTap();
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.5,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/outfit.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 32,
                      height: 32,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Colors.pink.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.heart,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New 2022',
                          style: TextStyle(
                            color: Colors.pink.shade100,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            'Modern Outfit Collection',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                'assets/profile.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Firna Surapt',
                              style: TextStyle(
                                color: Colors.pink.shade100,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class HomeAppBarTitle extends StatelessWidget {
  const HomeAppBarTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeBloc>(builder: (context, bloc, child) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/profile.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Hawdy',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).textTheme.titleMedium?.color,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Christia Yota',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Theme.of(context).textTheme.titleMedium?.color,
                      ),
                    ),
                  ],
                )
              ],
            ),
            IconButton(
              onPressed: () {
                bloc.changeTheme();
              },
              icon: Icon(
                Icons.notifications,
                size: 32,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ],
        ),
      );
    });
  }
}
