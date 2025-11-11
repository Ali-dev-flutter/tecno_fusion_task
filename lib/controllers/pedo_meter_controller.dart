import 'package:all_sensors/all_sensors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:async';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class PedoMeterController extends GetxController {
  final steps = 0.obs;
  final status = 'Awaiting Permissions...'.obs;

  final gyroscopeValues = <double>[0.0, 0.0, 0.0].obs;

  late StreamSubscription<StepCount> _stepSubscription;
  late StreamSubscription<PedestrianStatus> _statusSubscription;
  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;

  @override
  void onInit() {
    super.onInit();
    initSensors();
  }

  Future<void> initSensors() async {
    bool granted = await _requestActivityRecognitionPermission();
    if (granted) {
      initPedometer();
    } else {
      status.value = 'Permission Denied. Cannot track steps.';
    }
    initGyroscope();
  }

  Future<bool> _requestActivityRecognitionPermission() async {
    Permission permission;

    if (Platform.isAndroid) {
      permission = Permission.activityRecognition;
    } else if (Platform.isIOS) {
      permission = Permission.sensors;
    } else {
      return false;
    }

    PermissionStatus permissionStatus = await permission.request();

    if (permissionStatus.isGranted) {
      return true;
    } else if (permissionStatus.isPermanentlyDenied) {
      Get.snackbar(
        'Permission Required',
        'Physical Activity permission is permanently denied. Please enable it in settings.',
        mainButton: TextButton(
          child: const Text('Open Settings'),
          onPressed: () {
            openAppSettings();
          },
        ),
        duration: const Duration(seconds: 8),
      );
      return false;
    }
    return false;
  }

  void initPedometer() {
    try {
      _statusSubscription = Pedometer.pedestrianStatusStream
          .listen(onPedestrianStatusChanged, onError: onPedestrianStatusError);

      _stepSubscription = Pedometer.stepCountStream
          .listen(onStepCount, onError: onStepCountError);

      if (status.value != 'Permission Denied. Cannot track steps.') {
        status.value = "Pedometer Listening";
      }
    } catch (e) {
      status.value = "Pedometer Initialization Error: $e";
      print("Pedometer Initialization Error: $e");
    }
  }

  void initGyroscope() {
    _gyroscopeSubscription = gyroscopeEvents?.listen((GyroscopeEvent event) {
      gyroscopeValues.value = <double>[event.x, event.y, event.z];
    });
  }

  void onStepCount(StepCount event) {
    steps.value = event.steps;
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    status.value = event.status.toLowerCase();
  }

  void onPedestrianStatusError(error) {
    status.value = 'Status Error. Did you grant Physical Activity permission?';
    print('Pedestrian Status Error: $error');
  }

  void onStepCountError(error) {
    steps.value = 0;
    status.value = 'Step Count Error. Check permissions/device: $error';
    print('Step Count Error: $error');
  }

  @override
  void onClose() {
    _stepSubscription.cancel();
    _statusSubscription.cancel();
    _gyroscopeSubscription?.cancel();
    print("All sensor subscriptions canceled.");
    super.onClose();
  }
}