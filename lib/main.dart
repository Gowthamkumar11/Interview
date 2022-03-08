import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int text1 = 0; // for _a value length;
  int text2 = 0; // for _b value length;
  double valueText = 0; // for rotation;
  final TextEditingController _a =
      new TextEditingController(); // for left Textformfield
  final TextEditingController _b =
      new TextEditingController(); // for right Textformfield

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Test App',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                      ),
                      height: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextFormField(
                          controller: _a,
                          onChanged: (_) {
                            // setstate is used for rerender the UI
                            setState(() {
                              text1 = _a.text.length;
                            });

                            // when both value length equal
                            if (text1 == text2) {
                              setState(() {
                                valueText = 0;
                                print('object value of equal');
                              });
                            }

                            // when left value is greater than right value
                            if (text1 > text2) {
                              // when left value reaches the 90 degree
                              if ((text1.toDouble() / 100) >= 1.57) {
                                setState(() {
                                  valueText = 0;
                                  _a.clear();
                                  _b.clear();
                                  text1 = 0;
                                  text2 = 0;

                                  print(
                                      'object text1 value highest in _a maximum ');
                                });
                              } else {
                                // 0 to 90 degree
                                setState(() {
                                  valueText = text1 > text2
                                      ? -(text1.toDouble() / 100)
                                      : (text2.toDouble() / 100);
                                  print(
                                      'object text1 value highest in _a $text1');
                                });
                              }
                            }

                            // when left value is less than right value
                            if (text1 < text2) {
                              setState(() {
                                valueText = text1.toDouble() / 100;
                                print('object value of text2 highest in _a');
                              });
                            }
                          },
                          maxLines: 15,
                          cursorHeight: 30,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type here..."),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width / 2),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                      ),
                      height: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextFormField(
                          controller: _b,
                          onChanged: (_) {
                            setState(() {
                              text2 = _b.text.length;
                            });

                            // when both value length equal.
                            if (text1 == text2) {
                              setState(() {
                                valueText = 0;
                                print('object value of equal');
                              });
                            }

                            // when left value is greater than right.
                            if (text1 > text2) {
                              setState(() {
                                valueText = -(text1.toDouble() / 100);
                                print('object value of text1 highest in _b');
                              });
                            }

                            if (text1 < text2) {
                              // when right value reaches the 90 degree
                              if (text2.toDouble() / 100 >= 1.57) {
                                setState(() {
                                  valueText = 0;
                                  _a.clear();
                                  _b.clear();
                                  text1 = 0;
                                  text2 = 0;

                                  print(
                                      'object value of text1 highest in _b maximum ');
                                });
                              } else {
                                // 0 to 90 degree
                                setState(() {
                                  valueText = text1 > text2
                                      ? -(text1.toDouble() / 100)
                                      : (text2.toDouble() / 100);

                                  print(
                                      'object value of text1 highest in _b $text1');
                                });
                              }
                            }
                          },
                          maxLines: 15,
                          cursorHeight: 30,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type here..."),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 80),

              // Line container(blue box)
              Center(
                child: Transform(
                  child: Container(
                    color: Colors.lightBlueAccent,
                    height: 50,
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              color: Colors.white,
                              height: 30,
                              width: 60,
                              child: Center(child: Text(text1.toString()))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              color: Colors.white,
                              height: 30,
                              width: 60,
                              child: Center(child: Text(text2.toString()))),
                        ),
                      ],
                    ),
                  ),
                  // for container alignment
                  alignment: FractionalOffset.center,
                  // for Z axis rotation
                  transform: Matrix4.identity()..rotateZ(valueText * 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
