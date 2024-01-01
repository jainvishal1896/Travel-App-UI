import 'package:flutter/material.dart';
import 'package:glassmorphism/Common/common.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:glassmorphism/HomePage/PlaceDesc.dart';
import 'package:glassmorphism/Utils/utils.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

class HomePage extends StatefulWidget {
   const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
  Size size  =  MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar:true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("VagaBond", style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontStyle: FontStyle.italic,
                  fontFamily: "DancingScript",
                  fontSize: 40
                )),
        actions: [
          IconButton(onPressed: ()=>themeClass.toggle(), icon: ThemeClass.isDarkTheme?const Icon(Icons.brightness_5_outlined):const Icon(Icons.dark_mode))
        ],
      ),
      body: TweenAnimationBuilder(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 2000),
        child: PageContent(travellersData: travellersData, placesData: placesData),
        builder: (context,double aniValue ,child) {
          return ShaderMask(
            shaderCallback: (bounds) =>
            RadialGradient(
              radius: aniValue*5,
              colors:const [Colors.white, Colors.white, Colors.white, Colors.transparent],
              stops:const [0,0.55,0.66,1],
              center:const FractionalOffset(0.5,0.9)
          ).createShader(bounds), child: child, );
        }
      )
    
    );
  }
}

class PageContent extends StatelessWidget {
  List travellersData;
  List placesData;
  PageContent({Key? key, this.travellersData=const[], this.placesData=const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          OptimizedCacheImage(
            fadeInDuration:const Duration(seconds: 0),
            imageUrl: ThemeClass.isDarkTheme?"https://drive.google.com/uc?export=view&id=1ZaV1gXS61ozEWa7E9jcm0QRO5uXgZg8G":"https://drive.google.com/uc?export=view&id=1oT2fZQub3bk9XwEFAuQIA3DBiyMlDWMA",
            imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
              ),
            ),
          ),
          errorWidget: (context, url, error) =>const Icon(Icons.error),
        ),
         
          ListView(
            children: [
              CustomHDivider(title: "Expert Coaches",),
              SizedBox(
                height: 150,
                child: ListView.builder(shrinkWrap: true, scrollDirection: Axis.horizontal, itemCount:travellersData.length,
                itemBuilder: (BuildContext context, int index){
                  final traveller = travellersData[index];
                  return CustomIntoCard(
                    url: traveller['image'],
                    quote: '" ${traveller['quote']}"',
                    name: traveller['name'],
                  );
                }),
              ),
              CustomHDivider(title: "Famous Trekking Spot", leftwidth: 4.5, rightwidth: 5,),
              SizedBox(
                height: 250,
                child: ListView.builder(shrinkWrap: true, scrollDirection: Axis.horizontal, itemCount:placesData.length,
                itemBuilder: (BuildContext context, int index){
                  final place = placesData[index];
                  return GestureDetector(
                    onTap: (){Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context, animation, _){
            return PlaceDesc(place: place,);})).then((value) {if(value!=null){
              placesData[index]['isFav'] = value;
            }});},
                    child: CustomCard(
                      title: place['name'],
                      baseurl: place['imageData'][0]['url'],
                      rating: place['rating'].toString(),
                    ),
                  );
                }),
              ),
              CustomHDivider(title: "Tips from Experts", leftwidth: 3.8, rightwidth: 3.8,),
              CarouselSlider.builder(itemCount: travellersData.length, itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex){
                final rating = travellersData[itemIndex]['tips'];
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ThemeClass.isDarkTheme?const Color(0xff303030).withOpacity(0.6):const Color(0xfffffff).withOpacity(0.6),
                    borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  child: Center(child: Text(rating, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: ThemeClass.isDarkTheme?Colors.white:Colors.black),))
                );
              }, options: CarouselOptions(
                autoPlay: true,
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                height: 150,
                autoPlayAnimationDuration:const Duration(seconds: 2)
              ))
            ],
          ),
        ],
      );
  }
}
