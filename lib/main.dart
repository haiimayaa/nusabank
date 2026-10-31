import 'package:flutter/material.dart';

void main() {
  runApp(const NusaBankApp());
}

// ==================================================
// WARNA DAN KONFIGURASI
// ==================================================

const Color navy = Color(0xFF123B67);
const Color blue = Color(0xFF1976D2);
const Color lightBlue = Color(0xFFEAF3FF);
const Color background = Color(0xFFF5F7FA);

void openPage(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}

String rupiah(int value) {
  final digits = value.toString();
  final result = StringBuffer();

  for (int i = 0; i < digits.length; i++) {
    result.write(digits[i]);
    final remaining = digits.length - i - 1;
    if (remaining > 0 && remaining % 3 == 0) {
      result.write('.');
    }
  }

  return 'Rp${result.toString()}';
}

int parseAmount(String value) {
  return int.tryParse(value.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
}

// ==================================================
// APLIKASI UTAMA
// ==================================================

class NusaBankApp extends StatelessWidget {
  const NusaBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NusaBank',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(seedColor: blue),
        appBarTheme: const AppBarTheme(
          backgroundColor: navy,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// ==================================================
// WIDGET BANTUAN
// ==================================================

Widget bankLogo() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.account_balance, color: blue, size: 25),
      SizedBox(width: 8),
      Text(
        'NUSABANK',
        style: TextStyle(
          color: blue,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          fontSize: 17,
        ),
      ),
    ],
  );
}

Widget sectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 10),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: navy,
      ),
    ),
  );
}

Widget primaryButton(String title, VoidCallback onPressed) {
  return SizedBox(
    width: double.infinity,
    height: 48,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    ),
  );
}

Widget infoRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(title, style: const TextStyle(color: Colors.grey)),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

Widget menuItem(
  BuildContext context,
  IconData icon,
  String title,
  VoidCallback onTap,
) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: lightBlue,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(icon, color: blue, size: 27),
        ),
        const SizedBox(height: 7),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    ),
  );
}

// ==================================================
// 1. SPLASH SCREEN
// ==================================================

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1976D2), Color(0xFF0D3159)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.account_balance, size: 85, color: Colors.white),
              const SizedBox(height: 15),
              const Text(
                'NusaBank',
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Lebih Dekat, Untuk Masa Depan Anda',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 55),
              const Text(
                'Selamat Datang',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Layanan perbankan dalam satu genggaman',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: navy,
                    ),
                    onPressed: () {
                      openPage(context, const HomeScreen());
                    },
                    child: const Text(
                      'MULAI',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Aman • Mudah • Praktis',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================================================
// 2. BERANDA
// ==================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: bankLogo(),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              openPage(context, const NotificationScreen());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Halo, Maya!',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: navy,
              ),
            ),
            const Text(
              'Selamat datang di NusaBank',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Kartu saldo
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1976D2), navy],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SALDO ANDA', style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 10),
                  Text(
                    'Rp12.500.000',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Maya Susilawati',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text('3922550017', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),

            sectionTitle('Layanan'),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              mainAxisSpacing: 18,
              crossAxisSpacing: 8,
              childAspectRatio: 0.85,
              children: [
                menuItem(
                  context,
                  Icons.send,
                  'Transfer',
                  () => openPage(context, const TransferScreen()),
                ),
                menuItem(
                  context,
                  Icons.receipt_long,
                  'Pembayaran',
                  () => openPage(context, const PaymentScreen()),
                ),
                menuItem(
                  context,
                  Icons.add_card,
                  'Top Up',
                  () => openPage(context, const TopUpScreen()),
                ),
                menuItem(
                  context,
                  Icons.history,
                  'Mutasi',
                  () => openPage(context, const ActivityScreen()),
                ),
              ],
            ),

            sectionTitle('Transaksi Terbaru'),

            transactionTile(
              context,
              Icons.arrow_downward,
              Colors.green,
              'Gaji bulanan',
              '28 Okt 2026',
              '+Rp5.000.000',
              true,
            ),
            transactionTile(
              context,
              Icons.electric_bolt,
              Colors.orange,
              'Pembayaran Listrik',
              '27 Okt 2026',
              '-Rp350.000',
              false,
            ),
            transactionTile(
              context,
              Icons.send,
              blue,
              'Transfer ke Shila',
              '26 Okt 2026',
              '-Rp250.000',
              false,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BankBottomNav(selected: 0),
    );
  }
}

