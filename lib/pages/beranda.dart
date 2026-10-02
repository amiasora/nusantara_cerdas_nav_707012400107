import 'package:flutter/material.dart';

class Beranda extends StatelessWidget {
  const Beranda({super.key});

  static const pilar = [
    [
      'Smart Governance',
      Icons.account_balance,
      'Pelayanan publik transparan dan terintegrasi.',
    ],
    [
      'Smart Economy',
      Icons.payments,
      'Mendorong ekonomi digital dan UMKM.',
    ],
    [
      'Smart Living',
      Icons.home,
      'Meningkatkan kualitas hidup warga.',
    ],
    [
      'Smart Mobility',
      Icons.directions_car,
      'Transportasi aman, efisien, dan terhubung.',
    ],
    [
      'Smart Environment',
      Icons.eco,
      'Pengelolaan lingkungan berkelanjutan.',
    ],
    [
      'Smart People',
      Icons.people,
      'Mendorong kreativitas dan partisipasi warga.',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Nusantara Cerdas',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Kota yang maju, terhubung, dan berkelanjutan.',
            style: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Enam Pilar Smart City',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...pilar.map(
            (item) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(item[1] as IconData),
                ),
                title: Text(
                  item[0] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(item[2] as String),
              ),
            ),
          ),
        ],
      ),
    );
  }
}