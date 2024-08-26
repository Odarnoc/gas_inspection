import 'package:flutter/cupertino.dart';

/// Wrapper for stateful functionality to provide onInit calls in stateles widget
class StatefulWrapper extends StatefulWidget {
  final Function? onInit;
  final Function? onMounted;
  final Function? onDispose;
  final Widget child;
  const StatefulWrapper(
      {super.key,
      this.onInit,
      this.onMounted,
      this.onDispose,
      required this.child});
  @override
  StatefulWrapperState createState() => StatefulWrapperState();

  defaultEmptyFunction() {}
}

class StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.onMounted != null) {
        widget.onMounted!();
      }
    });
    if (widget.onInit != null) {
      widget.onInit!();
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.onDispose != null) {
      widget.onDispose!();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
