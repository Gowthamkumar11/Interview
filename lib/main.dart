import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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

  dynamic db = FirebaseFirestore.instance; // database instance

  int databasevaluefortext1 = 0; // database value for _a  length
  int databasevaluefortext2 = 0; // database value for _b  length

  @override
  void initState() {
    dataclear();
    super.initState();
  }

  @override
  dataclear() async {
    valueText = 0;
    _a.clear();
    _b.clear();
    text1 = 0;
    text2 = 0;
    temp = 0;
    await db
        .collection('length')
        .doc('char')
        .update({'text1len': 0, 'text2len': 0});
  }

  datafetch(String Collection, String Document, int field1, int field2) async {
    await db
        .collection(Collection)
        .doc(Document)
        .update({'text1len': field1, 'text2len': field2}).then((_) async {
      await db.collection(Collection).doc(Document).get().then((databack) {
        databasevaluefortext1 = databack['text1len'];
        databasevaluefortext2 = databack['text2len'];
      });
    });
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _a,
                          onChanged: (_) {
                            // setstate is used for rerender the UI
                            setState(() {
                              text1 = _a.text.length;
                            });

                            datafetch('length', 'char', text1, text2)
                                .then((value) {
                              temp =
                                  databasevaluefortext1 - databasevaluefortext2;

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
                            });
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

                            datafetch('length', 'char', text1, text2).then(
                              (value) {
                                temp = databasevaluefortext1 -
                                    databasevaluefortext2;
                                if (valueText < -1.57) {
                                  setState(() {
                                    dataclear();
                                  });
                                } else {
                                  // 0 to 90 degree
                                  setState(
                                    () {
                                      valueText = temp < 0
                                          ? -(temp.toDouble() / 100)
                                          : text1 < text2
                                              ? (temp.toDouble() / 100)
                                              : -(temp.toDouble() / 100);
                                    },
                                  );
                                }
                              },
                            );
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
              StreamBuilder<DocumentSnapshot>(
                  stream: db.collection('length').doc('char').snapshots(),
                  builder: (BuildContext context, snapshot) {
                    dynamic returndata = snapshot.data;

                    if (returndata == null) {
                      return Container();
                    }
                    return Center(
                      child: Transform(
                        child: Container(
                          color: Colors.lightBlueAccent,
                          height: 50,
                          width: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              conWidget(returndata['text1len'].toString()),
                              conWidget(returndata['text2len'].toString()),
                            ],
                          ),
                        ),
                        // for container alignment
                        alignment: FractionalOffset.center,
                        // for Z axis rotation
                        transform: Matrix4.identity()..rotateZ(valueText * 1),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

Widget conWidget(val) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      color: Colors.white,
      height: 30,
      width: 60,
      child: Center(
        child: Text(val),
      ),
    ),
  );
}
