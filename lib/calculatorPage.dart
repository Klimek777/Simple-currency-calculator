import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:calculator/main.dart';
import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String expression = '0';
  String result = '0';
  double plneur = 4.71;
  double plnusd = 4.83;
  double eurusd = 0.98;

  int fromselectedCurrency = 0;
  int toselectedCurrency = 0;
  List<String> currencies = ['EUR', 'PLN', 'USD'];

  buttonPressed(buttonText) {
    setState(() {
      try {
        if (buttonText == 'C') {
          expression = '0';
          result = '0';
        } else {
          if (expression == "0") {
            expression = buttonText;
            buttonText = '';
          }
          expression = expression + buttonText;
          if (fromselectedCurrency == 0 && toselectedCurrency == 1) {
            setState(() {
              // eur to pln
              result = (double.parse(expression) * plneur).toStringAsFixed(2);
            });
          } else if (fromselectedCurrency == 1 && toselectedCurrency == 0) {
            setState(() {
              //pln to eur
              result = (double.parse(expression) / plneur).toStringAsFixed(2);
            });
          } else if (fromselectedCurrency == 0 && toselectedCurrency == 2) {
            setState(() {
              //eur to usd
              result = (double.parse(expression) * eurusd).toStringAsFixed(2);
            });
          } else if (fromselectedCurrency == 2 && toselectedCurrency == 0) {
            setState(() {
              //usd to eur
              result = (double.parse(expression) / eurusd).toStringAsFixed(2);
            });
          } else if (fromselectedCurrency == 1 && toselectedCurrency == 2) {
            setState(() {
              //pln to usd
              result = (double.parse(expression) * plnusd).toStringAsFixed(2);
            });
          } else if (fromselectedCurrency == 2 && toselectedCurrency == 1) {
            setState(() {
              //usd to pln
              result = (double.parse(expression) / plnusd).toStringAsFixed(2);
            });
          } else {
            setState(() {
              //usd to pln
              result = double.parse(expression).toStringAsFixed(2);
            });
          }
        }
      } catch (e) {}
    });
  }

  Widget buildButton(String buttonText) {
    return Container(
      margin: EdgeInsets.all(5),
      alignment: Alignment.center,
      width: 90,
      height: 60,
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(5)),
      child: TextButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency calculator'),
      ),
      body: SafeArea(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CupertinoButton(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                expression,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                              Text(
                                currencies[fromselectedCurrency],
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          onPressed: () => showCupertinoModalPopup(
                              context: context,
                              builder: (_) => SizedBox(
                                    width: double.infinity,
                                    height: 250,
                                    child: CupertinoPicker(
                                      backgroundColor: Colors.white,
                                      itemExtent: 30,
                                      scrollController:
                                          FixedExtentScrollController(),
                                      children: [
                                        Text('EUR'),
                                        Text('PLN'),
                                        Text('USD')
                                      ],
                                      onSelectedItemChanged: (value) {
                                        setState(() {
                                          fromselectedCurrency = value;
                                        });
                                      },
                                    ),
                                  )),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 40,
                        ),
                        CupertinoButton(
                          onPressed: () => showCupertinoModalPopup(
                              context: context,
                              builder: (_) => SizedBox(
                                    width: double.infinity,
                                    height: 250,
                                    child: CupertinoPicker(
                                      backgroundColor: Colors.white,
                                      itemExtent: 30,
                                      scrollController:
                                          FixedExtentScrollController(),
                                      children: [
                                        Text('EUR'),
                                        Text('PLN'),
                                        Text('DOL')
                                      ],
                                      onSelectedItemChanged: (value) {
                                        setState(() {
                                          toselectedCurrency = value;
                                        });
                                      },
                                    ),
                                  )),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              FittedBox(
                                child: Text(
                                  result,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                              ),
                              Text(
                                currencies[toselectedCurrency],
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        )
                      ]),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.2666,
                      child: buildButton('C')),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Table(
                      children: [
                        TableRow(
                          children: [
                            buildButton('7'),
                            buildButton('8'),
                            buildButton('9')
                          ],
                        ),
                        TableRow(
                          children: [
                            buildButton('4'),
                            buildButton('5'),
                            buildButton('6')
                          ],
                        ),
                        TableRow(
                          children: [
                            buildButton('1'),
                            buildButton('2'),
                            buildButton('3')
                          ],
                        ),
                        TableRow(
                          children: [
                            buildButton('.'),
                            buildButton('0'),
                            buildButton('00')
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}
