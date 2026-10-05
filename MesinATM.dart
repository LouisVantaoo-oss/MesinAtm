import 'dart:io';

void main() {
  // ==============================
  // DATA AWAL ATM
  // ==============================
  String pin = '112233';
  double saldo = 5000000;

  bool loginBerhasil = false;
  int percobaan = 0;

  print('==========================================');
  print('          SELAMAT DATANG DI ATM');
  print('==========================================');

  // ==============================
  // LOGIN PIN
  // ==============================
  while (percobaan < 3) {
    stdout.write('Masukkan PIN: ');
    String pinInput = stdin.readLineSync() ?? '';

    if (pinInput == pin) {
      loginBerhasil = true;
      print('\nLogin berhasil!');
      break;
    } else {
      percobaan++;

      if (percobaan < 3) {
        print('PIN salah!');
        print('Sisa percobaan: ${3 - percobaan}\n');
      }
    }
  }

  // Jika gagal login 3 kali
  if (!loginBerhasil) {
    print('\n==========================================');
    print('       AKUN TERBLOKIR SEMENTARA');
    print('==========================================');
    print('Terlalu banyak memasukkan PIN yang salah.');
    return;
  }

  // ==============================
  // MENU ATM
  // ==============================
  bool programBerjalan = true;

  while (programBerjalan) {
    print('\n==========================================');
    print('                 MENU ATM');
    print('==========================================');
    print('1. Cek Saldo');
    print('2. Tarik Tunai');
    print('3. Setor Tunai');
    print('4. Transfer');
    print('5. Ganti PIN');
    print('6. Keluar');
    print('==========================================');

    stdout.write('Pilih menu: ');
    String pilihan = stdin.readLineSync() ?? '';

    // ==============================
    // 1. CEK SALDO
    // ==============================
    if (pilihan == '1') {
      print('\n==========================================');
      print('                 CEK SALDO');
      print('==========================================');
      print('Saldo Anda: Rp ${saldo.toStringAsFixed(0)}');
      print('==========================================');
    }

    // ==============================
// 2. TARIK TUNAI
// ==============================
else if (pilihan == '2') {
  print('\n==========================================');
  print('                TARIK TUNAI');
  print('==========================================');

  // Memasukkan jumlah uang terlebih dahulu
  stdout.write('Masukkan jumlah uang yang ingin ditarik: Rp ');

  int? jumlahTarik = int.tryParse(stdin.readLineSync() ?? '');

  if (jumlahTarik == null || jumlahTarik <= 0) {
    print('Jumlah penarikan tidak valid.');
    continue;
  }

  // Cek saldo
  if (jumlahTarik > saldo) {
    print('Saldo tidak mencukupi.');
    print('Saldo Anda: Rp ${saldo.toStringAsFixed(0)}');
    continue;
  }

  // Pilih pecahan
  print('\nPilih pecahan utama:');
  print('1. Rp50.000');
  print('2. Rp100.000');

  stdout.write('Pilih pecahan: ');
  String pilihanPecahan = stdin.readLineSync() ?? '';

  int pecahan;

  if (pilihanPecahan == '1') {
    pecahan = 50000;
  } else if (pilihanPecahan == '2') {
    pecahan = 100000;
  } else {
    print('Pilihan pecahan tidak tersedia.');
    continue;
  }

  // ==============================
  // MENGHITUNG JUMLAH LEMBAR
  // ==============================

  int sisa = jumlahTarik;

  int lembar100 = 0;
  int lembar50 = 0;

  if (pecahan == 100000) {
    // Hitung uang Rp100.000
    lembar100 = sisa ~/ 100000;
    sisa = sisa % 100000;

    // Sisa menggunakan Rp50.000
    if (sisa >= 50000) {
      lembar50 = sisa ~/ 50000;
      sisa = sisa % 50000;
    }
  } else {
    // Jika memilih pecahan Rp50.000
    lembar50 = sisa ~/ 50000;
    sisa = sisa % 50000;
  }

  // Cek apakah jumlah bisa dikeluarkan ATM
  if (sisa != 0) {
    print('\nMaaf, jumlah tersebut tidak dapat dikeluarkan.');
    print('Gunakan jumlah kelipatan Rp50.000.');
    continue;
  }

  // Kurangi saldo
  saldo -= jumlahTarik;

  // ==============================
  // TAMPILKAN UANG YANG KELUAR
  // ==============================

  print('\n==========================================');
  print('          PENARIKAN BERHASIL');
  print('==========================================');

  print('Jumlah penarikan: Rp $jumlahTarik');
  print('');
  print('Uang yang keluar:');

  if (lembar100 > 0) {
    print('Rp100.000 : $lembar100 lembar');
  }

  if (lembar50 > 0) {
    print('Rp50.000  : $lembar50 lembar');
  }

  print('');
  print('Saldo akhir: Rp ${saldo.toStringAsFixed(0)}');
  print('==========================================');
}


    // ==============================
    // 3. SETOR TUNAI
    // ==============================
    else if (pilihan == '3') {
      print('\n==========================================');
      print('                SETOR TUNAI');
      print('==========================================');

      stdout.write('Masukkan jumlah setor: Rp ');

      double? jumlahSetor =
          double.tryParse(stdin.readLineSync() ?? '');

      if (jumlahSetor == null || jumlahSetor <= 0) {
        print('Jumlah setor tidak valid.');
        continue;
      }

      saldo += jumlahSetor;

      print('\nSetor tunai berhasil!');
      print('Jumlah setor : Rp ${jumlahSetor.toStringAsFixed(0)}');
      print('Saldo Anda   : Rp ${saldo.toStringAsFixed(0)}');
    }

    // ==============================
    // 4. TRANSFER
    // ==============================
    else if (pilihan == '4') {
      print('\n==========================================');
      print('                  TRANSFER');
      print('==========================================');

      stdout.write('Masukkan nomor rekening tujuan: ');
      String rekening = stdin.readLineSync() ?? '';

      if (rekening.isEmpty) {
        print('Nomor rekening tidak boleh kosong.');
        continue;
      }

      stdout.write('Masukkan jumlah transfer: Rp ');

      double? jumlahTransfer =
          double.tryParse(stdin.readLineSync() ?? '');

      if (jumlahTransfer == null || jumlahTransfer <= 0) {
        print('Jumlah transfer tidak valid.');
        continue;
      }

      if (jumlahTransfer > saldo) {
        print('Saldo tidak mencukupi.');
        continue;
      }

      saldo -= jumlahTransfer;

      print('\n==========================================');
      print('            TRANSFER BERHASIL');
      print('==========================================');
      print('Rekening tujuan : $rekening');
      print('Jumlah transfer : Rp ${jumlahTransfer.toStringAsFixed(0)}');
      print('Saldo akhir     : Rp ${saldo.toStringAsFixed(0)}');
      print('==========================================');
    }

    // ==============================
    // 5. GANTI PIN
    // ==============================
    else if (pilihan == '5') {
      print('\n==========================================');
      print('                 GANTI PIN');
      print('==========================================');

      stdout.write('Masukkan PIN lama: ');
      String pinLama = stdin.readLineSync() ?? '';

      if (pinLama != pin) {
        print('PIN lama salah.');
        continue;
      }

      stdout.write('Masukkan PIN baru: ');
      String pinBaru = stdin.readLineSync() ?? '';

      if (pinBaru.length != 6) {
        print('PIN baru harus terdiri dari 6 angka.');
        continue;
      }

      if (int.tryParse(pinBaru) == null) {
        print('PIN hanya boleh berisi angka.');
        continue;
      }

      pin = pinBaru;

      print('\nPIN berhasil diubah!');
    }

    // ==============================
    // 6. KELUAR
    // ==============================
    else if (pilihan == '6') {
      print('\n==========================================');
      print('       TERIMA KASIH TELAH MENGGUNAKAN');
      print('                  ATM');
      print('==========================================');
      print('Silakan ambil kartu Anda.');
      print('==========================================');

      programBerjalan = false;
    }

    // ==============================
    // PILIHAN TIDAK TERSEDIA
    // ==============================
    else {
      print('\nPilihan menu tidak tersedia!');
      print('Silakan pilih menu 1 - 6.');
    }
  }
}
