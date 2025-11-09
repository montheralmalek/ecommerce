import 'package:flutter/material.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';

@Deprecated('Use [GlobalErrorWidget] instead')
class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        // width: context.width * 0.8,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 7.0,
            children: [
              Icon(
                Icons.error_outline,
                color: context.colorScheme.error,
                size: 50,
              ),

              Text(
                message,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge,
                // overflow: TextOverflow.ellipsis,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       FilledButton(
              //         onPressed: () {},
              //         child: const Text('Ok'),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class GlobalErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final String retryText;

  const GlobalErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.retryText = 'retry',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: context.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Please try again later',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: context.theme.hintColor),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(onPressed: onRetry, child: Text(retryText)),
            ],
          ],
        ),
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  final String message;

  const ErrorScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlobalErrorWidget(
        message: message,
        onRetry: () {
          // You might want to restart the app or navigate to home
        },
      ),
    );
  }
}
