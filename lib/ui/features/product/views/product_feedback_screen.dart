import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import 'package:store/ui/features/product/widgets/rating_bar.dart';

class ProductFeedbackScreen extends StatefulWidget {
  const ProductFeedbackScreen({super.key});

  @override
  State<ProductFeedbackScreen> createState() => _ProductFeedbackScreenState();
}

class _ProductFeedbackScreenState extends State<ProductFeedbackScreen> {
  double _rating = 0.0;
  final TextEditingController _feedbackController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _submitRating() {
    if (_rating == 0) {
      //(_rating == 0) {
      // ScaffoldMessenger.of(
      //   context,
      // ).showSnackBar(const SnackBar(content: Text('Please select a rating')));
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // Simulate API call
    setState(() {
      _isSubmitting = false;
    });

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(
    //       'Thanks for your ${_ratingStar?.getRating} star rating!',
    //     ),
    //     duration: const Duration(seconds: 2),
    //   ),
    // );

    // Clear the form
    _feedbackController.clear();
    setState(() {
      _rating = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(title: const Text('Rate Us')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text(
              'How would you rate your experience?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            RatingBar(
              rateValue: _rating,
              minRating: 1,
              itemCount: 5,
              itemSize: 42,
              spacing: 16.0,
              itemBuilder: (context, _) => const Icon(Icons.star_rate_rounded),
              onRatingUpdate: (rating) {
                setState(() {
                  // _ratingStar = RatingStar.getRatingStar(rating.toInt());
                  _rating = rating;
                });
              },
            ),
            const SizedBox(height: 30),
            _rating == 0
                ? Text(
                  'Tap a star to rate',
                  style: TextStyle(
                    fontSize: 16,
                    color: context.colorScheme.error,
                  ),
                )
                : _buildRatingImoge(_rating.toInt()),

            const SizedBox(height: 40),
            TextField(
              controller: _feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Optional feedback',
                hintText: 'Tell us what you liked or how we can improve...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitRating,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child:
                    _isSubmitting
                        ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                        : const Text(
                          'Submit Rating',
                          style: TextStyle(fontSize: 16),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingImoge(int rate) {
    const double size = 50;
    switch (rate) {
      case 1:
        return const Icon(
          Icons.sentiment_very_dissatisfied,
          size: size,
          color: Colors.red,
        );
      case 2:
        return const Icon(
          Icons.sentiment_dissatisfied,
          size: size,
          color: Colors.redAccent,
        );
      case 3:
        return const Icon(
          Icons.sentiment_neutral,
          size: size,
          color: Colors.amber,
        );
      case 4:
        return const Icon(
          Icons.sentiment_satisfied,
          size: size,
          color: Colors.lightGreen,
        );
      case 5:
        return const Icon(
          Icons.sentiment_very_satisfied,
          size: size,
          color: Colors.green,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
