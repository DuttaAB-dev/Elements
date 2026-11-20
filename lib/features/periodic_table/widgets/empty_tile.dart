import 'package:flutter/widgets.dart';
import '../../../core/constants/app_constants.dart';

class EmptyTile extends StatelessWidget {
  const EmptyTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: AppConstants.gutterInset,
      child: ColoredBox(color: Color(0xFF424242)),
    );
  }
}
