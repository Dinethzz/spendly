import 'dart:ui';

enum ExpenceCategories {
  food,
  transport,
  health,
  shopping,
  subscription,
}

//category images
final Map<ExpenceCategories, String> expenceCategoryImages = {
  ExpenceCategories.food: "assets/images/food.png",
  ExpenceCategories.transport: "assets/images/transport.png",
  ExpenceCategories.health: "assets/images/health.png",
  ExpenceCategories.shopping: "assets/images/shopping.png",
  ExpenceCategories.subscription: "assets/images/subscription.png",
};
//category colors
final Map<ExpenceCategories, Color> expenceCategoryColors = {
  ExpenceCategories.food: const Color(0xFFFFC107), // Yellow
  ExpenceCategories.transport: const Color(0xFF2196F3), // Blue
  ExpenceCategories.health: const Color(0xFF4CAF50), // Green
  ExpenceCategories.shopping: const Color(0xFFF44336), // Red
  ExpenceCategories.subscription: const Color(0xFF9C27B0), // Purple
};


class Expence{
  final int id;
  final String title;
  final double amount;
  final ExpenceCategories category;
  final DateTime date;
  final DateTime time;
  final String description;

  Expence({required this.id, required this.title, required this.amount, required this.category, required this.date, required this.time, required this.description});

//convert expence object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category.index, 
      'date': date.toIso8601String(),
      'time': time.toIso8601String(),
      'description': description,
    };
  }

//create an expence object from a JSON object
  factory Expence.fromJson(Map<String, dynamic> json) {
    return Expence(
      id: json['id'],
      title: json['title'],
      amount: json['amount'].toDouble(),
      category: ExpenceCategories.values[json['category']],
      date: DateTime.parse(json['date']),
      time: DateTime.parse(json['time']),
      description: json['description'],
    );
  }
}