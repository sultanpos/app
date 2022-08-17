import 'package:flutter/material.dart';

class BaseWindowWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final double? width;
  final double? height;
  const BaseWindowWidget({Key? key, required this.title, this.width, this.height, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(8)), border: Border.all(color: Colors.white)),
        width: width ?? 300,
        height: height ?? 300,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(child: Text(title)),
                    ),
                  ),
                  CloseWidget(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 2,
              color: Colors.blue,
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CloseWidget extends StatefulWidget {
  final VoidCallback onTap;
  const CloseWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CloseWidget> createState() => _CloseWidgetState();
}

class _CloseWidgetState extends State<CloseWidget> {
  bool _onHover = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (value) {
        _onHover = value;
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: _onHover ? Colors.red[300] : Colors.red,
          borderRadius: const BorderRadius.only(topRight: Radius.circular(8)),
        ),
        child: const Icon(
          Icons.close,
          color: Colors.white,
        ),
      ),
    );
  }
}
