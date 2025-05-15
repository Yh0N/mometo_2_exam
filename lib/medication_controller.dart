import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';

import 'appwrite_config.dart';
import 'medication.dart';

class MedicationController extends GetxController {
  final Databases databases = Databases(AppwriteConfig.getClient());
  final RxList<Medication> medications = <Medication>[].obs;

  // Usar los IDs del config
  final String databaseId = AppwriteConfig.databaseId;
  final String collectionId = AppwriteConfig.collectionId;

  @override
  void onInit() {
    super.onInit();
    getMedications();
  }

  Future<void> addMedication(Medication medication) async {
    try {
      await databases.createDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: ID.unique(),
        data: medication.toJson(),
      );
      await getMedications();
    } catch (e) {
      Get.snackbar('Error al agregar', e.toString());
    }
  }

  Future<void> getMedications() async {
    try {
      final response = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId,
      );
      medications.value = response.documents
          .map((doc) => Medication.fromJson({
                ...doc.data,
                '\$id': doc.$id, // Asegura que el ID se pase correctamente
              }))
          .toList();
    } catch (e) {
      Get.snackbar('Error al cargar', e.toString());
    }
  }

  Future<void> updateMedication(Medication medication) async {
    try {
      await databases.updateDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: medication.id,
        data: medication.toJson(),
      );
      await getMedications();
    } catch (e) {
      Get.snackbar('Error al actualizar', e.toString());
    }
  }

  Future<void> deleteMedication(String medicationId) async {
    try {
      await databases.deleteDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: medicationId,
      );
      await getMedications();
    } catch (e) {
      Get.snackbar('Error al eliminar', e.toString());
    }
  }

  /// ✅ Nueva función: Marcar como "Tomado"
  Future<void> markAsTaken(Medication medication) async {
    try {
      final now = DateTime.now();
      final updatedHistory = [...medication.takenHistory, now];

      final updatedMedication = medication.copyWith(
        takenHistory: updatedHistory,
      );

      await updateMedication(updatedMedication);
      Get.snackbar('Registrado', 'Medicación marcada como tomada');
    } catch (e) {
      Get.snackbar('Error al marcar como tomado', e.toString());
    }
  }

  /// (Opcional) obtener por ID más adelante
  getMedicationById(String id) {}
}
