import 'package:flutter/material.dart';
import 'package:glassmorphism/Common/common.dart';
import 'package:glassmorphism/HomePage/HomePage.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        OptimizedCacheImage(
            imageUrl: ThemeClass.isDarkTheme?"https://drive.google.com/uc?export=view&id=1Nnjh2tnbtAzAW55fJg3iW_qr0cf4el3X":"https://drive.google.com/uc?export=view&id=1lu0E9ZcUThzLHDpAsGDxc6iz6eoBuIju",
            imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
              ),
            ),
          ),
            // placeholder: (context, url) => Transform.scale(scale:0.6,child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(image: ThemeClass.isDarkTheme?AssetImage("assets/images/webp/bg.webp"): AssetImage("assets/images/webp/bglow.webp"), fit: BoxFit.cover
        //     )
        //   ),
        // ),
          Center(
            child:   RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(text: "The", style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Colors.white
                )),
                TextSpan(text: "\nVagabond's", style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Colors.white
                )),
                TextSpan(text: "\nWay", style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Colors.white
                )),
            ])),
                    
          ),
          Positioned(
            left: MediaQuery.of(context).size.width*0.17,
            bottom: 50,
            child: ElevatedButton(onPressed: (){
                      Navigator.of(context).push(
                        PageRouteBuilder(pageBuilder: (context, animation, _){
            return HomePage();
                        }, opaque: false)
                      );
                    }, style: ElevatedButton.styleFrom(
                      fixedSize:Size(MediaQuery.of(context).size.width/1.5, 60),
                      shape: StadiumBorder()
                    ),
                    child: Text("Get Started", style: Theme.of(context).textTheme.titleLarge,),
                    ),
          )
       
      ],
    );
  }
}