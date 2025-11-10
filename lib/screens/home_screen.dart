import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tecno_fusion_task/screens/pedo_meter_screen.dart';
import 'package:tecno_fusion_task/widgets/home_screen_widget.dart';
import '../controllers/home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeScreenController homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Projects'),
      ),
      body: Column(
        children: [
          Obx(() {
            if (homeScreenController.isLoading.isTrue) {
              return const Center(child: CircularProgressIndicator());
            }

            if (homeScreenController.projects.isEmpty) {
              return const Center(child: Text('No Data found.'));
            }

            return Expanded(
              child: ListView.builder(
                itemCount: homeScreenController.projects.length,
                itemBuilder: (context, index) {
                  return HomeScreenWidget(project: homeScreenController.projects[index]);
                },
              ),
            );
          }),
          SizedBox(height: 30,),
          InkWell(
            onTap: (){
              Get.to(PedoMeterScreen());
            },
            child: Container(
              height: 60,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pado Meter',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Icon(
                      Icons.directions_walk,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 50,),
        ],
      ),
    );
  }
}

