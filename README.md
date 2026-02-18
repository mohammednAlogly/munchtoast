# MunchToast 🍞

[![pub package](https://img.shields.io/pub/v/munchtoast.svg)](https://pub.dev/packages/munchtoast)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A modern, highly customizable toast/snackbar notification widget for Flutter, perfect for e-commerce applications. MunchToast provides beautiful animations, flexible styling, and a queue system for managing multiple notifications.

![MunchToast Demo](https://github.com/mohammednAlogly/munchtoast/raw/main/gifs/first.gif)

![MunchToast Position Selector](https://github.com/mohammednAlogly/munchtoast/raw/main/gifs/secound.gif)

## ✨ Features

- 🎨 **5 Pre-built Toast Types**: Success, Error, Info, Warning, and Custom
- 📍 **Flexible Positioning**: Top, Bottom (default), or Center - with interactive example app selector
- 🎭 **Smooth Animations**: Slide, fade, and scale effects with configurable curves
- 🛍️ **E-commerce Ready**: Action buttons, icons, and rich text support
- 📦 **Queue System**: Automatically manages multiple toasts
- 👆 **Swipe to Dismiss**: Gesture support for easy dismissal
- 🎯 **Zero Dependencies**: Built with Flutter SDK only
- 🌙 **Dark Mode Support**: Automatically adapts to theme
- ♿ **Accessible**: Screen reader support and semantic labels
- 🎨 **Highly Customizable**: Colors, gradients, borders, padding, and more

## 📦 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  munchtoast: ^0.1.0
```

Then run:

```bash
flutter pub get
```

## 🚀 Quick Start

### Basic Usage

```dart
import 'package:munchtoast/munchtoast.dart';

// Simple success toast (appears at bottom by default)
MunchToast.success(
  context,
  message: 'Order placed successfully!',
);

// Error toast with action button
MunchToast.error(
  context,
  message: 'Payment failed. Please try again.',
  action: MunchToastAction(
    label: 'Retry',
    onPressed: () => _retryPayment(),
  ),
);

// Toast at top position
MunchToast.info(
  context,
  message: 'New products available!',
  position: MunchToastPosition.top,
);
```

**💡 Tip:** Try the example app to interactively test different positions with the built-in selector!

### Advanced Usage

```dart
MunchToast.show(
  context,
  message: 'Product added to cart',
  type: MunchToastType.success,
  position: MunchToastPosition.bottom,
  duration: Duration(seconds: 3),
  icon: Icons.shopping_cart,
  action: MunchToastAction(
    label: 'View Cart',
    onPressed: () => Navigator.pushNamed(context, '/cart'),
  ),
  backgroundColor: Colors.green.shade600,
  borderRadius: 12.0,
  elevation: 6.0,
);
```

## 🛍️ E-commerce Examples

### 1. Add to Cart Confirmation

```dart
MunchToast.show(
  context,
  message: '${product.name} added to cart',
  type: MunchToastType.success,
  icon: Icons.check_circle,
  action: MunchToastAction(
    label: '🛒 Cart (${cart.totalItems})',
    onPressed: _openCart,
  ),
);
```

### 2. Price Drop Alert

```dart
MunchToast.info(
  context,
  message: '${product.name} is now 30% off!',
  icon: Icons.local_offer,
  duration: Duration(seconds: 5),
  position: MunchToastPosition.top,  // Top position for alerts
);
```

**💡 Pro Tip:** Use top position for time-sensitive alerts like price drops, flash sales, or important notifications that users shouldn't miss.

### 3. Out of Stock Warning

```dart
MunchToast.warning(
  context,
  message: '${product.name} is out of stock',
  icon: Icons.inventory,
  action: MunchToastAction(
    label: 'Notify me',
    onPressed: _setupBackInStockAlert,
  ),
);
```

### 4. Limited Time Offer

```dart
MunchToast.show(
  context,
  message: '🔥 Flash sale ends in 2 hours!',
  type: MunchToastType.custom,
  backgroundColor: Colors.deepPurple,
  gradient: LinearGradient(
    colors: [Colors.purple, Colors.pink],
  ),
  icon: Icons.timer,
  duration: Duration(seconds: 8),
);
```

### 5. Order Tracking Update

```dart
MunchToast.success(
  context,
  message: 'Your order #1234 has been shipped',
  icon: Icons.local_shipping,
  action: MunchToastAction(
    label: 'Track',
    onPressed: _openTracking,
  ),
);
```

## 📚 API Reference

### MunchToast Methods

#### `MunchToast.show()`

Display a toast with full customization options.

**Parameters:**
- `context` (required): BuildContext
- `message` (required): String - The message to display
- `type`: MunchToastType - Toast type (default: `MunchToastType.info`)
- `position`: MunchToastPosition - Position (default: `MunchToastPosition.bottom`)
- `duration`: Duration - Auto-dismiss duration (default: 3 seconds)
- `action`: MunchToastAction? - Optional action button
- `icon`: IconData? - Optional leading icon
- `iconColor`: Color? - Icon color
- `backgroundColor`: Color? - Background color (overrides type defaults)
- `gradient`: Gradient? - Gradient background (overrides backgroundColor)
- `borderRadius`: double - Border radius (default: 12.0)
- `elevation`: double - Shadow elevation (default: 6.0)
- `onDismiss`: VoidCallback? - Callback when toast is dismissed
- `persistent`: bool - Require manual dismiss (default: false)
- `textStyle`: TextStyle? - Custom text style
- `padding`: EdgeInsets? - Custom padding
- `margin`: EdgeInsets? - Custom margin
- `offset`: Offset? - Custom position offset
- `animationCurve`: Curve - Animation curve (default: Curves.easeOut)
- `enableSwipeToDismiss`: bool - Enable swipe gesture (default: true)
- `customWidget`: Widget? - Custom widget instead of default content

#### `MunchToast.success()`

Shorthand for success toasts.

#### `MunchToast.error()`

Shorthand for error toasts.

#### `MunchToast.info()`

Shorthand for info toasts.

#### `MunchToast.warning()`

Shorthand for warning toasts.

#### `MunchToast.dismissAll()`

Dismiss all active toasts for a context.

### MunchToastType Enum

- `success` - Green theme for successful operations
- `error` - Red theme for errors/warnings
- `info` - Blue theme for informational messages
- `warning` - Orange theme for cautionary messages
- `custom` - Full control over colors and styling

### MunchToastPosition Enum

- `top` - Top of the screen (great for alerts and important notifications)
- `bottom` - Bottom of the screen (default, ideal for confirmations and actions)
- `center` - Center of the screen (perfect for modal-style notifications)

**Best Practices:**
- Use **top** for alerts, warnings, and time-sensitive information
- Use **bottom** for confirmations, success messages, and action feedback
- Use **center** for critical messages that require immediate attention

### MunchToastAction Class

```dart
MunchToastAction(
  label: 'Action',           // Required: Button label
  onPressed: () {},          // Required: Callback function
  textStyle: TextStyle(),    // Optional: Custom text style
  backgroundColor: Color(),  // Optional: Button background
  foregroundColor: Color(),  // Optional: Button text color
)
```

## 🎨 Customization Guide

### Position Selection

Choose where toasts appear on screen:

```dart
// Top position - slides down from top
MunchToast.success(
  context,
  message: 'Notification from top',
  position: MunchToastPosition.top,
);

// Bottom position - slides up from bottom (default)
MunchToast.success(
  context,
  message: 'Notification from bottom',
  position: MunchToastPosition.bottom,
);

// Center position - appears in center
MunchToast.info(
  context,
  message: 'Centered notification',
  position: MunchToastPosition.center,
);
```

**Tip:** Use top position for important alerts that shouldn't be missed, bottom for confirmations and actions.

### Custom Colors

```dart
MunchToast.show(
  context,
  message: 'Custom colored toast',
  backgroundColor: Colors.purple.shade700,
  iconColor: Colors.white,
);
```

### Gradient Backgrounds

```dart
MunchToast.show(
  context,
  message: 'Gradient toast',
  gradient: LinearGradient(
    colors: [Colors.blue, Colors.purple],
  ),
);
```

### Custom Borders

```dart
MunchToast.show(
  context,
  message: 'Bordered toast',
  border: Border.all(
    color: Colors.blue,
    width: 2,
  ),
);
```

### Persistent Toasts

```dart
MunchToast.show(
  context,
  message: 'Important message',
  persistent: true,  // Requires manual dismiss
  duration: Duration(seconds: 10),  // Max duration before auto-dismiss
);
```

## 🧪 Testing

Run tests with:

```bash
flutter test
```

## 📱 Example App

Check out the complete example app in the `/example` directory with 9+ e-commerce scenarios and an **interactive position selector**:

![Example App Demo](https://github.com/mohammednAlogly/munchtoast/raw/main/gifs/first.gif)

### 🎯 Interactive Features

- **📍 Position Selector**: Choose between Top and Bottom positions with a segmented button
- **🔄 Real-time Testing**: See how toasts adapt to your position preference instantly
- **📱 Live Examples**: All toast types respect your position selection (except Flash Sale & Price Drop which always use top)

### Example Scenarios

- 🛍️ Add to cart confirmation
- 💳 Payment success
- 📦 Order shipped notifications
- 🔥 Flash sale alerts (always top)
- ⚠️ Low stock warnings
- ❌ Payment failures
- 💰 Price drop alerts (always top)
- 📱 Out of stock notifications
- 🎁 Limited time offers

### Running the Example

```bash
cd example
flutter run
```

**Try it out:**
1. Open the example app
2. Use the **Toast Position** selector at the top
3. Switch between **Top** and **Bottom**
4. Tap any example card to see toasts appear at your selected position!

## 🤝 Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with ❤️ for the Flutter community
- Inspired by modern e-commerce notification patterns
- Designed with accessibility and performance in mind

## 📞 Support

- 📖 [Documentation](https://pub.dev/documentation/munchtoast)
- 🐛 [Report Issues](#) <!-- Add your issue tracker URL -->
- 💬 [Discussions](#) <!-- Add your discussions URL -->

---

Made with 🍞 by the MunchToast team
