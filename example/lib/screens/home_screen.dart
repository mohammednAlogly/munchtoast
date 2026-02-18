import 'package:flutter/material.dart';
import 'package:munchtoast/munchtoast.dart';
import 'product_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _cartItemCount = 0;
  final String _productName = "Wireless Headphones Pro";
  final double _productPrice = 99.99;
  final double _discountedPrice = 69.99;
  MunchToastPosition _toastPosition = MunchToastPosition.bottom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MunchToast Demo'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartScreen()),
                  );
                },
              ),
              if (_cartItemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$_cartItemCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'MunchToast Examples',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'E-commerce toast notifications with customizable positions',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose toast position above, then tap any card below to see different toast notifications',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 24),
          // Toast Position Selector
          Card(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.vertical_align_center,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Toast Position',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Choose where toasts appear on screen',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SegmentedButton<MunchToastPosition>(
                    segments: const [
                      ButtonSegment<MunchToastPosition>(
                        value: MunchToastPosition.top,
                        label: Text('Top'),
                        icon: Icon(Icons.arrow_upward, size: 18),
                      ),
                      ButtonSegment<MunchToastPosition>(
                        value: MunchToastPosition.bottom,
                        label: Text('Bottom'),
                        icon: Icon(Icons.arrow_downward, size: 18),
                      ),
                    ],
                    selected: {_toastPosition},
                    onSelectionChanged: (Set<MunchToastPosition> newSelection) {
                      setState(() {
                        _toastPosition = newSelection.first;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Most toasts respect this setting. Flash Sale and Price Drop always appear at top.',
                            style: TextStyle(
                              fontSize: 11,
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildExampleCard(
            title: '🛍️ Add to Cart',
            description: 'Success toast with action button',
            onTap: _showAddToCartToast,
            color: Colors.green,
          ),
          _buildExampleCard(
            title: '💳 Payment Success',
            description: 'Success notification',
            onTap: _showPaymentSuccessToast,
            color: Colors.green,
          ),
          _buildExampleCard(
            title: '📦 Order Shipped',
            description: 'Info toast with tracking action',
            onTap: _showOrderShippedToast,
            color: Colors.blue,
          ),
          _buildExampleCard(
            title: '🔥 Flash Sale',
            description: 'Custom gradient toast (always top)',
            onTap: _showFlashSaleToast,
            color: Colors.purple,
          ),
          _buildExampleCard(
            title: '⚠️ Low Stock Alert',
            description: 'Warning toast with action',
            onTap: _showLowStockToast,
            color: Colors.orange,
          ),
          _buildExampleCard(
            title: '❌ Payment Failed',
            description: 'Error toast with retry action',
            onTap: _showPaymentFailedToast,
            color: Colors.red,
          ),
          _buildExampleCard(
            title: '💰 Price Drop Alert',
            description: 'Info toast (always top)',
            onTap: _showPriceDropToast,
            color: Colors.blue,
          ),
          _buildExampleCard(
            title: '📱 Out of Stock',
            description: 'Warning with notify action',
            onTap: _showOutOfStockToast,
            color: Colors.orange,
          ),
          _buildExampleCard(
            title: '🎁 Limited Time Offer',
            description: 'Persistent toast (manual dismiss)',
            onTap: _showLimitedTimeOfferToast,
            color: Colors.deepPurple,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductScreen(
                    productName: _productName,
                    price: _productPrice,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.shopping_bag),
            label: const Text('View Product Screen'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleCard({
    required String title,
    required String description,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.2),
          child: Icon(Icons.notifications, color: color),
        ),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showAddToCartToast() {
    setState(() {
      _cartItemCount++;
    });
    MunchToast.show(
      context,
      message: '$_productName added to cart',
      type: MunchToastType.success,
      position: _toastPosition,
      icon: Icons.check_circle,
      action: MunchToastAction(
        label: '🛒 Cart ($_cartItemCount)',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CartScreen()),
          );
        },
      ),
    );
  }

  void _showPaymentSuccessToast() {
    MunchToast.success(
      context,
      message: 'Payment successful! Order #1234 confirmed',
      position: _toastPosition,
      icon: Icons.payment,
      duration: const Duration(seconds: 4),
    );
  }

  void _showOrderShippedToast() {
    MunchToast.info(
      context,
      message: 'Your order #1234 has been shipped',
      position: _toastPosition,
      icon: Icons.local_shipping,
      action: MunchToastAction(
        label: 'Track',
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tracking page would open here')),
          );
        },
      ),
    );
  }

  void _showFlashSaleToast() {
    MunchToast.show(
      context,
      message: '🔥 Flash sale ends in 2 hours!',
      type: MunchToastType.custom,
      backgroundColor: Colors.deepPurple,
      gradient: const LinearGradient(
        colors: [Colors.purple, Colors.pink],
      ),
      icon: Icons.timer,
      duration: const Duration(seconds: 5),
      position: MunchToastPosition.top,
    );
  }

  void _showLowStockToast() {
    MunchToast.warning(
      context,
      message: 'Only 3 items left in stock!',
      position: _toastPosition,
      icon: Icons.inventory,
      action: MunchToastAction(
        label: 'Buy Now',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductScreen(
                productName: _productName,
                price: _productPrice,
              ),
            ),
          );
        },
      ),
    );
  }

  void _showPaymentFailedToast() {
    MunchToast.error(
      context,
      message: 'Payment failed. Please try again.',
      position: _toastPosition,
      icon: Icons.error_outline,
      action: MunchToastAction(
        label: 'Retry',
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Retrying payment...')),
          );
        },
      ),
    );
  }

  void _showPriceDropToast() {
    final discount = ((_productPrice - _discountedPrice) / _productPrice * 100)
        .toStringAsFixed(0);
    MunchToast.info(
      context,
      message: '$_productName is now $discount% off!',
      icon: Icons.local_offer,
      duration: const Duration(seconds: 5),
      position: MunchToastPosition.top,
    );
  }

  void _showOutOfStockToast() {
    MunchToast.warning(
      context,
      message: '$_productName is out of stock',
      position: _toastPosition,
      icon: Icons.inventory_2,
      action: MunchToastAction(
        label: 'Notify Me',
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('You will be notified when back in stock')),
          );
        },
      ),
    );
  }

  void _showLimitedTimeOfferToast() {
    MunchToast.show(
      context,
      message: '🎁 Limited time offer: Free shipping on orders over \$50!',
      type: MunchToastType.custom,
      position: _toastPosition,
      backgroundColor: Colors.deepPurple.shade600,
      icon: Icons.card_giftcard,
      persistent: true,
      duration: const Duration(seconds: 10),
    );
  }
}
