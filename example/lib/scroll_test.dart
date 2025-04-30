import 'package:flutter/material.dart';
import 'package:hand_signature/signature.dart';

class ScrollTest extends StatefulWidget {
  const ScrollTest({Key? key}) : super(key: key);
  
  @override
  _ScrollTestState createState() => _ScrollTestState();
}

class _ScrollTestState extends State<ScrollTest> {
  final List<String> dummyData = List.generate(
    20,
    (index) => 'Item ${index + 1}: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
  );
  final control = HandSignatureControl(
    threshold: 5.0,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );

  bool scrollEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Signature Scroll Test'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => control.clear(),
          ),
        ],
      ),
      body: ListView(
        physics: scrollEnabled
            ? const BouncingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        children: <Widget>[
          ...dummyData.take(5).map((text) => ListTile(
            title: Text(text),
            leading: const CircleAvatar(child: Icon(Icons.person)),
          )),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              child: Container(
                constraints: const BoxConstraints.expand(height: 200.0),
                color: Colors.white,
                child: HandSignature(
                  control: control,
                  type: SignatureDrawType.shape,
                  onPointerDown: () {
                    setState(() {
                      scrollEnabled = false;
                    });
                  },
                  onPointerUp: () {
                    setState(() {
                      scrollEnabled = true;
                    });
                  },
                ),
              ),
            ),
          ),
          ...dummyData.skip(5).map((text) => ListTile(
            title: Text(text),
            leading: const CircleAvatar(child: Icon(Icons.person)),
          )),
        ],
      ),
    );
  }
}
