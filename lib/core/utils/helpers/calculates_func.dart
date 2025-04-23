/// Function to calculate the percentage of a value
/// [value] is the value to calculate the percentage of
/// [total] is the total value
double calculatePercentage(double value, double total) {
  if (total == 0) {
    return 0;
  }
  return (value / total) * 100;
}

/// Function to calculate the discount price
/// [price] is the original price
/// [discount] is the discount percentage
double calculateDiscountPrice(double price, double discount) {
  return price - (price * (discount / 100));
}
