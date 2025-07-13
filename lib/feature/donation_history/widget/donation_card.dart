import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/donation_history/model/history_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DonationHistoryCard extends StatelessWidget {
  final HistoryModel donation;

  const DonationHistoryCard({super.key, required this.donation});

  @override
  Widget build(BuildContext context) {

        // ignore: non_constant_identifier_names
        final ColorScheme=context.colorScheme;
    final isDark = context.isDarkMode;
    final formatter = NumberFormat('#,###');
    final dateFormat = DateFormat('d/M/yyyy');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color:isDark ? Colors.grey[850] :  Colors.grey[100],

        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  donation.type,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.5,
                  ),
                ),
              ),
              Text(
                dateFormat.format(donation.date),
                style: TextStyle(
                  color: ColorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.account_balance_wallet_outlined,
                size: 18,
                color: ColorScheme.secondary,
              ),
              const SizedBox(width: 6),
              Text(
                'المبلغ المتبرع فيه: ${formatter.format(donation.amount)}\$',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
