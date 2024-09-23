import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'component/todo_item.dart';
import 'todo_add.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  // 내부 디스크에 접근하기 위한 SharedPreferences 선언
  late SharedPreferences prefs;

  // Todo List를 관리할 ValueNotifier 선언
  final todoList = ValueNotifier<List<String>>([]);

  // 데이터 초기화 작업
  @override
  void initState() {
    super.initState();
    // 초기 데이터 초기화
    _loadTodoList();
  }

  // SharedPreferences 초기화 작업 및 ToDo 리스트 불러오기
  Future<void> _loadTodoList() async {
    prefs = await SharedPreferences.getInstance();
  }

  // Todo 리스트를 SharedPreferences에 저장하기
  Future<void> _saveToDoList() async {
    await prefs.setStringList('todoList', todoList.value);
  }

  // Todo 추가
  Future<void> _addNewToDO() async {
    // 추가된 새로운 Todo를 담을 변수.
    String newTodo = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TodoAdd(),
      ),
    );

    // 새로운 Todo가 빈 문자열이 아닌경우
    // todoList.value와 동일한 리스트를 갖는 객체를 복사하고 새로운 객체를 추가한다.
    // todoList Notifier 알림과 동시에 내부 디스크에 새로운 todoList를 갱신한다.
    if (newTodo.isNotEmpty) {
      todoList.value = List<String>.from(todoList.value)..add(newTodo);
      _saveToDoList(); // 업데이트된 리스트 저장
    }
  }

  // 메모리 누수 방지
  @override
  void dispose() {
    todoList.dispose(); // ValueNotifier 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 제목
      appBar: AppBar(
        title: Text(
          'Todo List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber[300],
        leading: IconButton(
          onPressed: () {
            // go를 통해서 왔기 때문에 이전 라우트스택이 사라짐.
            // 별도로 다시 지정해서 이동.
            context.go('/');
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      // Todo List 페이지
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: todoList,
          builder: (context, value, child) {
            if (value.isEmpty) {
              // todoList가 비어있다면
              return Center(
                child: Text('할 일이 없습니다.'),
              );
            } else {
              // todoList가 비어있지 않다면
              return ListView.builder(
                itemCount: value.length, // 개수만큼 생성
                itemBuilder: (context, index) {
                  // 생성할 TodoItem
                  // Todo 목록을 구분지어 사용할 것이기에 index를 넘겨준다.
                  return TodoItem(
                    index: index,
                    todoListNotifier: todoList,
                  );
                  // return Text('1');
                },
              );
            }
          },
        ),
      ),
      // Todo 추가 버튼
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[300],
        shape: CircleBorder(),
        onPressed: _addNewToDO,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
