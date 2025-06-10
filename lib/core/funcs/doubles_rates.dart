double truncateToFirstDecimal(double number) {
  number = number.abs(); // لو عايز تتعامل مع أرقام سالبة بشكل موجب
  int wholePart = number.floor();
  int firstDecimalDigit = ((number - wholePart) * 10).floor();
  return wholePart + firstDecimalDigit / 10.0;
}
