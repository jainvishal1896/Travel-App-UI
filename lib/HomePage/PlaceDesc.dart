import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:glassmorphism/Common/common.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

class PlaceDesc extends StatefulWidget {
  Map<String,dynamic> place;
  PlaceDesc({Key? key, this.place=const{}}) : super(key: key);

  @override
  State<PlaceDesc> createState() => _PlaceDescState();
}

class _PlaceDescState extends State<PlaceDesc> {
  bool isFav = false;

  @override
  void initState(){
    super.initState();
    isFav = widget.place['isFav'];
  }
  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = ThemeClass.isDarkTheme;
    final size = MediaQuery.of(context).size;
    final place = widget.place;
    return DefaultTabController(
      length: 2,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            SizedBox(
              height: size.height/2.2,
              child: Stack(children: [
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: place['imageData'].length,
                    itemBuilder: (context, index){
                      final image = place['imageData'];
                      return BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: OptimizedCacheImage(
                          imageUrl: image[index]['url'],
                          imageBuilder: (context, imageProvider) => Container(
                            width: size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                ),
                            ),
                          ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      );
                    },),
                  Positioned(
                  left: 20,
                  top: 50,
                  child: 
                    GestureDetector(
                      onTap: () => Navigator.pop(context, isFav),
                    child: Container(
                      width: 40,
                      height:40,
                      decoration: BoxDecoration(
                        color: const Color(0xff121212).withOpacity(0.5),
                        border:Border.all(color: Colors.white, width: 1),
                        borderRadius: const BorderRadius.all(Radius.circular(5))
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,)
                    ),
                  ),
                  ),
                  Positioned(
                  right: 20,
                  bottom: 30,
                  child: Container(
                    width: 50,
                    height:50,
                    decoration: BoxDecoration(
                      color: const Color(0xff121212).withOpacity(0.3),
                      border:Border.all(color: Colors.white, width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(5))
                    ),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          isFav = !isFav;
                        });
                      },
                      child: isFav?const Icon(Icons.bookmark_outlined, color: Colors.white, size: 30, ):const Icon(Icons.bookmark_add_outlined, color: Colors.white, size: 30, ))
                  ),
                  ),
                  Positioned(
                  left: 20,
                  bottom: 30,
                  child: RichText(text: TextSpan(
                    children: [
                      TextSpan(
                        text: place['name']+"\n",
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white, fontFamily: "GreatVibes", fontStyle: FontStyle.italic, fontSize: 50)
                      ),
                      const WidgetSpan(child:Icon(Icons.location_on_outlined, color: Colors.white,)),
                      TextSpan(
                        text:" ${place['loc']}",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontFamily: "Montserrat")
                        )
                      ]
                    ))
                    )
                  ]),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                    padding:const EdgeInsets.only(top:10, right: 10),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0, end: double.parse(place['alt'].toString())),
                          duration: const Duration(seconds: 1),
                          builder: (BuildContext context, double value, Widget? child) {
                            return GlassMorphism(
                              color:Theme.of(context).primaryColor,
                              startOpacity: 0.6,
                              endOpacity: 0.3,
                              child:Container(
                          padding:const EdgeInsets.all(10),
                          width: 180,
                          height:100,
                          child: RichText(
                            text:TextSpan(
                            children: [
                              TextSpan(
                                text: "Altitude\n", style: Theme.of(context).textTheme.titleLarge
                              ),
                              const WidgetSpan(child: SizedBox(height:40,)),
                              TextSpan(text: "$value",style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 30, 
                                color: isDarkTheme? Colors.white:Theme.of(context).colorScheme.onPrimary
                              )),
                              TextSpan(text: " meters",style: Theme.of(context).textTheme.titleSmall)
                            ]
                          ),)
                        ));
                        },
                      ),
                       GlassMorphism(
                        color: Theme.of(context).primaryColor,
                        startOpacity: 0.6,
                        endOpacity: 0.3,
                        child: Container(
                          padding:const EdgeInsets.all(10),
                          width: 180,
                          height:100,
                          child: RichText(
                            text:TextSpan(
                            children: [
                              TextSpan(
                                text: "Best Season\n", style: Theme.of(context).textTheme.titleLarge
                              ),
                              const WidgetSpan(child: SizedBox(height:20,)),
                              TextSpan(text: place['startMonth'],style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: isDarkTheme? Colors.white:Colors.grey[700]
                                )),
                              TextSpan(text: " and\n",style: Theme.of(context).textTheme.titleSmall),
                              TextSpan(text: place['endMonth'],style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                   color: isDarkTheme? Colors.white:Colors.grey[700]
                                )),
                                ]
                              ),)
                            )),
                          ],
                        ),
                    ),
                    Padding(
                      padding:const EdgeInsets.only(top:10),
                      child: Material(
                        color: Colors.white,
                        child: TabBar(
                          automaticIndicatorColorAdjustment: true,
                          labelColor: primaryColor,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Colors.transparent,
                          labelStyle: Theme.of(context).textTheme.titleLarge,
                          tabs:const [
                          Tab(text: "Description",),
                          Tab(text: "Location"),
                        ]),
                      ),
                    ),
                SizedBox(
                  height: size.height/4,
                  child: TabBarView(
                  children:[
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Text(place['desc'],
                      // overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20 ),
                      ),
                    ),
                    Container(
                      color: Colors.blue,
                    )
                  ]
                ),
                ),
    
              ],
            )
          ],
        ),
      ),
    );
    
  }
}