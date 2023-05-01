import 'package:flutter/material.dart';

import '../constants/color.dart';

List<List<int>> lotto = [
  [1, 2, 3, 4, 5],
  [6, 7, 8, 9, 10],
  [11, 12, 13, 14, 15],
  [16, 17, 18, 19, 20],
  [21, 22, 23, 24, 25],
  [26, 27, 28, 29, 30],
  [31, 32, 33, 34, 35],
  [36, 37, 38, 39, 40],
  [41, 42, 43, 44, 45],
];

class SettingScreen extends StatefulWidget {
  Set<int> selectNumbers;
  SettingScreen({required this.selectNumbers, super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late final Set<int> selectNumbers;

  @override
  void initState() {
    super.initState();

    selectNumbers = widget.selectNumbers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BLUE_SAX,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 18, left: 20),
              child: Row(
                children: [
                  Text(
                    '나왔으면 하는 숫자 선택하기',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'NanumGothic',
                      fontWeight: FontWeight.w800,
                      color: ROMANCE_BLUE,
                    ),
                  )
                ],
              ),
            ),
            LottoNumbers(
              selectNumbers: selectNumbers,
            ),
            _Fotter(
              onButtonPressed: goHomeScreen,
            ),
          ],
        ),
      ),
    );
  }

  void goHomeScreen() {
    Navigator.of(context).pop(selectNumbers);
  }
}

class LottoNumbers extends StatelessWidget {
  Set<int> selectNumbers;
  LottoNumbers({
    super.key,
    required this.selectNumbers,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          for (var i = 0; i < lotto.length; i++)
            Padding(
              padding: i == lotto.length - 1
                  ? const EdgeInsets.all(0)
                  : const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var j = 0; j < lotto[i].length; j++)
                    LottoNumber(
                        selectNumbers: selectNumbers,
                        number: lotto[i][j],
                        isSelected: selectNumbers.contains(lotto[i][j])),
                ],
              ),
            )
        ],
      ),
    );
  }
}

class LottoNumber extends StatefulWidget {
  final Set<int> selectNumbers;
  final int number;
  bool isSelected;

  LottoNumber({
    required this.selectNumbers,
    required this.number,
    required this.isSelected,
    super.key,
  });

  @override
  State<LottoNumber> createState() => _LottoNumberState();
}

class _LottoNumberState extends State<LottoNumber> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (widget.selectNumbers.length < 6) {
            if (widget.selectNumbers.contains(widget.number)) {
              widget.selectNumbers.remove(widget.number);
            } else {
              widget.selectNumbers.add(widget.number);
            }
            widget.isSelected = !widget.isSelected;
          } else {
            if (widget.selectNumbers.contains(widget.number)) {
              widget.selectNumbers.remove(widget.number);
              widget.isSelected = !widget.isSelected;
            }
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.isSelected ? BLUE_MOON_SELECTED : BLUE_MOON,
          borderRadius: BorderRadius.circular(10),
        ),
        width: 45,
        height: 45,
        child: Center(
            child: Text(
          '${widget.number}',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        )),
      ),
    );
  }
}

class _Fotter extends StatelessWidget {
  final VoidCallback onButtonPressed;
  const _Fotter({required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: ROMANCE_BLUE,
              padding: const EdgeInsets.symmetric(vertical: 15),
              textStyle: const TextStyle(
                fontSize: 18,
              )),
          onPressed: onButtonPressed,
          child: const Text('저장하기')),
    );
  }
}
