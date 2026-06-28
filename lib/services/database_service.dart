import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/beverage_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // =========================================================================
  // 1. FUNGSI UNTUK FITUR SCANNER (KODE LAMA - DIPERTAHANKAN)
  // =========================================================================
  Future<BeverageModel?> getBeverageByName(String queryName) async {
    try {
      print('\n--- RADAR DATABASE AKTIF ---');
      print('AI mencari kata kunci : >$queryName<');

      // 1. Cek Koneksi & Isi Total Database
      final allDocs = await _db.collection('beverages').get();
      print('Total dokumen terbaca di Firebase : ${allDocs.docs.length}');

      // 2. Cek Ejaan Persis di Database
      for (var doc in allDocs.docs) {
        print('Daftar nama di DB : >${doc.data()['name']}<');
      }

      // 3. Proses Pencarian Utama
      final snapshot = await _db
          .collection('beverages')
          .where('name', isEqualTo: queryName)
          .get();

      print('----------------------------\n');

      if (snapshot.docs.isNotEmpty) {
        return BeverageModel.fromMap(snapshot.docs.first.data());
      } else {
        return null; 
      }
    } catch (e) {
      print('ERROR FIREBASE: $e');
      return null;
    }
  }

  // =========================================================================
  // 2. FUNGSI UNTUK HALAMAN BERANDA (KODE BARU - DITAMBAHKAN)
  // =========================================================================

  // Fungsi untuk mengambil deretan "Minuman Populer"
  Future<List<BeverageModel>> getPopularBeverages() async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('beverages')
          .where('is_popular', isEqualTo: true) // Mencari yang saklarnya menyala
          .get();

      return snapshot.docs
          .map((doc) => BeverageModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching popular beverages: $e');
      return []; // Kembalikan list kosong jika gagal (agar aplikasi tidak crash)
    }
  }

  // Fungsi untuk mengambil deretan kategori lainnya (Waspada, Aman, dll)
  Future<List<BeverageModel>> getBeveragesByGrade(String grade) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('beverages')
          .where('health_grade', isEqualTo: grade) // Mencari berdasarkan label kesehatan
          .get();

      return snapshot.docs
          .map((doc) => BeverageModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching beverages by grade ($grade): $e');
      return [];
    }
  }
}