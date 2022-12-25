import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({
    Key? key,
    required this.currency,
    required this.currencySymbol,
    required this.currencyName,
    required this.currencyValue,
    required this.bgColor,
    required this.textColor,
    this.offset = Offset.zero,
  }) : super(key: key);

  const CurrencyCard.normal({
    Key? key,
    required this.currency,
    required this.currencySymbol,
    required this.currencyName,
    required this.currencyValue,
    this.offset = Offset.zero,
  })  : bgColor = const Color(0xFF1F2123),
        textColor = Colors.white,
        super(key: key);

  const CurrencyCard.inverse({
    Key? key,
    required this.currency,
    required this.currencySymbol,
    required this.currencyName,
    required this.currencyValue,
    this.offset = Offset.zero,
  })  : bgColor = Colors.white,
        textColor = Colors.black87,
        super(key: key);

  /// currency ex : EUR, USD, GBP
  final String currency;

  /// currency symbol ex : Icons.euro_rounded, Icons.attach_money, Icons.currency_pound_outlined
  final IconData currencySymbol;

  /// currency name ex : Euro, Dollar, Pound
  final String currencyName;

  final String currencyValue;
  final Color bgColor;
  final Color textColor;

  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offset,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currencyName,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      currencyValue,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      currency,
                      style: TextStyle(
                        color: textColor.withOpacity(0.7),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Transform.scale(
              scale: 2.2,
              child: Transform.translate(
                offset: const Offset(-3, 8),
                child: Transform(
                  transform: Matrix4.identity()..rotateZ(-0.1),
                  child: Icon(
                    currencySymbol,
                    color: textColor,
                    size: 52,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
