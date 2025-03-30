import 'package:flutter/material.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/city_card.dart';

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

  final List<CardItem> _items = [
    CardItem("Cairo", "assets/images/cities/cairo.png"),
    CardItem("Alexandria", "assets/images/cities/alex copy.png"),
    CardItem("Dahab", "assets/images/cities/Dahab.jpg"),
    CardItem("Taba", "assets/images/cities/Taba.jpg"),
    CardItem("Luxor", "assets/images/cities/luxur.png"),
    CardItem("Aswan", "assets/images/cities/Aswan.webp"),
    CardItem("Sharm Elshiekh", "assets/images/cities/SharmElshiekh.jpg"),
    CardItem("Hurghada", "assets/images/cities/Hurghada.jpg"),
    CardItem("North East", "assets/images/cities/North East.jpg"),
    CardItem("Alamein", "assets/images/cities/Alamien.jpg"),
    CardItem("Port Said", "assets/images/cities/PortSaid.webp"),
    CardItem("Suez", "assets/images/cities/Suez.jpg"),
    CardItem("Marsa Alam", "assets/images/cities/MarsaAlam.jpg"),
    CardItem("Matrouh", "assets/images/cities/Matrouh.jpg"),
    CardItem("Fayoum", "assets/images/cities/Fayoum.jpg"),
  ];

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
                child: buildCard(_items[index].title, _items[index].imagePath),
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

  CardItem(this.title, this.imagePath);
}
