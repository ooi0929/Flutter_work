import 'package:flutter/material.dart';

import '../const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.errorText,
    this.autofocus = false,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // OutlineInputBorder - 텍스트필드 경계선 영역
    // UnderlineInputBorder - 텍스트필드 아랫선 영역
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        // 테두리 색상
        color: INPUT_BORDER_COLOR,
        // 테두리 굵기
        width: 1.0,
      ),
    );

    return TextFormField(
      // 커서 색상
      cursorColor: PRIMARY_COLOR,

      // 보안 여부
      obscureText: obscureText,

      // 자동 포커싱 여부
      autofocus: autofocus,

      // 입력값 처리
      onChanged: onChanged,

      // 스타일
      decoration: InputDecoration(
        // 컨텐츠 패딩
        contentPadding: EdgeInsets.all(16.0),
        // 힌트 텍스트
        hintText: hintText,
        // 힌트 스타일
        hintStyle: TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 14.0,
        ),
        // 에러 텍스트
        errorText: errorText,
        // 텍스트필드 배경 색상 여부
        filled: true,
        // 텍스트필드 배경 색상
        fillColor: INPUT_BG_COLOR,
        // 텍스트필드 테두리 세팅
        border: baseBorder,
        enabledBorder: baseBorder.copyWith(
          // copyWith를 활용한 기존 코드 활용 + 부분 수정
          borderSide: baseBorder.borderSide.copyWith(
            color: PRIMARY_COLOR,
          ),
        ),
      ),
    );
  }
}
