import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "crypto calculator",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double investment = 0.0;
  double initialCoinPrice = 0.0;
  double sellingCoinPrice = 0.0;
  double investmentFee = 0.0;
  double exitFee = 0.0;
  double investmentFee1 = 0.0;
  double exitFee1 = 0.0;
  double total = 0.0;
  double diffrence = 0.0;
  double btc = 0.0;

  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  void calculate() {
    investmentFee1 = investment * (investmentFee / 100);
    btc = ((investment - investmentFee1) / initialCoinPrice);
    exitFee1 = btc * sellingCoinPrice * (exitFee / 100);
    diffrence = btc * sellingCoinPrice - investment - exitFee1;
    total = diffrence + investment;
  }

  Widget input(double width, String label, int index, {bool isDollar = true}) {
    return Container(
        width: width > 600 ? 500 : width * 0.8,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            cursorColor: Colors.black,
            controller: controllers[index],
            onChanged: (value) {
              if (value.trim() != "" &&
                  RegExp(r'([0-9])+(.([0-9])+)?').hasMatch(value.trim())) {
                if (index == 0) {
                  investment = double.parse(controllers[index].text);
                } else if (index == 1) {
                  initialCoinPrice = double.parse(controllers[index].text);
                } else if (index == 2) {
                  sellingCoinPrice = double.parse(controllers[index].text);
                } else if (index == 3) {
                  investmentFee = double.parse(controllers[index].text);
                } else {
                  exitFee = double.parse(controllers[index].text);
                }
                if (initialCoinPrice != 0.0) {
                  setState(() {
                    calculate();
                  });
                }
              }
            },
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                prefixIcon: Icon(
                  isDollar
                      ? Icons.monetization_on_sharp
                      : CupertinoIcons.percent,
                  color: Colors.black,
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)))),
          )
        ]));
  }

  String formatNumber(double number) {
    return number.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
        onTap: () {
          return FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    color: Colors.transparent,
                    width: width * 0.8,
                    height: height * 0.2,
                    child: Center(
                        child: Text(
                          "Coin profit/loss calculator",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff99FEFF),
                              fontFamily: "praise",
                              fontSize:
                              width > height ? height * 0.1 : width * 0.1),
                        )),
                  )),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(top: height * 0.1, bottom: 30.0),
                    width: width,
                    height: height * 0.8,
                    decoration: BoxDecoration(
                        color: Color(0xff99FEFF),
                        borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(150.0))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          input(width, "Investment:", 0),
                          SizedBox(
                            height: 5.0,
                          ),
                          input(width, "Initial Coin Price:", 1),
                          SizedBox(
                            height: 10.0,
                          ),
                          input(width, "Selling Coin Price:", 2),
                          SizedBox(
                            height: 10.0,
                          ),
                          input(width, "Investment Fee:", 3, isDollar: false),
                          SizedBox(
                            height: 10.0,
                          ),
                          input(width, "Exit Fee:", 4, isDollar: false),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            (diffrence >= 0 ? "+\$" : "-\$") + formatNumber(diffrence.abs()),
                            style: TextStyle(
                              fontSize:
                              width > height ? height * 0.1 : width * 0.1,
                              color: diffrence >= 0 ? Colors.green : Colors.red,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text("Total Investment Fee: \$${formatNumber(investmentFee1)}",
                              style: TextStyle(
                                color: Colors.red,
                              )),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text("Total Exit Fee: \$${formatNumber(exitFee1)}",
                              style: TextStyle(
                                color: Colors.red,
                              )),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text("Total: \$${formatNumber(total)}",
                              style: TextStyle(
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }
}
