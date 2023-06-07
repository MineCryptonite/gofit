import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(builder: (context) {
      return SizedBox(
        width: 100,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .center, // Align children in the center vertically
          children: [
            Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
      return "이미 등록된 이메일입니다.";
    case "account-exists-with-different-credential":
      return "이미 등록된 이메일입니다.";
    case "email-already-in-use":
      return "이미 등록된 이메일입니다.";
    case "ERROR_WRONG_PASSWORD":
      return "비밀번호가 일치하지 않습니다.";
    case "wrong-password":
      return "비밀번호가 일치하지 않습니다.";
    case "ERROR_USER_NOT_FOUND":
      return "등록되지 않은 이메일 주소입니다.";
    case "user-not-found":
      return "등록되지 않은 이메일 주소입니다.";
    case "ERROR_USER_DISABLED":
      return "사용자가 비활성화되어있습니다.";
    case "user-disabled":
      return "사용자가 비활성화되어있습니다.";
    case "ERROR_TOO_MANY_REQUESTS":
      return "요청이 너무 많습니다";
    case "operation-not-allowed":
      return "요청이 너무 많습니다";
    case "ERROR_OPERATION_NOT_ALLOWED":
      return "요청이 너무 많습니다";
    case "ERROR_INVALID_EMAIL":
      return "유효하지 않은 이메일 주소입니다.";
    case "invalid-email":
      return "유효하지 않은 이메일 주소입니다.";
    default:
      return "로그인에 실패했습니다. 다시 시도해주세요.";
  }
}

bool loginValidation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    showMessage("이메일이랑 비밀번호를 입력해주세요.");
    return false;
  } else if (email.isEmpty) {
    showMessage("이메일을 입력해주세요.");
    return false;
  } else if (password.isEmpty) {
    showMessage("비밀번호를 입력해주세요.");
    return false;
  } else {
    return true;
  }
}

bool signUpValidation(
    String email, String password, String name, String phone) {
  if (email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty) {
    showMessage("입력해주세요.");
    return false;
  } else if (name.isEmpty) {
    showMessage("이름을 입력해주세요.");
    return false;
  } else if (email.isEmpty) {
    showMessage("이메일을 입력해주세요.");
    return false;
  } else if (phone.isEmpty) {
    showMessage("전화번호를 입력해주세요.");
    return false;
  } else if (password.isEmpty) {
    showMessage("비밀번호를 입력해주세요.");
    return false;
  } else {
    return true;
  }
}
