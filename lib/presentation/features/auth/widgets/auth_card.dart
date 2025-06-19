import 'package:flutter/material.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import '../../../../widgets/widgets.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AuthCard extends StatelessWidget {
  const AuthCard({
    super.key,
    this.formKey,
    required this.fields,
    this.title = 'Login',
    this.subTitle,
    this.onSubmit,
    this.submitText = 'Login',
    this.submitIcon,
    this.cancelText = 'Cancel',
    this.cancelIcon,
    this.onCancel,
    this.maxWidth = 350,
    this.errorMessage,
    this.actions,
  });
  final List<Widget> fields;
  final String title, submitText, cancelText;
  final Widget? submitIcon, cancelIcon;
  final String? subTitle, errorMessage;
  final VoidCallback? onSubmit, onCancel;
  final double maxWidth;
  final GlobalKey<FormState>? formKey;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxWidth,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              // --------------- Title ---------------------------
              _buildTitleWidget(context),

              // --------------- subTitle ------------------------
              _buildSubTitleWidget(context),

              // --------------- Error message ------------------------
              _buildErrorMessageWidget(context),

              // -------------- Fields ---------------------------
              _buildFormFieldsWidget(context),
              const SizedBox(height: 10),
              // -------------- Submit button ---------------------------
              _buildSubmitButtonWidget(context),

              // -------------- Cancel Button ---------------------------
              _buildCancelButtonWidget(context),

              // -------------- Actions ---------------------------
              _buildActionsWidget(context),
            ],
          ),
        ),
      ),
    );
  }
  //**------------------- End of build method ---------------- */

  ///----------------------------------------------
  /// -------------- Error message ---------------------------
  Widget _buildErrorMessageWidget(BuildContext context) {
    if (errorMessage == null) return const SizedBox();
    return MessageWidget.error(errorMessage!);
  }

  ///----------------------------------------------
  /// -------------- Title ---------------------------
  Widget _buildTitleWidget(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.headlineLarge);
  }

  ///----------------------------------------------
  /// -------------- subTitle ---------------------------
  Widget _buildSubTitleWidget(BuildContext context) {
    if (subTitle == null) return const SizedBox();
    return Text(
      subTitle!,
      style: Theme.of(context).textTheme.bodyLarge,
      textAlign: TextAlign.center,
    );
  }

  ///----------------------------------------------
  /// -------------- fields ---------------------------
  Widget _buildFormFieldsWidget(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: fields,
      ),
    );
  }

  ///----------------------------------------------
  ///------------------ submit button ---------------------------
  Widget _buildSubmitButtonWidget(BuildContext context) {
    return CustomFilledButton.icon(
      label: submitText,
      icon: submitIcon,
      onPressed: onSubmit,
    );
  }

  ///----------------------------------------------
  ///------------------ cancel button ---------------------------
  Widget _buildCancelButtonWidget(BuildContext context) {
    if (onCancel == null) return const SizedBox();
    return CustomFilledButton.tonalIcon(
      label: cancelText,
      icon: cancelIcon,
      onPressed: onCancel,
    );
  }

  ///----------------------------------------------
  ///------------------ actions ---------------------------
  Widget _buildActionsWidget(BuildContext context) {
    if (actions == null) return const SizedBox();
    return Column(mainAxisSize: MainAxisSize.min, children: actions!);
  }
}

class MessageWidget extends StatelessWidget {
  const MessageWidget._(
    this.message, {
    super.key,
    required this.color,
    this.icon,
    this.iconColor,
    this.textColor,
  });
  factory MessageWidget.info(String message, {Key? key}) {
    return MessageWidget._(
      message,
      key: key,
      color: Colors.blue.shade700,
      icon: const Icon(Icons.info, color: Colors.blue),
      textColor: Colors.blue.shade900,
    );
  }

  factory MessageWidget.error(String message, {Key? key}) {
    return MessageWidget._(
      message,
      key: key,
      color: Colors.red.shade700,
      icon: const Icon(Icons.error, color: Colors.red),
      textColor: Colors.red.shade900,
    );
  }

  factory MessageWidget.warning(String message, {Key? key}) {
    return MessageWidget._(
      message,
      key: key,
      color: Colors.orange.shade700,
      icon: const Icon(Icons.warning, color: Colors.orange),
      textColor: Colors.orange.shade900,
    );
  }
  final Color color;
  final Color? textColor, iconColor;
  final Widget? icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(color: color, width: 7);
    return Container(
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: context.isLTR ? borderSide : BorderSide.none,
          right: context.isRTL ? borderSide : BorderSide.none,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        horizontalTitleGap: 7.0,
        minVerticalPadding: 0,
        minLeadingWidth: 0,
        visualDensity: const VisualDensity(vertical: -3),
        dense: true,
        titleAlignment: ListTileTitleAlignment.center,
        title: Text(message, style: TextStyle(color: textColor)),
        leading: icon,
      ),
    );
  }
}
