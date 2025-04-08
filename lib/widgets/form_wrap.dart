import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormWrap extends StatelessWidget {
  final double width;
  final double? height;
  final List<Widget> children, actions;
  final AutovalidateMode? autovalidateMode;
  final GlobalKey<FormState>? formKey;
  final EdgeInsetsGeometry? contentPadding, actionsPadding;
  final bool isScrollable;
  final Color? backgroundColor, actionsBackgroundColor;
  final double? elevation;
  final BorderRadiusGeometry? borderRadius;
  final Clip? clipBehavior;
  final bool showActionsShadow, allowScrollActions;
  final String? title, subTitle;

  const FormWrap({
    super.key,
    required this.children,
    this.autovalidateMode,
    this.formKey,
    this.width = 500,
    this.height,
    this.actions = const [],
    this.contentPadding,
    this.actionsPadding,
    this.isScrollable = true,
    this.backgroundColor,
    this.actionsBackgroundColor,
    this.elevation = 2,
    this.borderRadius,
    this.clipBehavior = Clip.antiAlias,
    this.showActionsShadow = true,
    this.title,
    this.subTitle,
    this.allowScrollActions = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(10),
        ),
        clipBehavior: clipBehavior,
        color: backgroundColor ?? Theme.of(context).colorScheme.surface,
        elevation: elevation,
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (title != null && subTitle != null)
                ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  titleTextStyle: Theme.of(
                    context,
                  ).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    // color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  subtitleTextStyle: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(
                    // color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  title:
                      title == null
                          ? null
                          : Text(title!, textAlign: TextAlign.center),
                  subtitle:
                      subTitle == null
                          ? null
                          : Text(subTitle!, textAlign: TextAlign.center),
                ),
              Expanded(
                // flex: height == null ? 0 : 1,
                child: Center(
                  child: SingleChildScrollView(
                    padding:
                        contentPadding ??
                        const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                    physics:
                        isScrollable
                            ? const BouncingScrollPhysics()
                            : const NeverScrollableScrollPhysics(),
                    child: Wrap(
                      clipBehavior: Clip.hardEdge,
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runSpacing: 15,
                      spacing: 10,
                      children: children,
                    ),
                  ),
                ),
              ),
              if (actions.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding:
                      actionsPadding ??
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    color:
                        actionsBackgroundColor ??
                        Theme.of(context).colorScheme.surface,
                    boxShadow:
                        showActionsShadow
                            ? [
                              BoxShadow(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.3),
                                offset: const Offset(0, -2),
                                blurRadius: 5,
                              ),
                            ]
                            : null,
                  ),
                  child:
                      allowScrollActions
                          ? _scrollableActions()
                          : _unScrollableActions(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _scrollableActions() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: List.generate(
          actions.length,
          (index) => Container(
            constraints: BoxConstraints(maxWidth: width - 30),
            child: actions[index].marginSymmetric(horizontal: 5),
          ),
        ),
      ),
    );
  }

  Widget _unScrollableActions() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        actions.length,
        (index) => actions[index].marginSymmetric(vertical: 5),
      ),
    );
  }
}
