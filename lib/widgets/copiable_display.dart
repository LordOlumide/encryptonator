import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class CopiableDisplay extends StatefulWidget {
  final String text;

  const CopiableDisplay({super.key, required this.text});

  @override
  State<CopiableDisplay> createState() => _CopiableDisplayState();
}

class _CopiableDisplayState extends State<CopiableDisplay> {
  Widget buttonWidget = const Text(
    'Copy',
    style: TextStyle(fontSize: 15, color: Colors.black),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 6,
      ),
      child: Column(
        children: [
          SelectableText(
            widget.text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: _copy,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: buttonWidget,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _copy() async {
    FlutterClipboard.copy(widget.text);
    setState(() {
      buttonWidget = const Text(
        'Copied!',
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w600, color: Colors.purple),
      );
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      buttonWidget = const Text(
        'Copy',
        style: TextStyle(fontSize: 15, color: Colors.black),
      );
    });
  }
}