// ==================================================
// WIDGET TRANSAKSI
// ==================================================

Widget transactionTile(
  BuildContext context,
  IconData icon,
  Color color,
  String title,
  String date,
  String amount,
  bool income,
) {
  return Card(
    color: Colors.white,
    elevation: 0,
    child: ListTile(
      onTap: () {
        openPage(
          context,
          DetailTransactionScreen(
            title: title,
            date: date,
            amount: amount,
            income: income,
          ),
        );
      },
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.12),
        child: Icon(icon, color: color),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(date),
      trailing: Text(
        amount,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: income ? Colors.green : Colors.red,
        ),
      ),
    ),
  );
}

// ==================================================
// NAVIGASI BAWAH
// ==================================================

class BankBottomNav extends StatelessWidget {
  final int selected;

  const BankBottomNav({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selected,
      selectedItemColor: blue,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (index == selected) return;

        if (index == 0) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) => false,
          );
        } else if (index == 1) {
          openPage(context, const ActivityScreen());
        } else if (index == 2) {
          openPage(context, const ProfileScreen());
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Aktivitas'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
      ],
    );
  }
}

// ==================================================
// 3. TRANSFER
// ==================================================

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final rekeningController = TextEditingController();
  final namaController = TextEditingController();
  final nominalController = TextEditingController();
  final catatanController = TextEditingController();

  @override
  void dispose() {
    rekeningController.dispose();
    namaController.dispose();
    nominalController.dispose();
    catatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transfer')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bankLogo(),
            sectionTitle('Rekening Tujuan'),
            TextField(
              controller: rekeningController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Masukkan nomor rekening',
                prefixIcon: Icon(Icons.account_balance),
              ),
            ),
            sectionTitle('Nama Penerima'),
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                hintText: 'Masukkan nama penerima',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            sectionTitle('Nominal Transfer'),
            TextField(
              controller: nominalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Rp 0',
                prefixIcon: Icon(Icons.money),
              ),
            ),
            sectionTitle('Catatan (Opsional)'),
            TextField(
              controller: catatanController,
              decoration: const InputDecoration(
                hintText: 'Tambahkan catatan',
                prefixIcon: Icon(Icons.edit_note),
              ),
            ),
            const SizedBox(height: 25),
            primaryButton('LANJUTKAN', () {
              if (rekeningController.text.isEmpty ||
                  namaController.text.isEmpty ||
                  nominalController.text.isEmpty ||
                  parseAmount(nominalController.text) <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Lengkapi data transfer dengan benar'),
                  ),
                );
                return;
              }

              openPage(
                context,
                TransferConfirmationScreen(
                  rekening: rekeningController.text,
                  nama: namaController.text,
                  nominal: parseAmount(nominalController.text),
                  catatan: catatanController.text,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ==================================================
// 4. KONFIRMASI TRANSFER
// ==================================================

class TransferConfirmationScreen extends StatelessWidget {
  final String rekening;
  final String nama;
  final int nominal;
  final String catatan;

  const TransferConfirmationScreen({
    super.key,
    required this.rekening,
    required this.nama,
    required this.nominal,
    required this.catatan,
  });

  @override
  Widget build(BuildContext context) {
    const int admin = 2500;

    return Scaffold(
      appBar: AppBar(title: const Text('Konfirmasi Transfer')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            bankLogo(),
            const SizedBox(height: 25),
            const Icon(Icons.account_circle, color: blue, size: 65),
            sectionTitle('Detail Penerima'),
            infoRow('Nama', nama),
            infoRow('Rekening', rekening),
            const Divider(),
            sectionTitle('Rincian Transfer'),
            infoRow('Nominal', rupiah(nominal)),
            infoRow('Biaya Admin', rupiah(admin)),
            const Divider(),
            infoRow('Total', rupiah(nominal + admin)),
            if (catatan.isNotEmpty) infoRow('Catatan', catatan),
            const SizedBox(height: 25),
            primaryButton('KONFIRMASI', () {
              openPage(
                context,
                TransferSuccessScreen(
                  nama: nama,
                  rekening: rekening,
                  nominal: nominal,
                ),
              );
            }),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('KEMBALI'),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================================================
// 5. STATUS TRANSFER
// ==================================================

class TransferSuccessScreen extends StatelessWidget {
  final String nama;
  final String rekening;
  final int nominal;

  const TransferSuccessScreen({
    super.key,
    required this.nama,
    required this.rekening,
    required this.nominal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status Transaksi'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 100),
              const SizedBox(height: 20),
              const Text(
                'Transaksi Berhasil',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: navy,
                ),
              ),
              const SizedBox(height: 10),
              const Text('Transfer berhasil (simulasi)'),
              const SizedBox(height: 25),
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      infoRow('Penerima', nama),
                      infoRow('Rekening', rekening),
                      infoRow('Nominal', rupiah(nominal)),
                      infoRow('Status', 'Berhasil'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              primaryButton('KEMBALI KE BERANDA', () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                  (route) => false,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================================================
// 6. TOP UP
// ==================================================

class TopUpScreen extends StatelessWidget {
  const TopUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top Up')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          bankLogo(),
          sectionTitle('Pilih E-Wallet'),
          serviceItem(
            context,
            Icons.account_balance_wallet,
            'GoPay',
            'Top Up GoPay',
          ),
          serviceItem(context, Icons.wallet, 'OVO', 'Top Up OVO'),
          serviceItem(context, Icons.qr_code, 'DANA', 'Top Up DANA'),
          serviceItem(
            context,
            Icons.shopping_bag,
            'ShopeePay',
            'Top Up ShopeePay',
          ),
        ],
      ),
    );
  }
}

// ==================================================
// 7. PEMBAYARAN
// ==================================================

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          bankLogo(),
          sectionTitle('Pilih Jenis Pembayaran'),
          serviceItem(context, Icons.bolt, 'Listrik', 'Pembayaran Listrik'),
          serviceItem(
            context,
            Icons.water_drop,
            'Air / PDAM',
            'Pembayaran Air',
          ),
          serviceItem(context, Icons.wifi, 'Internet', 'Pembayaran Internet'),
          serviceItem(
            context,
            Icons.phone_android,
            'Pulsa',
            'Pembayaran Pulsa',
          ),
          serviceItem(
            context,
            Icons.school,
            'Pendidikan',
            'Pembayaran Pendidikan',
          ),
        ],
      ),
    );
  }
}

// ==================================================
// MENU LAYANAN TOP UP DAN PEMBAYARAN
// ==================================================

Widget serviceItem(
  BuildContext context,
  IconData icon,
  String name,
  String title,
) {
  return Card(
    color: Colors.white,
    elevation: 0,
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: lightBlue,
        child: Icon(icon, color: blue),
      ),
      title: Text(name),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        openPage(context, ServiceFormScreen(title: title));
      },
    ),
  );
}

