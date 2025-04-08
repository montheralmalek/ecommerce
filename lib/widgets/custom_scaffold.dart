import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.title,
    this.subTitle,
    this.bodyRaduis = 30,
    this.body,
    this.textAlign = TextAlign.center,
    this.bodyAlignment = Alignment.topCenter,
    this.titleTrailing,
    this.titleLeading,
    this.bodyPadding,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });

  final String title;
  final String? subTitle;
  final Widget? body, titleTrailing, titleLeading, floatingActionButton;
  final double bodyRaduis;
  final TextAlign textAlign;
  final Alignment bodyAlignment;
  final EdgeInsetsGeometry? bodyPadding;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Column(
          children: [
            // - Header -----------------------------------
            ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              titleTextStyle: Theme.of(
                context,
              ).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              subtitleTextStyle: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
              title: Text(title, textAlign: textAlign),
              subtitle:
                  subTitle == null
                      ? null
                      : Text(subTitle!, textAlign: textAlign),
              trailing: titleTrailing,
              leading: titleLeading,
            ),
            // - Body ------------------------------------
            Expanded(
              child: Container(
                width: context.size?.width,
                padding: bodyPadding ?? const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(bodyRaduis),
                    topRight: Radius.circular(bodyRaduis),
                  ),
                ),
                child: Align(alignment: bodyAlignment, child: body),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
