import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/const_values.dart';
import 'package:expenz/models/expence_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WalletScreen extends StatefulWidget {
  final List<Expence> expencesList;
  final List<Income> incomesList;

  const WalletScreen({
    super.key,
    required this.expencesList,
    required this.incomesList,
  });

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    // Calculate totals
    double totalIncome = widget.incomesList.fold(0.0, (sum, income) => sum + income.amount);
    double totalExpenses = widget.expencesList.fold(0.0, (sum, expense) => sum + expense.amount);
    double currentBalance = totalIncome - totalExpenses;

    // Calculate this month's data
    DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    
    double monthlyIncome = widget.incomesList
        .where((income) => income.date.isAfter(startOfMonth.subtract(const Duration(days: 1))))
        .fold(0.0, (sum, income) => sum + income.amount);
    
    double monthlyExpenses = widget.expencesList
        .where((expense) => expense.date.isAfter(startOfMonth.subtract(const Duration(days: 1))))
        .fold(0.0, (sum, expense) => sum + expense.amount);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Wallet',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: kBlack,
          ),
        ),
        backgroundColor: kWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kBlack),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Balance Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [kMainColor, kMainColor.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: kMainColor.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Balance',
                      style: TextStyle(
                        color: kWhite.withOpacity(0.8),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${currentBalance.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: kWhite,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Income',
                              style: TextStyle(
                                color: kWhite.withOpacity(0.8),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '+\$${totalIncome.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: kWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Total Expenses',
                              style: TextStyle(
                                color: kWhite.withOpacity(0.8),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '-\$${totalExpenses.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: kWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Monthly Overview
              const Text(
                'This Month',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kBlack,
                ),
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Income',
                      monthlyIncome,
                      kGreen,
                      Icons.trending_up,
                      isIncome: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      'Expenses',
                      monthlyExpenses,
                      kRed,
                      Icons.trending_down,
                      isIncome: false,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 30),
              
              // Quick Stats
              const Text(
                'Quick Stats',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kBlack,
                ),
              ),
              const SizedBox(height: 16),
              
              _buildQuickStatsCard('Total Transactions', 
                  (widget.expencesList.length + widget.incomesList.length).toString(), 
                  Icons.receipt_long),
              
              _buildQuickStatsCard('Average Daily Expense', 
                  monthlyExpenses > 0 ? '\$${(monthlyExpenses / DateTime.now().day).toStringAsFixed(2)}' : '\$0.00', 
                  Icons.calendar_today),
              
              _buildQuickStatsCard('Last Transaction', 
                  _getLastTransactionDate(), 
                  Icons.schedule),
                  
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, double amount, Color color, IconData icon, {required bool isIncome}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: kGrey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isIncome ? Icons.arrow_upward : Icons.arrow_downward,
                  color: color,
                  size: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: kGrey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${isIncome ? '+' : '-'}\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatsCard(String title, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: kGrey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kMainColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: kMainColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: kGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: kBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getLastTransactionDate() {
    if (widget.expencesList.isEmpty && widget.incomesList.isEmpty) {
      return 'No transactions';
    }

    DateTime lastDate = DateTime(2000);
    
    if (widget.expencesList.isNotEmpty) {
      final lastExpense = widget.expencesList.reduce((a, b) => a.date.isAfter(b.date) ? a : b);
      if (lastExpense.date.isAfter(lastDate)) {
        lastDate = lastExpense.date;
      }
    }
    
    if (widget.incomesList.isNotEmpty) {
      final lastIncome = widget.incomesList.reduce((a, b) => a.date.isAfter(b.date) ? a : b);
      if (lastIncome.date.isAfter(lastDate)) {
        lastDate = lastIncome.date;
      }
    }

    if (lastDate.year == 2000) return 'No transactions';
    
    final now = DateTime.now();
    final difference = now.difference(lastDate).inDays;
    
    if (difference == 0) return 'Today';
    if (difference == 1) return 'Yesterday';
    if (difference < 7) return '$difference days ago';
    
    return DateFormat('MMM dd, yyyy').format(lastDate);
  }
}
