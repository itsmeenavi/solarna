import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For number formatting

class EarningsPage extends StatelessWidget {
  const EarningsPage({super.key});

  // Mock Data
  final double totalEarningsSOL = 15.78;
  final double recentEarningsSOL = 1.25;
  final int nftsDeployed = 3;

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,##0.00 SOL', 'en_US');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Earnings & Savings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Total Earnings',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.grey[700]),
            ),
            Text(
              numberFormat.format(totalEarningsSOL),
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              'Recent (Last 30 days): ${numberFormat.format(recentEarningsSOL)}',
               style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),

            Text(
              'Activity Overview',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.grey[700]),
            ),
             const SizedBox(height: 15),
             _buildInfoCard(context, Icons.developer_board, '$nftsDeployed NFTs Deployed', 'Generating passive income'),
             const SizedBox(height: 10),
            _buildInfoCard(context, Icons.trending_up, 'Marketplace Trend: Positive', 'Based on recent activity'),
            const SizedBox(height: 30),

            // Placeholder for a chart
            Text(
              'Earnings Trend (Placeholder)',
               style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(8),
                 border: Border.all(color: Colors.teal.shade100)
              ),
              child: const Center(
                child: Text(
                  '[Chart Placeholder - e.g., Line graph showing SOL earnings over time]',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.teal),)
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for info cards
  Widget _buildInfoCard(BuildContext context, IconData icon, String title, String subtitle) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, size: 35, color: Theme.of(context).primaryColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600])),
      ),
    );
  }
} 