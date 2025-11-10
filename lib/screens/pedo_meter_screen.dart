import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/pedo_meter_controller.dart';

class PedoMeterScreen extends StatelessWidget {
  PedoMeterScreen({super.key});

  final PedoMeterController controller = Get.put(PedoMeterController());

  @override
  Widget build(BuildContext context) {
    final List<String>? gyroscope =
    controller.gyroscopeValues.map((double v) => v.toStringAsFixed(1)).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Pedometer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'GyropScope Value:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),

        Text(
                '${gyroscope}',
                style: const TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            const Text(
              'Total Steps:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),

            Obx(
                  () => Text(
                '${controller.steps.value}',
                style: const TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              'Current Status:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),

            Obx(
                  () => Text(
                controller.status.value.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: controller.status.value.contains('error')
                      ? Colors.red
                      : Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}