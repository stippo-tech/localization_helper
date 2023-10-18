part of '../home_screen.dart';

class _IndentSetting extends StatefulWidget {
  const _IndentSetting({
    required this.name,
    required this.value,
    required this.onChanged,
    this.exceptionText,
  });

  final String name;
  final int? value;
  final void Function(String value) onChanged;
  final String? exceptionText;

  @override
  State<_IndentSetting> createState() => _IndentSettingState();
}

class _IndentSettingState extends State<_IndentSetting> {
  late final _controller = TextEditingController(text: widget.value.toString());

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      widget.onChanged(_controller.value.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.name,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(width: 44),
            SizedBox(
              width: 60,
              child: TextField(
                controller: _controller,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          widget.exceptionText ?? '',
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: Theme.of(context).colorScheme.error),
        ),
      ],
    );
  }
}
