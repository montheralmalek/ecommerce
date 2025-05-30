import 'package:flutter/material.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: context.width * 0.8,
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
                'An Error Occurred',
                style: context.textTheme.titleLarge!.copyWith(
                  color: context.colorScheme.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                message,

                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge,
                overflow: TextOverflow.ellipsis,
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
