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
  int text1 = 0;
  int text2 = 0;
  double valueText = 0;
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
                          onChanged: (value) {
                            setState(() {
                              text1 = value.length;
                            });
                            if (text1 == text2) {
                              setState(() {
                                valueText = 0;
                                print('object value of');
                              });
                            }
                            if (text1 > text2) {
                              setState(() {
                                valueText = -0.3;
                                print('object value of');
                              });
                            }
                            if (text1 < text2) {
                              setState(() {
                                valueText = 0.3;
                                print('object value of');
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
                          onChanged: (value1) {
                            setState(() {
                              text2 = value1.length;
                            });
                            if (text1 == text2) {
                              setState(() {
                                valueText = 0;
                                print('object value of');
                              });
                            }
                            if (text1 > text2) {
                              setState(() {
                                valueText = -0.3;
                                print('object value of');
                              });
                            }
                            if (text1 < text2) {
                              setState(() {
                                valueText = 0.3;
                                print('object value of');
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
                  alignment: FractionalOffset.center,
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
