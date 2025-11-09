import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import 'package:store/core/widgets/hint_box.dart';
import 'package:store/core/widgets/widgets.dart';
import 'package:store/domain/entities/product/product.dart';
import 'package:store/domain/entities/product/product_listing.dart';
import 'package:store/domain/entities/product/product_pricing.dart';
import 'package:store/routing/routes.dart';
import 'package:store/ui/widgets/default_cupertino_navigation_bar_data.dart';

class DevelopmentView extends StatefulWidget {
  const DevelopmentView({super.key});

  @override
  State<DevelopmentView> createState() => _DevelopmentViewState();
}

class _DevelopmentViewState extends State<DevelopmentView> {
  late Product a;
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Development View'),
        cupertino:
            (context, platform) => defaultCupertinoNavigationBarData(context),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: 10,
                // mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomButton(
                    label: 'Test rout error',
                    onPressed: () {
                      context.push('/name');
                    },
                  ),
                  const SizedBox(height: 20.0),
                  // // a.brand != null
                  //     ? SizedBox()
                  //     : throw Exception('Test build error'),
                  GlobalErrorWidget(
                    message:
                        'Global Error Widget Global Error Widget Global Error Widget Global Error Widget Global Error Widget Global Error Widget ',
                    onRetry: () {},
                  ),
                  CustomErrorWidget(
                    message:
                        'Custom Error WidgetCustom Error Widget Custom Error Widget Custom Error Widget Custom Error WidgetCustom Error Widget Custom Error Widget Custom Error Widget ',
                  ),
                  HintBox(
                    hintBoxType: HintBoxType.info,
                    hintText:
                        'The following _TypeError was thrown building HintBox(state: _HintBoxState#2d0e4): Null check operator used on a null value',
                  ),

                  // ...products.map(
                  //   (product) => Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: SizedBox(
                  //       width: 300,
                  //       child: ProductCard(product: product),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///
