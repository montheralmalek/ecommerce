import 'package:flutter/material.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';

class SectionTileWidget extends StatelessWidget {
  const SectionTileWidget({
    super.key,
    this.title,
    this.content,
    this.spacing = 10.0,
    this.trailing,
    this.leading,
    this.headerPadding = EdgeInsets.zero,
    this.contentPadding = EdgeInsets.zero,
  });
  final Widget? title;
  final Widget? trailing;
  final Widget? leading;
  final Widget? content;
  final double spacing;
  final EdgeInsetsGeometry headerPadding;
  final EdgeInsetsGeometry contentPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_hasHeader) _buildHeader(context),
        Offstage(offstage: !_hasHeader, child: SizedBox(height: spacing)),
        content ?? SizedBox.shrink(),
      ],
    );
  }

  bool get _hasHeader => title != null || trailing != null;
  bool get _hasFooter => false;
  Widget _buildHeader(BuildContext context) {
    return DefaultTextStyle.merge(
      style: context.textTheme.titleLarge,
      child: Padding(
        padding: headerPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (leading != null) leading!,
            if (title != null) title!,
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }

  // _buildFooter(BuildContext context) {}
}
// void onPopInvokedWithResult(didPop, result) async {
//         if (didPop) {
//           return;
//         }
//      var   canPop = await showPlatformDialog<bool>(
//           context: context,
//           builder: (context) {
//             return PlatformAlertDialog(
//               title: Text('Confirm Exit'),
//               content: Text(
//                 'You are leaving the Product Detail screen. Do you want to continue?',
//               ),
//               actions: [
//                 PlatformDialogAction(
//                   onPressed: () => context.pop<bool>(true),
//                   child: Text('OK'),
//                 ),
//                 PlatformDialogAction(
//                   onPressed: () => context.pop(false),
//                   child: Text('Cancel'),
//                 ),
//               ],
//             );
//           },
//         ).then((value) => value ?? false);
//         if (canPop) {
//           context.pop();
//         }
//       },