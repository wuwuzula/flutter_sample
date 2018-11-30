import 'package:flutter/material.dart';

// 创建一个 MyApp
void main() => runApp(MyApp());

// 这个 widget 作用这个应用的顶层 widget
// 这个 widget 是无状态的，所以我们继承的是 [StatelessWidget].
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      //home: new MaLinPage(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter rolling demo'),
        ),
        body: Center(
          child: RollingButton(),
        ),
      ),
    );
  }
}

class RollingButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _RollingState();
  }
}

class _RollingState extends State<RollingButton> {
  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      onPressed: _clickButton,
      child: Text('button2'),
    );
  }
}

void _clickButton() {
  debugPrint('clicked button');
}
