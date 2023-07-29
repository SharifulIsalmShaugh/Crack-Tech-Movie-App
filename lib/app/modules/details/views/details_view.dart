
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import '../controllers/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  const DetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Obx(()  =>controller.movieData.value.posterUrl != null?Stack(
          alignment: Alignment.topLeft,
          children: [
            Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height/2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(controller.movieData.value.posterUrl!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 5.0, // (background container size) - (circle height / 2)
              child: InkWell(
                onTap: (){
                  Get.back();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 8),
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(.7)
                  ),
                  child: const Center(child: Icon(Icons.arrow_back_ios,color: AppColors.primaryColor,size: 24,)),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height/2.2,
              child: Container(
                height: MediaQuery.of(context).size.height/1.8,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    color: AppColors.primaryColor
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 16,top: 16),
                  //height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 40,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListView.builder(
                          shrinkWrap: false,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.movieData.value.genres!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Obx(() =>Container(
                              margin: const EdgeInsets.only(left:0,right: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(25.0),
                                  border: Border.all(
                                    color: Colors.black, // Border color
                                    width: 0.3, // Border width
                                  ),
                                ),
                                child:Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(controller.movieData.value.genres!.elementAt(index),
                                      style:  const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.secondaryColor,
                                          fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            );
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom:16.0),
                        child: Text(controller.movieData.value.title!,
                          softWrap: true,
                          style:  const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.secondaryColor,
                              fontSize: 16),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom:16.0),
                        child: Text("Year: ${controller.movieData.value.year!}",
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
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryColor,
                              fontSize: 16),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom:16.0),
                        child: Text(controller.movieData.value.director!,
                          style:  const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryColor,
                              fontSize: 14),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom:4.0),
                        child: Text("Actors:",
                          style:  TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryColor,
                              fontSize: 16),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom:16.0),
                        child: Text(controller.movieData.value.actors!,
                          style:  const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryColor,
                              fontSize: 14),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom:4.0),
                        child: Text("Plot:",
                          style:  TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryColor,
                              fontSize: 16),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom:16.0),
                        child: Text(controller.movieData.value.plot!,
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
            )
          ],
        ):const SizedBox(),),
      ),
    );
  }
}
