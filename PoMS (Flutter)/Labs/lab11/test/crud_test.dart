import 'package:flutter_test/flutter_test.dart';
import 'package:lab10/presentation/pages/home_page.dart';
import 'package:lab10/firestore.dart';

void main() {
  group('HomePage Unit Tests', () {
    test('Testing adding music', () {
      final firestoreService = FirestoreService();
      // Simulate adding music without a docId
      firestoreService.addMusic('Test', 'Test', 'Test');
      // Perform assertions here for expected behavior
    });

    test('Testing updating music', () {
      final firestoreService = FirestoreService();
      final String docId = 'testDocId';
      // Simulate updating music with a docId
      firestoreService.updateMusic(docId, 'Test');
      // Perform assertions here for expected behavior
    });

    test('Testing deleting music', () {
      final firestoreService = FirestoreService();
      final String docId = 'testDocId';
      // Simulate deleting music with a docId
      firestoreService.deleteMusic(docId);
      // Perform assertions here for expected behavior
    });
  });
}
