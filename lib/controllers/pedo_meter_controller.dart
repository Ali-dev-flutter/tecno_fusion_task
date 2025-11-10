import 'package:all_sensors/all_sensors.dart';
import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:async';

class PedoMeterController extends GetxController {
  final steps = 0.obs;
  final status = 'Awaiting Permissions...'.obs;
  List<double> gyroscopeValues = <double>[];
  List<StreamSubscription<dynamic>> _streamSubscriptions = <StreamSubscription<dynamic>>[];

  late StreamSubscription<StepCount> _stepSubscription;
  late StreamSubscription<PedestrianStatus> _statusSubscription;

  @override
  void onInit() {
    super.onInit();
    _streamSubscriptions.add(gyroscopeEvents!.listen((GyroscopeEvent event) {
        gyroscopeValues = <double>[event.x, event.y, event.z];
        print('Gyroscope: $gyroscopeValues');
    }));
    initPedometer();
  }

  void initPedometer() {
    try {
      _statusSubscription = Pedometer.pedestrianStatusStream
          .listen(onPedestrianStatusChanged, onError: onPedestrianStatusError);

      _stepSubscription = Pedometer.stepCountStream
          .listen(onStepCount, onError: onStepCountError);

      status.value = "Pedometer Listening";

    } catch (e) {
      status.value = "Pedometer Initialization Error: $e";
      print("Pedometer Initialization Error: $e");
    }
  }

  void onStepCount(StepCount event) {
    steps.value = event.steps;
    print('Steps: ${event.steps}');
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    status.value = event.status.toLowerCase();
    print('Status: ${event.status}');
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
    print("Pedometer subscriptions canceled.");
    super.onClose();
  }
}