

enum PaymentMethods {
  CASH("Tunai", "public/assets/images/pembayaran.png"),
  QRIS("QRIS", "public/assets/images/qris.png");

  const PaymentMethods(this.value, this.assetPath);

  final String value;
  final String assetPath;
}
