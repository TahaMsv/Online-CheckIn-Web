import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final rulesProvider = ChangeNotifierProvider<RulesState>((_) => RulesState());

class RulesState with ChangeNotifier {
  setState() => notifyListeners();

   List rules = [
    {
      "imageUrl": "",
      "title": "Magnetic Objects",
      "content": "Magnets, Batteries and Magnetic Objects",
    },
    {
      "imageUrl": "",
      "title": "Type of Toxins",
      "content": "Powder, Liquid and Sprays of Laboratory Products For Infectious Agents",
    },
    {
      "imageUrl": "",
      "title": "Radioactive Material",
      "content": "Radioactive Substances Exposed To Radiation",
    },
    {
      "imageUrl": "",
      "title": "Types of Spray",
      "content": "Spray Containers (Including Spray Dispensers)",
    },
    {
      "imageUrl": "",
      "title": "Types of Capsule",
      "content": "Gas Lighters, Oxygen and Any Type of Gas Cylinder",
    },
    {
      "imageUrl": "",
      "title": "Incendiary types",
      "content": "Matches are Just a Small Number Along With (strictly prohibited in the box)",
    },
    {
      "imageUrl": "",
      "title": "Types of Explosives ",
      "content": "Types of Ammunition, Explosives, Firecrackers and Fireworks Accessories",
    },
    {
      "imageUrl": "",
      "title": "Types of Oxidizing",
      "content": "Oxidizing and Oxidizing Materials, Detergents and Disinfectants",
    },
    {
      "imageUrl": "",
      "title": "Types of Weapons",
      "content": "Any Firearms or Cold Weapons (Knives, Scissors, Horns, Colt)",
    },
    {
      "imageUrl": "",
      "title": "Types of Acidic",
      "content": "Wet batteries, acidic substances, acidic fluids (lemon juice, pickles, etc.)",
    },
  ];

}
