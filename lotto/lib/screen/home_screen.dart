import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lotto/components/lotto_ball.dart';
import 'package:lotto/screen/setting_screen.dart';

import '../constants/color.dart';

Random rand = Random();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Set<int> lottoNumbers = {};
  Set<int> selectNumbers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BLUE_SAX,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(
              selectNumbers: selectNumbers,
              onButtonPressed: goSettingScreen,
            ),
            _Body(lottoNumbers: lottoNumbers),
            _Fotter(createLottoNumbers: createLottoNumbers),
          ],
        ),
      ),
    );
  }

  void createLottoNumbers() {
    lottoNumbers.clear();
    lottoNumbers.addAll(selectNumbers);

    while (lottoNumbers.length < 6) {
      int number = rand.nextInt(45) + 1;

      if (!lottoNumbers.contains(number)) {
        lottoNumbers.add(number);
      }
    }

    setState(() {
      sortLottoNumbers();
    });
  }

  void sortLottoNumbers() {
    List<int> tmp = lottoNumbers.toList();
    tmp.sort();

    lottoNumbers = Set<int>.from(tmp);
  }

  void goSettingScreen() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (builder) => SettingScreen(
          selectNumbers: selectNumbers,
        ),
      ),
    );

    if (result != null) {
      selectNumbers = result;
    }
  }
}

class _Header extends StatelessWidget {
  Set<int> selectNumbers;
  VoidCallback onButtonPressed;
  _Header({required this.selectNumbers, required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "로또 번호",
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.w600, color: ROMANCE_BLUE),
        ),
        IconButton(
          onPressed: onButtonPressed,
          icon: Icon(
            Icons.settings,
            // size: 50,
            color: ROMANCE_BLUE,
          ),
          iconSize: 35,
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final Set<int> lottoNumbers;
  const _Body({required this.lottoNumbers});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...lottoNumbers.map(
                (e) => LottoBall(number: e),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _Fotter extends StatelessWidget {
  final VoidCallback createLottoNumbers;
  const _Fotter({required this.createLottoNumbers});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: ROMANCE_BLUE,
            padding: const EdgeInsets.symmetric(vertical: 15),
            textStyle: const TextStyle(
              fontSize: 18,
            )),
        onPressed: createLottoNumbers,
        child: const Text('번호 생성하기'));
  }
}
