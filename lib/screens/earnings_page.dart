import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For number formatting

class EarningsPage extends StatelessWidget {
  EarningsPage({super.key});

  // Mock Data
  final double totalEarningsSOL = 15.78;
  final double recentEarningsSOL = 1.25;
  final int nftsDeployed = 3;

  // NEW: Mock data for deployed assets
  final List<Map<String, dynamic>> deployedAssets = [
    {
      'id': 'panel_deploy_001',
      'name': 'Solarna Panel X1 #001', // Example deployed instance
      'location': 'Solarna Farm Alpha',
      'status': 'Active - Generating',
      'totalEarned': 5.21, // SOL
      'lastPayout': 0.08 // SOL
    },
    {
      'id': 'pump_deploy_001',
      'name': 'AquaSol Pump V2 #001',
      'location': 'Solarna Farm Beta',
      'status': 'Active - Generating',
      'totalEarned': 3.15, // SOL
      'lastPayout': 0.05 // SOL
    },
    {
      'id': 'panel_deploy_002',
      'name': 'Solarna Panel X1 #002',
      'location': 'Solarna Farm Alpha',
      'status': 'Active - Generating',
      'totalEarned': 7.42, // SOL
      'lastPayout': 0.12 // SOL
    },
  ];

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
             _buildInfoCard(context, Icons.developer_board_outlined, '$nftsDeployed Assets Deployed', 'Generating passive income'),
             const SizedBox(height: 10),
            _buildInfoCard(context, Icons.trending_up, 'Marketplace Trend: Positive', 'Based on recent activity'),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),

            Text(
              'Deployed Assets Performance',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.grey[700]),
            ),
            const SizedBox(height: 15),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: deployedAssets.length,
              itemBuilder: (context, index) {
                final asset = deployedAssets[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 15.0),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          asset['name'] ?? 'Unknown Asset',
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined, size: 16, color: Colors.grey[600]),
                            const SizedBox(width: 5),
                            Text('Location: ${asset['location'] ?? 'N/A'}', style: TextStyle(color: Colors.grey[700])),
                          ],
                        ),
                         const SizedBox(height: 5),
                         Row(
                          children: [
                            Icon(Icons.power_settings_new, size: 16, color: Colors.green[700]),
                            const SizedBox(width: 5),
                            Text('Status: ${asset['status'] ?? 'N/A'}', style: TextStyle(color: Colors.green[800])),
                          ],
                        ),
                        const Divider(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Total Earned', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                                Text(
                                  numberFormat.format(asset['totalEarned'] ?? 0),
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Theme.of(context).primaryColor)
                                ),
                              ],
                            ),
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Last Payout', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                                Text(
                                  numberFormat.format(asset['lastPayout'] ?? 0),
                                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                );
              },
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