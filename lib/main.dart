// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:xcall_demo/utils/xcall.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  test(data) {
    EasyLoading.showError('测试test$data');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: EasyLoading.init(),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('XCall Demo'),
          ),
          body: SingleChildScrollView(
            child: Wrap(
              children: [
                _createButton(
                    text: '添加 CallBack',
                    onPressed: () {
                      XCall.addCallBack('test', (data) {
                        EasyLoading.showInfo('测试1$data');
                      });
                      XCall.addCallBack('test', test);
                      EasyLoading.showSuccess('添加成功');
                    }),
                _createButton(
                    text: '判断是否存在某个事件',
                    onPressed: () {
                      if (XCall.hasCallBack('test', test)) {
                        EasyLoading.showSuccess('有事件test与test方法');
                      } else {
                        EasyLoading.showError('没有事件test与test方法');
                      }
                    }),
                _createButton(
                    text: '移除 CallBack',
                    onPressed: () {
                      XCall.removeCallBack('test', test);
                    }),
                _createButton(
                    text: '触发 CallBack',
                    onPressed: () {
                      XCall.dispatch('test', data: '你好呀');
                    }),
                _createButton(
                    text: '触发不存在的 CallBack',
                    onPressed: () {
                      try {
                        XCall.dispatch('test-not');
                      } catch (e) {
                        EasyLoading.showError(e.toString());
                      }
                    }),
              ],
            ),
          ),
        ));
  }
}

Widget _createButton({String text, Function onPressed}) {
  return Container(padding: EdgeInsets.all(10), child: ElevatedButton(child: Text(text), onPressed: onPressed));
}

Widget _createHorizontalLine() {
  return SizedBox(
    width: double.infinity,
    height: 1,
    child: DecoratedBox(
      decoration: BoxDecoration(color: Colors.deepPurpleAccent),
    ),
  );
}
