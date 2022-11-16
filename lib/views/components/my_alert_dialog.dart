import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class MyAlertDialog extends StatelessWidget {
  final msg;
  const MyAlertDialog({required this.msg, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoAlertDialog(
        title: Text("${msg}"),
        actions: [
          CupertinoDialogAction(
            child: Text("확인"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
