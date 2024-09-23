import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoItem extends StatefulWidget {
  // 새로운 Todo가 생성될 때마다 TodoItem의 인스턴스가 서로 다르게 생성될 것이기 때문에
  // index를 통해 구분한다.
  final int index;

  // 현재 인스턴스에서 삭제/수정을 할 경우 todo 페이지에서 UI가 새롭게 반영이 안되기 때문에
  // todoList Notifier를 가져와서 현재 인스턴스에서 변경 시 todo 페이지의 UI에서도 반영이 되도록 한다.
  final ValueNotifier<List<String>> todoListNotifier;

  const TodoItem({
    super.key,
    required this.index,
    required this.todoListNotifier,
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late SharedPreferences prefs;

  // 체크 여부를 관리 할 ValueNotifier
  final _isChecked = ValueNotifier<bool>(false);

  // 초기화 작업
  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    _isChecked.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          // 체크박스
          Expanded(
            flex: 1,
            child: ValueListenableBuilder(
              valueListenable: _isChecked,
              builder: (context, value, child) {
                return Checkbox(
                  checkColor: Colors.white,
                  fillColor: WidgetStateProperty.resolveWith(
                    (states) {
                      Set<WidgetState> interactiveStates = {
                        WidgetState.pressed, // 눌럿을 때
                        WidgetState.hovered, // 마우스 올려둘 때
                        WidgetState.focused, // 포커싱 됐을 때
                      };

                      // 위에서 정의한 states 중에 하나라도 존재한다면 true 분기실행
                      if (states.any(interactiveStates.contains)) {
                        return Colors.grey;
                      } else {
                        return Colors.amber[300];
                      }
                    },
                  ),
                  value: value,
                  onChanged: (value) {
                    _isChecked.value = !_isChecked.value;
                  },
                );
              },
            ),
          ),
          // Todo 내용
          Expanded(
            flex: 7,
            child: ValueListenableBuilder(
              // 체크 변경 시 알림을 통해 새롭게 빌드.
              valueListenable: _isChecked,
              builder: (context, value, child) {
                return ValueListenableBuilder(
                    // todo 변경 시 알림을 통해 새롭게 빌드. -> todo가 변경되면 List에도 반영이 되기에 todo page UI도 알림을 통해 새롭게 빌드된다.
                    valueListenable: widget.todoListNotifier,
                    builder: (context, value, child) {
                      return Text(
                        value[widget.index],
                        style: TextStyle(
                          decoration: _isChecked.value
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      );
                    });
              },
            ),
          ),
          // 수정
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () async {
                // 다이얼로그를 통해 반환될 값을 저장할 변수
                String? updatedTodo = await _showEditDialog(context);

                if (updatedTodo != null && updatedTodo.isNotEmpty) {
                  // 수정 후 체크 해제
                  _isChecked.value = false;
                  // List를 복제한 다음 임시 변수에 넣지 않으면 데이터 누수가 발생할 수 있음. 따라서 임시 변수를 이용한다.
                  final updatedList =
                      List<String>.from(widget.todoListNotifier.value);
                  updatedList[widget.index] = updatedTodo; // 수정한 ToDo를 반영
                  widget.todoListNotifier.value = updatedList; // 상태 업데이트
                  await prefs.setStringList(
                      'todoList', updatedList); // 저장소 업데이트
                }
              },
              icon: Icon(
                Icons.edit,
              ),
            ),
          ),
          // 삭제
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () async {
                bool? isDelete = await _showDeleteDialog(context);

                if (isDelete == true) {
                  // 데이터 누수 방지
                  final updatedList =
                      List<String>.from(widget.todoListNotifier.value);
                  updatedList.removeAt(widget.index); // 해당 항목 삭제
                  widget.todoListNotifier.value = updatedList; // 상태 업데이트
                  await prefs.setStringList(
                      'todoList', updatedList); // 저장소 업데이트
                }
              },
              icon: Icon(
                Icons.delete,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 수정 다이얼로그
  Future<String?> _showEditDialog(BuildContext context) async {
    TextEditingController controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('수정 확인'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: '여기에 수정할 일을 입력해주세요.',
            ),
          ),
          actions: [
            TextButton(
              // 취소 클릭시 아무것도 반환하지 않음
              onPressed: () => Navigator.pop(context),
              child: const Text('취소', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              // 수정 클릭시 수정된 텍스트를 반환한다.
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text('수정', style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  // 삭제 다이얼로그
  Future<bool?> _showDeleteDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('삭제 확인'),
          content: const Text('정말 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('취소', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('삭제', style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }
}