// ==================================================
// FORM TOP UP DAN PEMBAYARAN
// ==================================================

class ServiceFormScreen extends StatefulWidget {
  final String title;

  const ServiceFormScreen({super.key, required this.title});

  @override
  State<ServiceFormScreen> createState() => _ServiceFormScreenState();
}

class _ServiceFormScreenState extends State<ServiceFormScreen> {
  final nomorController = TextEditingController();
  final nominalController = TextEditingController();

  @override
  void dispose() {
    nomorController.dispose();
    nominalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bankLogo(),
            sectionTitle('Nomor Tujuan'),
            TextField(
              controller: nomorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Masukkan nomor tujuan',
                prefixIcon: Icon(Icons.phone_android),
              ),
            ),
            sectionTitle('Nominal'),
            TextField(
              controller: nominalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Masukkan nominal',
                prefixIcon: Icon(Icons.money),
              ),
            ),
            const SizedBox(height: 25),
            primaryButton('LANJUTKAN', () {
              final amount = parseAmount(nominalController.text);

              if (nomorController.text.isEmpty || amount <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Lengkapi data dengan benar')),
                );
                return;
              }

              openPage(
                context,
                ServiceConfirmationScreen(
                  title: widget.title,
                  nomor: nomorController.text,
                  nominal: amount,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ==================================================
// KONFIRMASI TOP UP DAN PEMBAYARAN
// ==================================================

class ServiceConfirmationScreen extends StatelessWidget {
  final String title;
  final String nomor;
  final int nominal;

  const ServiceConfirmationScreen({
    super.key,
    required this.title,
    required this.nomor,
    required this.nominal,
  });

  @override
  Widget build(BuildContext context) {
    const int admin = 2500;

    return Scaffold(
      appBar: AppBar(title: const Text('Konfirmasi Transaksi')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            bankLogo(),
            const SizedBox(height: 25),
            const Icon(Icons.receipt_long, color: blue, size: 65),
            sectionTitle('Rincian Transaksi'),
            infoRow('Jenis Layanan', title),
            infoRow('Nomor Tujuan', nomor),
            infoRow('Nominal', rupiah(nominal)),
            infoRow('Biaya Admin', rupiah(admin)),
            const Divider(),
            infoRow('Total', rupiah(nominal + admin)),
            const SizedBox(height: 25),
            primaryButton('KONFIRMASI', () {
              openPage(
                context,
                ServiceSuccessScreen(
                  title: title,
                  nomor: nomor,
                  nominal: nominal,
                ),
              );
            }),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('KEMBALI'),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================================================
// STATUS TOP UP DAN PEMBAYARAN
// ==================================================

class ServiceSuccessScreen extends StatelessWidget {
  final String title;
  final String nomor;
  final int nominal;

  const ServiceSuccessScreen({
    super.key,
    required this.title,
    required this.nomor,
    required this.nominal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status Transaksi'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 100),
              const SizedBox(height: 20),
              const Text(
                'Transaksi Berhasil',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: navy,
                ),
              ),
              const SizedBox(height: 10),
              const Text('Transaksi berhasil (simulasi)'),
              const SizedBox(height: 25),
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      infoRow('Layanan', title),
                      infoRow('Nomor Tujuan', nomor),
                      infoRow('Nominal', rupiah(nominal)),
                      infoRow('Status', 'Berhasil'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              primaryButton('SELESAI', () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                  (route) => false,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================================================
// 8. AKTIVITAS / MUTASI
// ==================================================

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Transaksi')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          bankLogo(),
          sectionTitle('Aktivitas Terbaru'),
          transactionTile(
            context,
            Icons.arrow_downward,
            Colors.green,
            'Gaji bulanan',
            '28 Okt 2026',
            '+Rp5.000.000',
            true,
          ),
          transactionTile(
            context,
            Icons.electric_bolt,
            Colors.orange,
            'Pembayaran listrik',
            '27 Okt 2026',
            '-Rp350.000',
            false,
          ),
          transactionTile(
            context,
            Icons.send,
            blue,
            'Transfer ke Shila',
            '26 Okt 2026',
            '-Rp250.000',
            false,
          ),
          transactionTile(
            context,
            Icons.phone_android,
            Colors.purple,
            'Top Up E-Wallet',
            '25 Okt 2026',
            '-Rp100.000',
            false,
          ),
          transactionTile(
            context,
            Icons.account_balance_wallet,
            Colors.teal,
            'Dana masuk',
            '24 Okt 2026',
            '+Rp500.000',
            true,
          ),
        ],
      ),
      bottomNavigationBar: const BankBottomNav(selected: 1),
    );
  }
}

// ==================================================
// DETAIL TRANSAKSI
// ==================================================

class DetailTransactionScreen extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final bool income;

  const DetailTransactionScreen({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.income,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Transaksi')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            bankLogo(),
            const SizedBox(height: 30),
            CircleAvatar(
              radius: 35,
              backgroundColor: lightBlue,
              child: Icon(
                income ? Icons.arrow_downward : Icons.arrow_upward,
                color: blue,
                size: 35,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              amount,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: income ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 25),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    infoRow('Tanggal', date),
                    infoRow('Jenis', income ? 'Dana Masuk' : 'Dana Keluar'),
                    infoRow('Status', 'Berhasil'),
                    infoRow('Metode', 'Mobile Banking'),
                  ],
                ),
              ),
            ),
            const Spacer(),
            primaryButton('KEMBALI', () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }
}

// ==================================================
// 9. PROFIL
// ==================================================

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Saya')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          bankLogo(),
          const SizedBox(height: 25),
          const CircleAvatar(
            radius: 48,
            backgroundColor: lightBlue,
            child: Icon(Icons.person, size: 55, color: blue),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'MAYA SUSILAWATI',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: navy,
              ),
            ),
          ),
          const Center(
            child: Text(
              'Rekening 3922550017',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          sectionTitle('Menu Profil'),
          profileMenu(
            context,
            Icons.person_outline,
            'Informasi Pribadi',
            const PersonalInfoScreen(),
          ),
          profileMenu(
            context,
            Icons.settings,
            'Pengaturan',
            const SettingsScreen(),
          ),
          profileMenu(
            context,
            Icons.help_outline,
            'Bantuan',
            const HelpScreen(),
          ),
          const SizedBox(height: 25),
          primaryButton('KELUAR', () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const SplashScreen()),
              (route) => false,
            );
          }),
        ],
      ),
      bottomNavigationBar: const BankBottomNav(selected: 2),
    );
  }
}