/// Development view button
class GoToDevelopmentViewButton extends StatelessWidget {
  const GoToDevelopmentViewButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformIconButton(
      padding: EdgeInsets.zero,
      icon: Icon(context.platformIcons.info),
      onPressed: () {
        context.push(AppRoutes.developmentView);
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductListing product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة المنتج مع البادجات
          _buildImageSection(product),

          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الاسم والوصف
                _buildProductInfo(product),
                SizedBox(height: 8),

                // السعر
                _buildPricingSection(product),
                SizedBox(height: 8),

                // التقييم والتوفر
                _buildFooterSection(product),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildImageSection(ProductListing product) {
    return Stack(
      children: [
        Image.network(
          product.image,
          height: 150,
          width: double.infinity,
          fit: BoxFit.cover,
        ),

        // البادجات
        Positioned(
          top: 8,
          left: 8,
          child: Row(
            children: [
              if (product.availability.stockStatus == StockStatus.outOfStock)
                _buildBadge('Out of stock', Colors.red),
              if (product.isLowStock)
                _buildBadge('Last in stock', Colors.orange),
              if (product.tags.contains('new'))
                _buildBadge('New', Colors.green),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _buildBadge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      margin: EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Widget _buildProductInfo(ProductListing product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4),
        Text(
          product.description,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  static Widget _buildPricingSection(ProductListing product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (product.hasDiscount)
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              if (!product.isRangePrice)
                Text(
                  '${product.pricing.originalPrice} ${product.pricing.currency}',
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              _buildBadge(
                '${product.isRangePrice ? 'Up to ' : ''}'
                '${product.pricing.discountPercentage}% OFF',
                Colors.red,
              ),
            ],
          ),

        Row(
          children: [
            Text(
              product.displayPrice,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: product.hasDiscount ? Colors.red : Colors.black,
              ),
            ),

            if (product.isRangePrice)
              Padding(
                padding: EdgeInsets.only(left: 4),
                child: Icon(Icons.info_outline, size: 14, color: Colors.grey),
              ),
          ],
        ),

        if (product.isRangePrice)
          Text(
            'السعر يختلف حسب المواصفات',
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
      ],
    );
  }

  Widget _buildFooterSection(ProductListing product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // التقييم
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 16),
            SizedBox(width: 4),
            Text(
              '${product.rating.rateValue} (${product.rating.count})',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(width: 8),
            // زر الذهاب للتفاصيل الذكي
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue[500],
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                _getActionText(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        // حالة التوفر
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: _getAvailabilityColor(product.availability),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            _getAvailabilityText(product.availability),
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  String _getActionText() {
    if (product.isRangePrice) {
      return 'اختر المواصفات';
    } else if (product.pricing.variantId != null) {
      return 'تعديل المواصفات';
    } else {
      return 'اضف للسلة';
    }
  }

  static Color _getAvailabilityColor(ProductAvailability availability) {
    if (!availability.isAvailable) return Colors.grey;
    switch (availability.stockStatus) {
      case StockStatus.lowStock:
        return Colors.orange;
      case StockStatus.outOfStock:
        return Colors.red;
      default:
        return Colors.green;
    }
  }

  static String _getAvailabilityText(ProductAvailability availability) {
    if (!availability.isAvailable) return 'غير متوفر';
    switch (availability.stockStatus) {
      case StockStatus.lowStock:
        return 'آخر قطعة';
      case StockStatus.outOfStock:
        return 'نفذت الكمية';
      default:
        return 'متوفر';
    }
  }
}
/////===========

/// مثال منتج للاختبار
List<ProductListing> get products => [
  ProductListing(
    id: 1,
    name: 'قميص رجالي أنيق',
    description: 'قميص رجالي عالي الجودة مناسب لجميع المناسبات.',
    image:
        'https://img.freepik.com/free-vector/paper-style-podium-horizontal-banner_23-2150956911.jpg',
    category: 'clothing',
    pricing: ProductPricing(
      originalPrice: 150.0,
      finalPrice: 120.0,
      discountPercentage: 20,
      currency: 'SAR',
      hasVariation: true,
      range: PriceRange(min: 100.0, max: 200.0),
    ),
    rating: ProductRating(rateValue: 4.5, count: 120, distribution: []),
    availability: ProductAvailability(
      isAvailable: true,
      stockStatus: StockStatus.inStock,
      lowStockThreshold: 5,
    ),
    tags: ['new', 'summer'],
  ),
  ProductListing(
    id: 2,
    name: 'ساعة يد فاخرة',
    description: 'ساعة يد بتصميم عصري ومتانة عالية.',
    image:
        'https://img.freepik.com/free-vector/paper-style-podium-horizontal-banner_23-2150956911.jpg',
    category: 'accessories',
    pricing: ProductPricing(
      originalPrice: 300.0,
      finalPrice: 300.0,
      discountPercentage: 0,
      currency: 'SAR',
      hasVariation: false,
      range: null,
    ),
    rating: ProductRating(rateValue: 4.8, count: 85, distribution: []),
    availability: ProductAvailability(
      isAvailable: true,
      stockStatus: StockStatus.lowStock,
      lowStockThreshold: 5,
    ),
    tags: ['bestseller'],
  ),
  ProductListing(
    id: 3,
    name: 'حذاء رياضي مريح',
    description: 'حذاء رياضي بتقنية متقدمة للراحة والأداء.',
    image:
        'https://img.freepik.com/free-vector/paper-style-podium-horizontal-banner_23-2150956911.jpg',
    category: 'footwear',
    pricing: ProductPricing(
      originalPrice: 250.0,
      finalPrice: 200.0,
      discountPercentage: 15,
      currency: 'SAR',
      hasVariation: true,
      variantId: 'variant_123',
      range: null,
    ),
    rating: ProductRating(rateValue: 4.2, count: 60, distribution: []),
    availability: ProductAvailability(
      isAvailable: false,
      stockStatus: StockStatus.outOfStock,
      lowStockThreshold: 5,
    ),
    tags: ['sale'],
  ),
];
