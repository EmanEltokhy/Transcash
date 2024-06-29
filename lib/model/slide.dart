
class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/images/money-icon.png',
    title: 'Easy Payments',
    description: 'Make quick and secure payments with just a few taps on your device.',
  ),
  Slide(
    imageUrl: 'assets/images/mobile-icon.png',
    title: 'Mobile Wallet',
    description: 'Store and manage your funds in a digital wallet for easy access anytime.',
  ),
  Slide(
    imageUrl: 'assets/images/lock-icon.png',
    title: 'Secure Transactions',
    description: 'Enjoy peace of mind with our robust security measures to protect your financial information.',
  ),
];
