import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/pedo_meter_controller.dart';

class PedoMeterScreen extends StatelessWidget {
  PedoMeterScreen({super.key});

  final PedoMeterController controller = Get.put(PedoMeterController());

  String formatGyroscopeValues(List<double> values) {
    return values.map((v) => v.toStringAsFixed(2)).join(' | ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedometer & Gyroscope Demo'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Gyroscope (X | Y | Z):',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.black87),
              ),
              const SizedBox(height: 10),

              Obx(
                    () => Text(
                  formatGyroscopeValues(controller.gyroscopeValues),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              const Text(
                'Total Steps:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.black87),
              ),
              const SizedBox(height: 10),

              Obx(
                    () => Text(
                  '${controller.steps.value}',
                  style: const TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.w900,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              const Text(
                'Current Status:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.black87),
              ),
              const SizedBox(height: 10),

              Obx(
                    () => Text(
                  controller.status.value.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: controller.status.value.contains('error') ||
                        controller.status.value.contains('denied')
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}