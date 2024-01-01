import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

const primaryColor = Color(0xffF79256);

ThemeClass themeClass = ThemeClass();

class ThemeClass with ChangeNotifier{
  static bool isDarkTheme = false;
  ThemeMode get currentTheme => isDarkTheme? ThemeMode.dark:ThemeMode.light;

  void toggle(){
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }

  static final darkTheme=ThemeData(
    fontFamily:"Montserrat",
    textTheme: const TextTheme(
    headlineSmall: TextStyle(color: Color(0xffFBD1A2)),
    titleLarge: TextStyle(color: Color(0xffFBD1A2))
  ),
  elevatedButtonTheme: const ElevatedButtonThemeData(),
  iconTheme:const IconThemeData(color: Colors.white),
  primaryColor: const Color(0xff1B2845),
  colorScheme: const  ColorScheme.highContrastLight(
    primary: Color(0xff1B2845),
    onPrimary: Color(0xffFBD1A2),
    secondary: Color(0xffFBD1A2),
    tertiary: Color(0xff7DCFB6),
    
  )
);

static final lightTheme=ThemeData(
  fontFamily:"Montserrat",
  primaryColor: const Color(0xffF79256),
  colorScheme: const  ColorScheme.highContrastLight(
    primary: Color(0xffF79256),
    onPrimary: Color(0xff121212),
    secondary: Color(0xffFBD1A2),
    tertiary: Color(0xff7DCFB6),

  )

);
}

class CustomHDivider extends StatelessWidget {
  String title;
  double leftwidth;
  double rightwidth;
  CustomHDivider({Key? key, this.title='', this.leftwidth=3.4, this.rightwidth=3.4}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = ThemeClass.isDarkTheme? Colors.white:Colors.black;
    return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(left:20,),
                  width: MediaQuery.of(context).size.width/leftwidth,
                  height: 50,
                  child: Divider(color:color,thickness: 1,)),
                 RichText(text: TextSpan(children:[const WidgetSpan(child: SizedBox(width:10)),TextSpan(text: title, style: Theme.of(context).textTheme.titleLarge)])),
                 Container(
                  padding: const EdgeInsets.only(left:10),
                  width:  MediaQuery.of(context).size.width/rightwidth,
                  height: 50,
                  child: Divider(color: color,thickness: 1,)),
              ],
            );
  }
}

class CustomIntoCard extends StatelessWidget {
  String title;
  String url;
  String quote;
  String name;
  CustomIntoCard({Key? key, this.title='', this.url="", this.quote="", this.name=""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xff121212).withOpacity(0.3),
                    borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  width: 350,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color:Colors.grey.shade400, width: 5),
                            color: Colors.white,
                            shape: BoxShape.circle
                          ),
                          child: OptimizedCacheImage(
                            imageUrl: url,
                            imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.contain,
                              ),
                            ),
                          ),
                            placeholder: (context, url) => Transform.scale(scale:0.6,child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                          ),
                          
                      ],
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 100,
                        width: 230,
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text(quote, style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontFamily: "DancingScript", color: Colors.white),),
                      ),
                          Text("- $name", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),)
                    ],
                  ),
                  ],),
                );
    
  }
}

class CustomCard extends StatelessWidget {
  String title;
  String baseurl;
  String rating;
  CustomCard({Key? key, this.title='', this.baseurl='assets/images/', this.rating="0.0"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = 0;
    double height = 0;
    Image(image: NetworkImage(baseurl))
    .image
    .resolve(const ImageConfiguration())
    .addListener(ImageStreamListener((ImageInfo info, bool _) {
      width = double.parse(info.image.width.toString());
      height = double.parse(info.image.height.toString());
     })); 
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            width: 350,
            margin: const EdgeInsets.all(6),
            child: OptimizedCacheImage(
            imageUrl: baseurl,
            imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
            ),
          ),
            placeholder: (context, url) => Transform.scale(scale:0.6,child: const CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        ),
        Positioned(
          right: 20,
          top: 20,
          child: Container(
            width: 50,
            height:50,
            decoration: BoxDecoration(
              color: const Color(0xff121212).withOpacity(0.3),
              border:Border.all(color: Colors.white, width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(5))
            ),
            child: Center(child: Text(rating, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),)),
          ),
        ),
            Text(title, style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontFamily: "GreatVibes", fontWeight: FontWeight.w700, fontSize: 60, color: Theme.of(context).secondaryHeaderColor)),


      ],
    ); 
  }
}

Color calculateTextColor(Color background) {
  return ThemeData.estimateBrightnessForColor(background) == Brightness.light ? Colors.black : Colors.white;
}


class GlassMorphism extends StatelessWidget {
  final Widget child;
  final double startOpacity;
  final double endOpacity;
  final Color color;
  const GlassMorphism({
    Key? key,
    required this.child,
    this.color=const Color(0xff303030),
    this.startOpacity = 0.7,
    this.endOpacity = 0.6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(startOpacity),
                color.withOpacity(endOpacity),
              ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: child,
        ),
      ),
    );
      }
    
  }


