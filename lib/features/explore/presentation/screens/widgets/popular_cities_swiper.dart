import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/features/explore/presentation/manager/cubits/city_cubit/city_cubit.dart';
import 'package:journijots/features/explore/presentation/manager/repos/city/city_repo_impl.dart';
import 'package:journijots/features/explore/presentation/screens/city_screen.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/build_card.dart';

class PopularCitiesSwiper extends StatefulWidget {
  const PopularCitiesSwiper({super.key});

  @override
  State<PopularCitiesSwiper> createState() => _PopularCitiesSwiperState();
}

class _PopularCitiesSwiperState extends State<PopularCitiesSwiper> {
  final PageController _pageController = PageController(
    viewportFraction: 0.8,
    initialPage: 0,
  );

  int _currentPage = 0;

  final List<CardItem> _items = kcitycards;
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 400,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _items.length,
            itemBuilder: (context, index) {
              bool isCurrentPage = index == _currentPage;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutQuint,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..scale(isCurrentPage ? 1.0 : 0.9),
                child: buildCard(_items[index].title, _items[index].imagePath,
                    _items[index].subtitle, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (_) => CityCubit(getIt<CityRepoImpl>())
                          ..getActivities(
                            city: _items[index].title,
                            pageNum: '1',
                          ),
                        child: CityScreen(
                          city: _items[index].title,
                          cityImage: _items[index].imagePath,
                          desc: _items[index].subtitle,
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _items.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: _currentPage == index ? 24 : 8,
              decoration: BoxDecoration(
                color: _currentPage == index ? Colors.blue : Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CardItem {
  final String title;
  final String imagePath;
  final String subtitle;
  CardItem(this.title, this.imagePath, this.subtitle);
}
