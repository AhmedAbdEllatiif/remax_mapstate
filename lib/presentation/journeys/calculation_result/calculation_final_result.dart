import 'package:intl/intl.dart';

class CalculationFinalResult {
  final String initialDownPaymentResult;
  final String firstDownPaymentResult;
  final String secondDownPaymentResult;
  final String thirdDownPaymentResult;
  final String fourthDownPaymentResult;
  final String monthlyInstallment;
  final String quarterlyInstallment;

  const CalculationFinalResult({
    required this.initialDownPaymentResult,
    required this.firstDownPaymentResult,
    required this.secondDownPaymentResult,
    required this.thirdDownPaymentResult,
    required this.fourthDownPaymentResult,
    required this.monthlyInstallment,
    required this.quarterlyInstallment,
  });

  factory CalculationFinalResult.calculate({
    required double totalUnitPrice,
    required double initialDownPayment,
    required double numOfYears,
    required double firstDownPayment,
    required double secondDownPayment,
    required double thirdDownPayment,
    required double fourthDownPayment,
  }) {
    NumberFormat numberFormat = NumberFormat('##,###,000');

    ///==> initialDownPaymentResult = totalUnitPrice * initialDownPayment
    final initialDownPaymentResult =
        totalUnitPrice * (initialDownPayment / 100);

    /// ==>firstDownPaymentResult = totalUnitPrice * firstDownPayment
    final firstDownPaymentResult = totalUnitPrice * (firstDownPayment / 100);

    ///==> secondDownPaymentResult = totalUnitPrice * secondDownPayment
    final secondDownPaymentResult = totalUnitPrice * (secondDownPayment / 100);

    ///==> thirdDownPaymentResult = totalUnitPrice * thirdDownPayment
    final thirdDownPaymentResult = totalUnitPrice * (thirdDownPayment / 100);

    ///==> fourthDownPaymentResult
    final fourthDownPaymentResult = totalUnitPrice * (fourthDownPayment / 100);

    ///==> monthlyInstallment = totalUnitPrice - (initialDownPaymentResult + firstDownPaymentResult + secondDownPaymentResult + thirdDownPaymentResult) / (numOfYears * 12)
    final monthlyInstallment = (totalUnitPrice -
            (initialDownPaymentResult +
                firstDownPaymentResult +
                secondDownPaymentResult +
                thirdDownPaymentResult +
                fourthDownPaymentResult)) /
        (numOfYears * 12);

    ///==> quarterlyInstallment = monthlyInstallment * 3
    final quarterlyInstallment = monthlyInstallment * 3;

    /// result
    return CalculationFinalResult(
      initialDownPaymentResult: numberFormat.format(initialDownPaymentResult),
      firstDownPaymentResult: numberFormat.format(firstDownPaymentResult),
      secondDownPaymentResult: numberFormat.format(secondDownPaymentResult),
      thirdDownPaymentResult: numberFormat.format(thirdDownPaymentResult),
      fourthDownPaymentResult: numberFormat.format(fourthDownPaymentResult),
      monthlyInstallment: numberFormat.format(monthlyInstallment),
      quarterlyInstallment: numberFormat.format(quarterlyInstallment),
    );
  }
}
