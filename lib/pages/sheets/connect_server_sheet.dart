import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ConnectServerSheet extends StatefulWidget {
  const ConnectServerSheet({
    super.key,
    required this.confirmCallback,
    required this.backCallback,
  });

  final void Function(String) confirmCallback;
  final void Function() backCallback;

  @override
  State<ConnectServerSheet> createState() => _ConnectServerSheetState();
}

class _ConnectServerSheetState extends State<ConnectServerSheet> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return PaddedColumn(
      padding: const EdgeInsets.all(16),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _textEditingController,
          decoration: const InputDecoration(
            label: Text('Server URL'),
          ),
        ),
        const Gap(8),
        ElevatedButton(
          onPressed: () => widget.confirmCallback(_textEditingController.text),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: const Text('Confirm'),
        ),
        const Gap(8),
        ElevatedButton(
          onPressed: widget.backCallback,
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
