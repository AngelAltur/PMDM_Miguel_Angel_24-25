import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Modelo de producto escaneado
class Product {
  final String ean;
  final String name;
  final List<String> allergens;
  final DateTime scannedAt;

  Product({
    required this.ean,
    required this.name,
    required this.allergens,
    required this.scannedAt,
  });

  /// Convierte el producto a un mapa para Firestore
  Map<String, dynamic> toMap() {
    return {
      'ean': ean,
      'name': name,
      'allergens': allergens,
      'scannedAt': scannedAt.toUtc(),
    };
  }

  /// Crea un producto desde un documento de Firestore
  factory Product.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Product(
      ean: data['ean'] as String,
      name: data['name'] as String,
      allergens: List<String>.from(data['allergens'] as List<dynamic>),
      scannedAt: (data['scannedAt'] as Timestamp).toDate(),
    );
  }
}

/// Servicio para consultar OpenFoodFacts y gestionar historial en Firestore
class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Busca un producto por EAN en OpenFoodFacts y lo guarda en Firestore
  Future<Product?> fetchAndSaveProduct(String ean) async {
    // Llamada API
    final url = Uri.parse('https://world.openfoodfacts.org/api/v0/product/$ean.json');
    final resp = await http.get(url);
    if (resp.statusCode != 200) return null;

    final data = json.decode(resp.body) as Map<String, dynamic>;
    if (data['status'] != 1) return null;

    final productData = data['product'] as Map<String, dynamic>;
    final name = productData['product_name'] as String? ?? 'Producto desconocido';
    final allergensRaw = productData['allergens_hierarchy'] as List<dynamic>? ?? [];
    final allergens = allergensRaw.map((tag) {
      final parts = tag.toString().split(':');
      return parts.isNotEmpty ? parts.last : tag.toString();
    }).toList();

    final product = Product(
      ean: ean,
      name: name,
      allergens: allergens,
      scannedAt: DateTime.now(),
    );

    await _saveToHistory(product);
    return product;
  }

  /// Guarda un escaneo en Firestore bajo el usuario autenticado
  Future<void> _saveToHistory(Product product) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'NO_USER',
        message: 'Usuario no autenticado, no se puede guardar el historial.',
      );
    }

    final ref = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('scanHistory');

    await ref.add(product.toMap());
  }

  /// Recupera el historial de escaneos del usuario actual
  Future<List<Product>> getScanHistory() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'NO_USER',
        message: 'Usuario no autenticado, no se puede leer el historial.',
      );
    }

    final snapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('scanHistory')
        .orderBy('scannedAt', descending: true)
        .get();

    return snapshot.docs.map((doc) => Product.fromDoc(doc)).toList();
  }
}
