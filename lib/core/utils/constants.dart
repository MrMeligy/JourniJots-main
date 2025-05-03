import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/popular_cities_swiper.dart';

const String gemeniApiKey = "AIzaSyBCzbvWXF2pquURupElpF8gF_69h8mAKUA";
const Color kprimarycolor = Color(0xff1C366E);
const Color kscaffoldcolor = Color(0xffC0C0C0);
const Color kbodycolor = Color(0xffFFFFFF);
const Color ksplashcolor = Color(0xFF68B0F8);
const Color konboarding1textcolor = Color(0xff2052B3);
const Color konboardingbuttun = Color(0xff8CB6DC);
const List<Map<String, dynamic>> interests = [
  {
    "title": "Nature Exploring",
    "icon": "assets/icons/nature.png",
    "values": [
      "Nature Adventures",
      "Parks & Natural Scenery",
      "Camping Under the Stars"
    ]
  },
  {
    "title": "Food",
    "icon": "assets/icons/food.png",
    "values": ["Local Food Experiences", "Fresh Seafood Experiences"]
  },
  {
    "title": "Night Shows",
    "icon": "assets/icons/night.png",
    "values": ["Night Activities & Light Shows"]
  },
  {
    "title": "Hiking",
    "icon": "assets/icons/hiking.png",
    "values": ["Mountain Adventures & Hiking", "Road Trips & Hiking"]
  },
  {
    "title": "Religious Visits",
    "icon": "assets/icons/religion.png",
    "values": ["Historic Mosques & Churches"]
  },
  {
    "title": "Museums & Art",
    "icon": "assets/icons/museum.png",
    "values": ["Museums & Art Exhibits", "Ancient Fortresses & Castles"]
  },
  {
    "title": "Nile Cruise",
    "icon": "assets/icons/boat.png",
    "values": ["Nile Cruises & Felucca Rides", "Island Trips & Beach Escapes"]
  },
  {
    "title": "Shopping",
    "icon": "assets/icons/shopping.png",
    "values": ["Traditional Markets & Souvenirs"]
  },
  {
    "title": "Beach",
    "icon": "assets/icons/beach.png",
    "values": ["Island Trips & Beach Escapes", "Relaxation & Resorts"]
  },
  {
    "title": "Photography",
    "icon": "assets/icons/photography.png",
    "values": ["Travel Photography", "Hot Air Balloon Rides"]
  },
  {
    "title": "Space Exploration",
    "icon": "assets/icons/space.png",
    "values": ["Astronomical Observations"]
  },
  {
    "title": "Diving & Beach activities",
    "icon": "assets/icons/diving.png",
    "values": ["Scuba Diving & Snorkeling", "Island Trips & Beach Escapes"]
  },
  {
    "title": "Pharaonic",
    "icon": "assets/icons/pharaonic.png",
    "values": ["Pharaonic Temples", "Egyptian Monuments"]
  },
  {
    "title": "Road Trips",
    "icon": "assets/icons/raod.png",
    "values": ["Road Trips & Hiking", "Desert Safari"]
  },
  {
    "title": "Relaxation",
    "icon": "assets/icons/spa.png",
    "values": ["Relaxation & Resorts"]
  },
  {
    "title": "Nubian",
    "icon": "assets/icons/nubian.png",
    "values": ["Nubian Culture"]
  },
  {
    "title": "City Exploration",
    "icon": "assets/icons/city.png",
    "values": ["Cultural City Tours", "Historic Mosques & Churches"]
  },
  {
    "title": "Historical",
    "icon": "assets/icons/history.png",
    "values": [
      "Historical Tourism",
      "Ancient Fortresses & Castles",
      "Egyptian Monuments"
    ]
  },
];

final List<CardItem> kcitycards = [
  CardItem("Cairo", "assets/images/cities/cairo.jpg", "The Capital of Egypt"),
  CardItem("Giza", "assets/images/cities/giza.png", "The Pyramids City"),
  CardItem("Alexandria", "assets/images/cities/alex copy.png",
      "The Bride of the Mediterranean"),
  CardItem("Dahab", "assets/images/cities/Dahab.jpg",
      "A Diving and Relaxation Paradise"),
  CardItem("Taba", "assets/images/cities/Taba.jpg", "A Gateway to Sinai"),
  CardItem("Luxor", "assets/images/cities/luxur.png",
      "The World's Greatest Open-Air Museum"),
  CardItem(
      "Aswan", "assets/images/cities/Aswan.webp", "A City of Nubian Culture"),
  CardItem("Sharm Elsheikh", "assets/images/cities/SharmElshiekh.jpg",
      "The City of Peace"),
  CardItem("Hurghada", "assets/images/cities/Hurghada.jpg",
      "A Red Sea Resort Destination"),
  CardItem("Alamein", "assets/images/cities/Alamien.jpg",
      "The Newest City In Cairo"),
  CardItem("Port Said", "assets/images/cities/PortSaid.webp",
      "Entrance to the Suez Canal"),
  CardItem("Suez", "assets/images/cities/Suez.jpg", "Strategic Maritime City"),
  CardItem("Marsa Alam", "assets/images/cities/MarsaAlam.jpg",
      "Diving and Marine Life Spot"),
  // CardItem("Matrouh", "assets/images/cities/Matrouh.jpg",
  //     "Famous for its Crystal Beaches"),
  CardItem("Fayoum", "assets/images/cities/Fayoum.jpg",
      "An Oasis with Waterfalls and Heritage")
];