Widget profileMenu(
  BuildContext context,
  IconData icon,
  String title,
  Widget page,
) {
  return Card(
    color: Colors.white,
    elevation: 0,
    child: ListTile(
      leading: Icon(icon, color: blue),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => openPage(context, page),
    ),
  );
}

// ==================================================
// INFORMASI PRIBADI
// ==================================================

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Informasi Pribadi')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          color: Colors.white,
          child: const Padding(
            padding: EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.person, size: 65, color: blue),
                SizedBox(height: 15),
                Text(
                  'Informasi Nasabah',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: navy,
                  ),
                ),
                SizedBox(height: 15),
                ProfileInfo(title: 'Nama', value: 'Maya Susilawati'),
                ProfileInfo(title: 'Nomor Rekening', value: '3922550017'),
                ProfileInfo(
                  title: 'Email',
                  value: 'mayasusilawati43@gmail.com',
                ),
                ProfileInfo(title: 'Telepon', value: '087797969438'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  final String title;
  final String value;

  const ProfileInfo({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(child: Text(title)),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================================================
// 10. PENGATURAN
// ==================================================

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          bankLogo(),
          sectionTitle('Pengaturan Aplikasi'),
          const SettingTile(icon: Icons.notifications, title: 'Notifikasi'),
          const SettingTile(icon: Icons.lock, title: 'Keamanan'),
          const SettingTile(icon: Icons.language, title: 'Bahasa'),
          const SettingTile(
            icon: Icons.info_outline,
            title: 'Tentang Aplikasi',
          ),
        ],
      ),
    );
  }
}

// ==================================================
// 11. BANTUAN
// ==================================================

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bantuan')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          bankLogo(),
          sectionTitle('Pusat Bantuan'),
          const SettingTile(icon: Icons.help, title: 'Pertanyaan Umum'),
          const SettingTile(icon: Icons.support_agent, title: 'Hubungi Kami'),
          const SettingTile(icon: Icons.menu_book, title: 'Panduan Penggunaan'),
          const SettingTile(
            icon: Icons.privacy_tip,
            title: 'Syarat dan Ketentuan',
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'NusaBank Mobile Banking\nVersi 1.0.0',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================================================
// WIDGET PENGATURAN
// ==================================================

class SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const SettingTile({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: Icon(icon, color: blue),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('$title (simulasi)')));
        },
      ),
    );
  }
}

// ==================================================
// NOTIFIKASI
// ==================================================

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifikasi')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          ListTile(
            leading: Icon(Icons.notifications, color: blue),
            title: Text('Selamat datang di NusaBank'),
            subtitle: Text('Nikmati layanan perbankan digital.'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info, color: blue),
            title: Text('Informasi Akun'),
            subtitle: Text('Akun siap digunakan (simulasi).'),
          ),
        ],
      ),
    );
  }
}
