import 'package:flutter/material.dart';
import 'package:journijots/builders/nav_bar_element_boxdecoration.dart';
import 'package:journijots/core/utils/constants.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: const Color(0xff8CB6DC),
      ),
      child: Row(
        //main container
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //home button
          GestureDetector(
            onTap: () => onTap(0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: boxDecorationNavBarElement(
                currentIndex: currentIndex,
                index: 0,
              ),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.home,
                    size: 35,
                    color: currentIndex == 0
                        ? const Color(0xff8CB6DC)
                        : kbodycolor,
                  ),
                  if (currentIndex == 0)
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Home",
                        style: TextStyle(
                          color: Color(0xff8CB6DC),
                          fontSize: 25,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          //explore button
          GestureDetector(
            onTap: () => onTap(1),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: boxDecorationNavBarElement(
                currentIndex: currentIndex,
                index: 1,
              ),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.explore,
                    size: 35,
                    color: currentIndex == 1
                        ? const Color(0xff8CB6DC)
                        : kbodycolor,
                  ),
                  if (currentIndex == 1)
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Explore",
                        style: TextStyle(
                          color: Color(0xff8CB6DC),
                          fontSize: 25,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          //profile button
          GestureDetector(
            onTap: () => onTap(2),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: boxDecorationNavBarElement(
                currentIndex: currentIndex,
                index: 2,
              ),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.account_circle,
                    size: 35,
                    color: currentIndex == 2
                        ? const Color(0xff8CB6DC)
                        : kbodycolor,
                  ),
                  if (currentIndex == 2)
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Profile",
                        style: TextStyle(
                          color: Color(0xff8CB6DC),
                          fontSize: 25,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
