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
  int temp = 0; //for find difference between left and right
  final TextEditingController _a =
      TextEditingController(); // for left Textformfield
  final TextEditingController _b =
      TextEditingController(); // for right Textformfield

  @override
  dataclear() {
    valueText = 0;
    _a.clear();
    _b.clear();
    text1 = 0;
    text2 = 0;

    temp = 0;
  }

  Widget build(BuildContext context) {
    valueText > 1.57 || valueText < -1.57 ? dataclear() : null;
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

                            temp = text1 - text2;

                            if (valueText > 1.57) {
                              setState(() {
                                dataclear();
                              });
                            } else {
                              // 0 to 90 degree
                              setState(() {
                                valueText = temp < 0
                                    ? text1 < text2
                                        ? -(temp.toDouble() / 100)
                                        : (temp.toDouble() / 100)
                                    : -(temp.toDouble() / 100);
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

                            temp = text1 - text2;

                            if (valueText < -1.57) {
                              setState(() {
                                dataclear();
                              });
                            } else {
                              // 0 to 90 degree
                              setState(() {
                                valueText = temp < 0
                                    ? -(temp.toDouble() / 100)
                                    : text1 < text2
                                        ? (temp.toDouble() / 100)
                                        : -(temp.toDouble() / 100);
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
