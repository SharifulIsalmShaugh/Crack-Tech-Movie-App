import 'package:cached_network_image/cached_network_image.dart';
import 'package:crack_tech_app/app/modules/home/controllers/home_controller.dart';
import 'package:crack_tech_app/utils/network/connectionManagerController.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/loaderWidget.dart';


class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ConnectionManagerController networkConnectionController = Get.find<ConnectionManagerController>();
    return SafeArea(
      child: Obx(() => networkConnectionController.connectionType.value !=0? Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 60),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            color: AppColors.primaryColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {

                    },
                    child: const Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 6.0, vertical: 2),
                      child: Icon(
                        Icons.dehaze,
                        size: 24,
                        color: AppColors.secondaryColor,
                      ),
                    )),

                const Text("Movie Online",style: TextStyle(color: AppColors.secondaryColor,fontSize: 14,fontWeight: FontWeight.w600),),
                const CircleAvatar(
                  radius: 32, // Image radius
                  backgroundImage: AssetImage('assets/icons/app-logo.jpeg'),
                )
              ],
            ),
          ),
        ),
        body:Obx(() =>controller.movieData.value.genres != null? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Container(
            height: 38,
            margin: const EdgeInsets.all(8),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: controller.movieData.value.genres!.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){
                    controller.selectedGenres(index,controller.movieData.value.genres!.elementAt(index));
                  },
                  child: Obx(() =>Container(
                    height: 36,
                    margin: const EdgeInsets.only(left:4,right: 4),
                    child: Container(
                      decoration: BoxDecoration(
                        color: controller.selectedIndex.value == index?AppColors.secondaryColor:AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                          color: Colors.black, // Border color
                          width: 1.0, // Border width
                        ),
                      ),
                      child:Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(controller.movieData.value.genres!.elementAt(index),
                            style:  TextStyle(
                                fontWeight: FontWeight.w500,
                                color: controller.selectedIndex.value == index?AppColors.primaryColor:AppColors.secondaryColor,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ),
                );
              },
            ),
          ),
          Container(
            child:Padding(
              padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 16),
              child: Text("${controller.filteredMovies.value.length} ${controller.selectedName.value} Movies",
                style:  const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryColor,
                    fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: controller.filteredMovies.length,
                itemBuilder: (BuildContext context, int i) {
                  return InkWell(
                    onTap: (){
                      controller.navigateToDetails(controller.filteredMovies.elementAt(i));
                    },
                    child: Obx(() =>Container(
                      height: 157,
                      margin: EdgeInsets.symmetric(vertical:8,horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: Colors.black, // Border color
                          width: 0.2, // Border width
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: CachedNetworkImage(
                                  imageUrl: controller.filteredMovies.value.elementAt(i).posterUrl!,
                                  width: 115,
                                  height: 133,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                                    ),
                                  ), // Placeholder while the image is loading.
                                  errorWidget: (context, url, error) => const Icon(Icons.error,size: 48,), // Widget to display when an error occurs.
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 16),
                                //height: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom:4.0),
                                    child: Text(controller.filteredMovies.value.elementAt(i).title!,
                                      softWrap: true,
                                      style:  const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.secondaryColor,
                                          fontSize: 16),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom:4.0),
                                    child: Text("Year: ${controller.filteredMovies.value.elementAt(i).year!}",
                                      style:  const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.secondaryColor,
                                          fontSize: 14),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(bottom:4.0),
                                    child: Text("Director:",
                                      style:  TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                          fontSize: 14),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom:4.0),
                                    child: Text(controller.filteredMovies.value.elementAt(i).director!,
                                      style:  const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.secondaryColor,
                                          fontSize: 14),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ),
                  );
                },
              ),
            ),
        ],): Center(
          child: Obx(() =>controller.isLoading.value?LoaderWidget():Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding:  EdgeInsets.all(10.0),
                  child: Text("Movie data not found.",textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600,),),
                ),
              ],
            ),
          )),
        ),)
      ):
    Scaffold(body:Center(child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/loader/ic_No_Internet.png",height: 100,width: 100,),
        const Text("No Internet Connection"),
      ],
    ),
    ),
    ),
      ),
    );
  }
}
