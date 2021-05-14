import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _size = 5;
  int _bpm = 120;
  int _up_beat = 4;
  int _down_beat = 4;

  @override
  void initState() {
    super.initState();
  }

  // cupertinoPickerの子供として設定すると自然に見えるウィジェットを作る

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Looper'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Roller(
                  text: '小節:',
                  variable: _size,
                  number: 32,
                ),
                Spacer(),
                Roller(
                  text: 'BPM:',
                  variable: _bpm,
                  number: 200,
                ),
                Spacer(),
              ],
            ),
            Container(height: 100),
            DoubleRoller(
              text: '拍子',
              up_variable: _up_beat,
              down_variable: _down_beat,
              up_number: 12,
              down_number: 3,
            ),
          ],
        ),
      ),
    );
  }
}

// ローラーで値を設定する
class Roller extends StatefulWidget {
  final String text;
  final int variable;
  final int number;

  const Roller({
    Key? key,
    required this.text,
    required this.number,
    required this.variable,
  }) : super(key: key);


  @override
  _RollerState createState() => _RollerState();
}

class _RollerState extends State<Roller> {
  // cupertinoPickerの子供として設定すると自然に見えるウィジェットを作る
  Widget cupertinoPickerChild(String text) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.text,
          style: Theme.of(context).textTheme.headline5,
        ),
        Container(
          height: 70,
          width: 50,
          child: CupertinoPicker(
            itemExtent: 40,
            children: List.generate(widget.number,
                (index) => cupertinoPickerChild((index + 1).toString())),
            scrollController:
                FixedExtentScrollController(initialItem: widget.variable - 1),
            onSelectedItemChanged: (int value) {
              setState(() {
                value = value + 1;
              });
            },
          ),
        ),
      ],
    );
  }
}

class DoubleRoller extends StatefulWidget {
  final String text;
  final int up_variable;
  final int down_variable;
  final int up_number;
  final int down_number;

  const DoubleRoller(
      {Key? key,
      required this.text,
      required this.up_variable,
      required this.down_variable,
      required this.up_number,
      required this.down_number})
      : super(key: key);

  @override
  _DoubleRollerState createState() => _DoubleRollerState();
}

class _DoubleRollerState extends State<DoubleRoller> {
  // cupertinoPickerの子供として設定すると自然に見えるウィジェットを作る
  Widget cupertinoPickerChild(String text) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.text,
          style: Theme.of(context).textTheme.headline5,
        ),
        Container(
          height: 70,
          width: 50,
          child: CupertinoPicker(
            itemExtent: 40,
            children: List.generate(widget.up_number,
                (index) => cupertinoPickerChild((index + 1).toString())),
            scrollController: FixedExtentScrollController(
                initialItem: widget.up_variable - 1),
            onSelectedItemChanged: (int value) {
              setState(() {
                value = value + 1;
              });
            },
          ),
        ),
        Text(
          '/',
          style: Theme.of(context).textTheme.headline5,
        ),
        Container(
          height: 70,
          width: 50,
          child: CupertinoPicker(
            itemExtent: 40,
            children: List.generate(widget.down_number,
                (index) => cupertinoPickerChild(pow(2, index + 1).toString())),
            scrollController: FixedExtentScrollController(
                initialItem: widget.down_variable - 1),
            onSelectedItemChanged: (int value) {
              setState(() {
                value = value + 1;
              });
            },
          ),
        ),
      ],
    );
  }
}
