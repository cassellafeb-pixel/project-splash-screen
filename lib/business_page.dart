import 'package:flutter/material.dart';

/// Model data untuk satu lini bisnis energi terbarukan
class EnergyBusiness {
  const EnergyBusiness({
    required this.name,
    required this.icon,
    required this.color,
    required this.summary,
    required this.description,
    required this.services,
  });

  final String name;
  final IconData icon;
  final Color color;
  final String summary;
  final String description;
  final List<String> services;
}

/// Data bisnis (contoh, silakan ganti sesuai kebutuhan)
const List<EnergyBusiness> energyBusinesses = [
  EnergyBusiness(
    name: 'Energi Surya',
    icon: Icons.wb_sunny,
    color: Colors.orange,
    summary: 'Panel surya untuk rumah, industri, dan komersial.',
    description:
        'Cassell Group menyediakan solusi pembangkit listrik tenaga surya '
        'yang membantu menekan biaya listrik dan emisi karbon.',
    services: [
      'Instalasi PLTS atap',
      'PLTS skala industri',
      'Perawatan dan monitoring',
    ],
  ),
  EnergyBusiness(
    name: 'Energi Angin',
    icon: Icons.air,
    color: Colors.blue,
    summary: 'Turbin angin untuk wilayah dengan potensi angin tinggi.',
    description:
        'Pengembangan pembangkit listrik tenaga bayu, mulai dari studi '
        'kelayakan sampai operasional.',
    services: [
      'Studi potensi angin',
      'Pembangunan turbin',
      'Operasi dan pemeliharaan',
    ],
  ),
  EnergyBusiness(
    name: 'Energi Air',
    icon: Icons.water_drop,
    color: Colors.teal,
    summary: 'Mikrohidro dan PLTA untuk daerah berair melimpah.',
    description:
        'Solusi pembangkit listrik tenaga air skala kecil hingga menengah, '
        'cocok untuk pedesaan dan kawasan terpencil.',
    services: [
      'Pembangunan PLTMH',
      'Rehabilitasi pembangkit',
      'Konsultasi teknis',
    ],
  ),
  EnergyBusiness(
    name: 'Biomassa',
    icon: Icons.grass,
    color: Colors.green,
    summary: 'Energi dari limbah pertanian dan organik.',
    description:
        'Mengubah limbah organik menjadi energi bersih berupa listrik, '
        'panas, maupun biogas.',
    services: [
      'Pengolahan limbah jadi energi',
      'Produksi biogas',
      'Pelet biomassa',
    ],
  ),
];

/// Halaman daftar bisnis
class BusinessPage extends StatelessWidget {
  const BusinessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Bisnis Energi Terbarukan',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          'Pilih salah satu untuk melihat detailnya.',
          style: TextStyle(color: Colors.grey[700]),
        ),
        const SizedBox(height: 16),
        for (final item in energyBusinesses)
          Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: item.color.withOpacity(0.15),
                child: Icon(item.icon, color: item.color),
              ),
              title: Text(
                item.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item.summary),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => openBusinessDetail(context, item),
            ),
          ),
      ],
    );
  }
}

/// Fungsi bantu supaya bisa dipanggil dari Home maupun Business
void openBusinessDetail(BuildContext context, EnergyBusiness item) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => BusinessDetailPage(item: item)),
  );
}

/// Halaman detail satu bisnis
class BusinessDetailPage extends StatelessWidget {
  const BusinessDetailPage({super.key, required this.item});

  final EnergyBusiness item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Center(
            child: CircleAvatar(
              radius: 48,
              backgroundColor: item.color.withOpacity(0.15),
              child: Icon(item.icon, size: 48, color: item.color),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            item.name,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(item.description, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 24),
          const Text(
            'Layanan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          for (final s in item.services)
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.check_circle, color: item.color),
              title: Text(s),
            ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Permintaan info ${item.name} dikirim')),
              );
            },
            icon: const Icon(Icons.mail),
            label: const Text('Hubungi Kami'),
          ),
        ],
      ),
    );
  }
}