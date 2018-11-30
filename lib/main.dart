import 'dart:math';

import 'package:flutter/material.dart';

// https://jekton.github.io/2018/08/26/flutter-first-app/
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
          title: TestWidget3(),
        ),
        body: Center(
          //child: RollingButton(),
          //child: MessageForm(),
          child: StackWidget(),
        ),
      ),
    );
  }
}

//布局 水平布局我们可以使用 Row
class RowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[Text('data1'), Text('data2'), Text('data3')],
    );
  }
}

//布局 竖直布局使用 Column
class ColumnWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('data1'),
        Text('data2'),
        Text('data3'),
        Text('data4'),
      ],
    );
  }
}

//Expanded
class ExpandedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        ///占满一行里除 RaisedButton 外的所有空间
        Expanded(
          flex: 1,
          child: RaisedButton(
            onPressed: () => debugPrint('clicked expanded button1'),
            child: Text('button1'),
          ),
        ),
        Expanded(
          flex: 2,
          child: RaisedButton(
            onPressed: () => debugPrint('clicked expanded button2'),
            child: Text('button2'),
          ),
        ),

        Expanded(
          flex: 2,
          child: RaisedButton(
            onPressed: () => debugPrint('clicked expanded button3'),
            child: Text('button3'),
          ),
        ),
        RaisedButton(
          child: Text('button'),
          onPressed: () => debugPrint('clicked RaiseButton'),
        ),
      ],
    );
  }
}

//一个控件叠在另一个控件的上面,Stack 布局
//默认情况下，子控件都按 Stack 的左上角对齐，于是，上面的两个文本完全一上一下堆叠在一起。
//我们还可以通过设置 alignment 参数来改变这个对齐的位置
class StackWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const Alignment(0, 0),
      children: <Widget>[
        Container(
          width: 200.0,
          height: 200.0,
          color: Colors.blue,
        ),
        Image.network(
            'https://i0.hdslb.com/bfs/archive/2da91009ab56b5b9c90f0360c4ebaeb5d02686e0.gif',
            width: 69,
            height: 40),
        Text('foobar'),
      ],
    );
  }
}

//文本输入框
//Flutter 的文本输入框叫 TextField。为了获取用户输入的文本，
//我们需要给他设置一个 controller。
//通过这个 controller，就可以拿到文本框里的内容：
class MessageForm extends StatefulWidget {
  @override
  State createState() {
    return _MessageFormState();
  }
}

class _MessageFormState extends State<MessageForm> {
  var editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Row、Expand 都是用于布局的控件，这里可以先忽略它们
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: editController,
          ),
        ),
        RaisedButton(
          child: Text("click"),
          onPressed: () {
            showDialog(
                // 第一个 context 是参数名，第二个 context 是 State 的成员变量
                context: context,
                builder: (_) {
                  return AlertDialog(
                    // dialog 的内容
                    content: Text(editController.text),
                    // actions 设置 dialog 的按钮
                    actions: <Widget>[
                      FlatButton(
                        child: Text('OK'),
                        // 用户点击按钮后，关闭弹框
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  );
                });
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    // 手动调用 controller 的 dispose 方法以释放资源
    editController.dispose();
  }
}

class TextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Text(
      'Flutter rolling demo',
      style: TextStyle(
        color: Colors.red,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('TestWidget'),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(4.0),
      width: 200.0,
      decoration: BoxDecoration(
        // 背景色
        color: Colors.red,
        // 圆角
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}

class TestWidget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('TestWidget2'),
    );
  }
}

class TestWidget3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.0),
      margin: EdgeInsets.all(10.0),
      width: 200.0,
      height: 100.0,
      decoration: BoxDecoration(
        // 背景色
        color: Colors.red,
        // 圆角
        borderRadius: BorderRadius.circular(10.0),
      ),
      // 把文本放在 Container 的中间
      child: Center(
        child: Text('TestWidget3'),
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
  final _random = Random();

  List<int> _roll() {
    final roll1 = _random.nextInt(6) + 1;
    final roll2 = _random.nextInt(6) + 1;
    return [roll1, roll2];
  }

  @override
  Widget build(BuildContext context) {
    // 通过设置 onPressed 回调，我们可以在按钮被点击的时候得到回调。
    // child 参数用于设置按钮的内容。虽然我们给 child 传递的是 Text，
    // 但这不是必需的，它可以接受任意的 Widget，比方说，Image。
    var button = new RaisedButton(
      onPressed: () {
        _clickButton();
      },
      child: Text('button1'),
    );

    button = new RaisedButton(
      onPressed: () => debugPrint('button clicked'),
      child: new Text('button2'),
    );

    button = new RaisedButton(
      onPressed: _clickButton,
      child: Image.network(
          "https://i0.hdslb.com/bfs/archive/a1193e8695cf4c19f96129ffccf32fd37d54f1de.gif",
          width: 69,
          height: 40),
    );
    return button;
  }

  void _clickButton() {
    debugPrint('clicked button22');
    final roolResult = _roll();
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text('AlertDialog2 ${roolResult[0]} ${roolResult[1]}'),
          );
        });
  }
}
