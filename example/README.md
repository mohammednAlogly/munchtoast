# MunchToast Example App

This example app demonstrates various use cases of the MunchToast package in an e-commerce context.

## 🎯 Key Features

### Toast Position Selector
**NEW!** Choose where toasts appear on your screen:
- **Top Position** - Toasts slide down from the top
- **Bottom Position** - Toasts slide up from the bottom (default)

Use the segmented button at the top of the home screen to switch between positions and see how all toasts adapt to your preference!

## Features Demonstrated

1. **🛍️ Add to Cart** - Success toast with action button
2. **💳 Payment Success** - Simple success notification
3. **📦 Order Shipped** - Info toast with tracking action
4. **🔥 Flash Sale** - Custom gradient toast (always at top)
5. **⚠️ Low Stock Alert** - Warning toast with action
6. **❌ Payment Failed** - Error toast with retry action
7. **💰 Price Drop Alert** - Info toast (always at top)
8. **📱 Out of Stock** - Warning with notify action
9. **🎁 Limited Time Offer** - Persistent toast (manual dismiss)

## Running the Example

### Prerequisites
- Flutter SDK installed
- A device/emulator running or web browser

### Steps

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Run on device/emulator:**
   ```bash
   flutter run
   ```

3. **Run on web:**
   ```bash
   flutter run -d chrome
   ```

4. **Run on iOS Simulator:**
   ```bash
   flutter run -d ios
   ```

5. **Run on Android Emulator:**
   ```bash
   flutter run -d android
   ```

## Testing Different Toast Types

### Position Control
- **Use the position selector** at the top to switch between Top and Bottom
- All toasts (except Flash Sale and Price Drop) will respect your selection
- See how the same toast looks and animates differently at each position

### Toast Examples
- Tap any card on the home screen to see different toast notifications
- Navigate to "View Product Screen" to see toast in a product context
- Try adding items to cart to see the cart counter update
- Test swipe gestures to dismiss toasts (if enabled)
- Try the persistent toast - it requires manual dismissal

### Interactive Features
- **Action Buttons**: Tap action buttons in toasts to navigate or perform actions
- **Swipe to Dismiss**: Swipe left/right or up/down to dismiss toasts
- **Queue System**: Trigger multiple toasts quickly to see them queue automatically
- **Animations**: Watch smooth slide and fade animations based on position

## Screenshots

The app includes:
- **Home Screen**: Grid of toast examples
- **Product Screen**: Simulated product page with add to cart
- **Cart Screen**: Shopping cart view

Enjoy testing MunchToast! 🍞
