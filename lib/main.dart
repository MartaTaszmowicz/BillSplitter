import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BillSplitter(),
    );
  }
}

class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

Color getPurple([double opacity = 1.0]) {
  Color color = Color(0xFF6908D6);
  return color.withOpacity(opacity);
}

calculateTotalPerPerson(double totalTip, double billAmout, int splitBy) {
  var totalPerPerson = (totalTip + billAmout) / splitBy;
  return totalPerPerson;
}

calculateTotalTip(double billAmount, int splitBy, int tipPrecentage) {
  double totalTip = 0.0;

  if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null) {
  } else {
    totalTip = (billAmount * tipPrecentage) / 100;
  }
  return totalTip;
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPrecentage = 0;
  int _personCounter = 1;
  double _billAmout = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      alignment: Alignment.center,
      color: Colors.white,
      child: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                color: getPurple(0.1), borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "Tootal Per Pesson:",
                      style: TextStyle(color: getPurple(), fontSize: 27),
                    ),
                  ),
                  Text(
                    " \$ $_billAmout",
                    style: TextStyle(
                        color: getPurple(),
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer()
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                  color: Colors.blueGrey.shade100, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(
                      color: getPurple(),
                      fontWeight: FontWeight.bold,
                      fontSize: 27.0),
                  decoration: InputDecoration(
                      prefixText: "Bill Amount  ",
                      prefixStyle: TextStyle(fontSize: 16.0),
                      prefixIcon: Icon(Icons.attach_money)),
                  onChanged: (String value) {
                    setState(() {
                      try {
                        _billAmout = double.parse(value);
                      } catch (e) {
                        _billAmout = 0;
                      }
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Split",
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(
                              () {
                                if (_personCounter > 1) {
                                  _personCounter--;
                                }
                              },
                            );
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: getPurple(0.1),
                            ),
                            child: Center(
                              child: Text(
                                "-",
                                style: TextStyle(
                                    color: getPurple(),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 27.0),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "$_personCounter",
                          style: TextStyle(
                              color: getPurple(),
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                        InkWell(
                          onTap: () {
                            setState(
                              () {
                                _personCounter++;
                              },
                            );
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: getPurple(0.1),
                            ),
                            child: Center(
                              child: Text(
                                "+",
                                style: TextStyle(
                                    color: getPurple(), fontSize: 27.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tip",
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "\$ ${calculateTotalTip(_billAmout, _personCounter, _tipPrecentage)}",
                        style: TextStyle(
                            color: getPurple(),
                            fontWeight: FontWeight.bold,
                            fontSize: 27),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "$_tipPrecentage\%",
                      style: TextStyle(
                          color: getPurple(),
                          fontWeight: FontWeight.bold,
                          fontSize: 27),
                    ),
                    Slider(
                        value: _tipPrecentage.toDouble(),
                        min: 1,
                        max: 30,
                        activeColor: getPurple(),
                        onChanged: (newValue) {
                          setState(() {
                            _tipPrecentage = newValue.round();
                          });
                        })
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
