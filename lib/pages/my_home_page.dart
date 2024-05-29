import 'package:calculator_demo/widgets/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:math_expressions/math_expressions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> btnList = [
    'C',
    'Del',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    '00',
    '=',
  ];
  String ques = '';
  String ans = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${ques}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${ans}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: GridView.builder(
                  itemCount: btnList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    var title = btnList[index];
                    var btnColor;
                    if (title == '/' ||
                        title == 'x' ||
                        title == '-' ||
                        title == '+' ||
                        title == '=' ||
                        title == '%') {
                      btnColor = GFColors.DARK;
                    } else if (title == 'C') {
                      btnColor = GFColors.DANGER;
                    } else if (title == 'Del') {
                      btnColor = GFColors.WARNING;
                    } else {
                      btnColor = GFColors.FOCUS;
                    }

                    return MyButton(
                      btnColor: btnColor,
                      title: title,
                      btnTapped: () {
                        if (title == 'C') {
                          setState(() {
                            ques = '';
                            ans = '';
                          });
                        } else if (title == 'Del') {
                          setState(() {
                            if (ques.isEmpty) {
                              return;
                            }
                            ques = ques.substring(0, ques.length - 1);
                          });
                        } else if (title == '=') {
                          Parser p = Parser();
                          Expression exp = p.parse(ques.replaceAll('x', '*'));
                          ContextModel cm = ContextModel();
                          double eval = exp.evaluate(EvaluationType.REAL, cm);
                          String temp = eval.toString();
                          if (temp.endsWith('.0')) {
                            temp = temp.substring(0, temp.length - 2);
                          }
                          setState(() {
                            ans = temp;
                            ques = '';
                          });
                        } else {
                          setState(() {
                            ques += title;
                          });
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
