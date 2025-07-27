import 'dart:ui';

enum IncomeCategory{
  freelance,
  salary,
  passive,
  sales,
}

//category images
final Map<IncomeCategory, String> incomeCategoryImages = {
  IncomeCategory.freelance: "assets/images/freelance.png",
  IncomeCategory.salary: "assets/images/salary.png",
  IncomeCategory.passive: "assets/images/passive.png",
  IncomeCategory.sales: "assets/images/sales.png",
};

//category colors
final Map<IncomeCategory, Color> incomeCategoryColors = {
  IncomeCategory.freelance: const Color(0xFF4CAF50), // Green
  IncomeCategory.salary: const Color(0xFF2196F3), // Blue
  IncomeCategory.passive: const Color(0xFFFFC107), // Yellow
  IncomeCategory.sales: const Color(0xFFF44336), // Red
};

class Income{
  final int id;
  final String title;
  final double amount;
  final IncomeCategory category;
  final DateTime date;
  final DateTime time;
  final String description;

  Income({required this.id, required this.title, required this.amount, required this.category, required this.date, required this.time, required this.description});

}