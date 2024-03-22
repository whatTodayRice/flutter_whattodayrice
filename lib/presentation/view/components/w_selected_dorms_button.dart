import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectedDormitoryButton extends ConsumerStatefulWidget {
  final bool selected;
  final VoidCallback? onPressed;
  final String buttonText;

  const SelectedDormitoryButton({
    super.key,
    required this.selected,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  ConsumerState<SelectedDormitoryButton> createState() =>
      _SelectedDormitoryButtonState();
}

class _SelectedDormitoryButtonState
    extends ConsumerState<SelectedDormitoryButton> {
  late final MaterialStatesController statesController;

  @override
  void initState() {
    super.initState();
    statesController = MaterialStatesController(
        <MaterialState>{if (widget.selected) MaterialState.selected});
  }

  @override
  void didUpdateWidget(SelectedDormitoryButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected != oldWidget.selected) {
      statesController.update(MaterialState.selected, widget.selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(2),
          shadowColor: MaterialStateProperty.all<Color>(Colors.grey),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )),
          foregroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.white;
              }
              return Colors.black;
            },
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return const Color(0xFFFF833D);
              }
              return const Color(0xFFFFFAF6);
            },
          ),
        ),
        statesController: statesController,
        onPressed: widget.onPressed,
        child: Text(
          widget.buttonText,
          style:
              GoogleFonts.notoSans(fontSize: 16, fontWeight: FontWeight.w500),
        ));
  }
}
