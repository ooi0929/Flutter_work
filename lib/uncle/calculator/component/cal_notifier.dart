import 'package:flutter/material.dart';

class CalNotifier extends ChangeNotifier {
  // ValueNotifier 변수 선언
  // 식
  // 결과
  final ValueNotifier<String> _displayNotifier;
  final ValueNotifier<String> _resultNotifier;

  // Singleton Instance
  // 오직 _instance 변수만이 해당 클래스의 인스턴스를 가지고 있음.
  static final CalNotifier _instance = CalNotifier._internal();

  // private 생성자 - 외부에서 이 클래스를 생성하지 못하도록
  CalNotifier._internal()
      : _displayNotifier = ValueNotifier<String>(''),
        _resultNotifier = ValueNotifier<String>('0');

  // singleton Instance getter
  // get 메서드를 통해서만 해당 인스턴스에 접근할 수 있음.
  // 어디서든지 get을 통해서 접근하더라도 같은 인스턴스에 접근하게됨.
  static CalNotifier get instance => _instance;

  // ValueNotifier getter
  ValueNotifier<String> get displayNotifier => _displayNotifier;
  ValueNotifier<String> get resultNotifier => _resultNotifier;

  // 키보드를 탭할 시 키보드의 값들을 이어 붙이기. (특정 작업이 일어날 때까지)
  void process(String keyboard) {
    if (keyboard == 'AC') {
      _clear();
    } else if (keyboard == '-/+') {
      _toggleSign();
    } else if (keyboard == '%') {
      _percentage();
    } else if (keyboard == '@') {
      _undo();
    } else if (keyboard == '=') {
    } else {
      _displayNotifier.value += keyboard;
    }
  }

  // 완료
  void _clear() {
    _displayNotifier.value = '';
    _resultNotifier.value = '0';
  }

  // 완료
  void _toggleSign() {
    if (_displayNotifier.value.isNotEmpty) {
      if (_displayNotifier.value.startsWith('-')) {
        _displayNotifier.value = _displayNotifier.value.substring(1);
      } else {
        _displayNotifier.value = '-${_displayNotifier.value}';
      }

      _resultNotifier.value = _displayNotifier.value;
    }
  }

  void _percentage() {
    if (_displayNotifier.value.isNotEmpty) {
      double number = double.parse(_displayNotifier.value);
      _displayNotifier.value = (number / 100).toString();
      _resultNotifier.value = _displayNotifier.value;
    }
  }

  void _undo() {}
}
