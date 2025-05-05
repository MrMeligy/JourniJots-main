import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/core/utils/text_styles.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/popular_cities_swiper.dart';

class TripWidget extends StatelessWidget {
  const TripWidget({
    super.key,
    required this.city,
    required this.date,
  });
  final String city;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Builder(builder: (context) {
          CardItem? cityData;
          for (var card in kcitycards) {
            if (card.title.toLowerCase() == city.toLowerCase()) {
              cityData = card;
              break;
            }
          }
          return Container(
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(16)),
                image: DecorationImage(
                  image: AssetImage(cityData!.imagePath),
                  fit: BoxFit.cover,
                )),
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.12,
          );
        }),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xff224A67),
                Color(0xff4493CD),
              ]),
              borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
            ),
            height: MediaQuery.of(context).size.height * 0.12,
            child: Row(
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      city,
                      style: TextStyles.font18White,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.date_range,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          date,
                          style: TextStyles.font18White,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
