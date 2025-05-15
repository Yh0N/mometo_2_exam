import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:application_medicines/auth_controller.dart';
import 'package:application_medicines/medication_controller.dart';
import 'package:application_medicines/medication.dart';

class MedicationListScreen extends StatelessWidget {
  final MedicationController medicationController = Get.find<MedicationController>();

  MedicationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Medicamentos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Get.find<AuthController>().logout(),
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: medicationController.medications.length,
          itemBuilder: (context, index) {
            final medication = medicationController.medications[index];
            return MedicationCard(medication: medication);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/add-medication'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MedicationCard extends StatelessWidget {
  final Medication medication;

  const MedicationCard({super.key, required this.medication});

  @override
  Widget build(BuildContext context) {
    final MedicationController controller = Get.find<MedicationController>();

/// si el medicamento ya fue tomado o no 


    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(medication.name),
              subtitle: Text('Dosis: ${medication.dosage}'),
              trailing: Text(
                '${medication.time.hour.toString().padLeft(2, '0')}:${medication.time.minute.toString().padLeft(2, '0')}',
              ),
              onTap: () => Get.toNamed('/edit-medication/${medication.id}'),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.check),
              label: const Text("Tomado"),
              onPressed: () {
                controller.markAsTaken(medication);
              },
            ),
            const SizedBox(height: 8),
            if (medication.takenHistory.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Historial de tomas:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...medication.takenHistory.reversed.take(3).map(
                        (dt) => Text("- ${dt.toLocal()}"),
                      ),
                ],
              )
            else
              const Text("Aún no registrado como tomado."),
          ],
        ),
      ),
    );
  }
}
