import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
          home: PhotoGalleryPage(),
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
              padding: EdgeInsets.symmetric(horizontal: 30),
              backgroundColor: Color(0xff2CAB00),

            )
          )
        ),

      ));

}

class PhotoGalleryPage extends StatelessWidget {
  final List<Map<String, String>> photos = [
    {"title": "Beach", "image": "assets/1.jpeg"},
    {"title": "Mountain", "image": "assets/2.jpeg"},
    {"title": "City", "image": "assets/3.jpeg"},
    {"title": "Forest", "image": "assets/4.jpeg"},
    {"title": "Desert", "image": "assets/5.jpeg"},
    {"title": "Lake", "image": "assets/6.jpeg"},
    {"title": "River", "image": "assets/7.jpeg"},
    {"title": "Ocean", "image": "assets/8.jpeg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Gallery",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Color(0xff2CAB00),

        leading: Container(
          child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white,),

            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
            color: Color(0xff7ACA5E),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),


            )
        ),

        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white,),
            onPressed: () {},
          ),

        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
              crossAxisSpacing: 20,
              mainAxisSpacing: 17,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            itemCount: photos.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageDetailPage(
                      title: photos[index]["title"]!,
                      imagePath: photos[index]["image"]!,
                    ),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: AssetImage(photos[index]["image"]!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        photos[index]["title"]!,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}



class ImageDetailPage extends StatelessWidget {
  final String title;
  final String imagePath;

  ImageDetailPage({required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Color(0xff2CAB00),
        leading: Container(
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xff7ACA5E),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),


            )
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? buildPortraitLayout(context)
              : buildLandscapeLayout(context);
        },
      ),
    );
  }

  Widget buildPortraitLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildImage(),
          buildTextContent(),
      SizedBox(height: 10,),
          Padding(

            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(onPressed: () {}, child: Text("See More", style: TextStyle(color: Colors.white, fontSize: 20 ),)),
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.topLeft,
            child: Text("Suggestions",style: TextStyle(
              color: Color(0xff2CAB00),
            fontSize: 17
            ),
              textAlign: TextAlign.left,

            ),
          ),
          SizedBox(height: 10,),
          buildAdditionalImages(2) // For portrait mode
        ],
      ),
    );
  }

  Widget buildLandscapeLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [

          Expanded(child: buildImage()),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildTextContent(),
                ElevatedButton(onPressed: () {}, child: Text("See More",
                style: TextStyle(color: Colors.white),)),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.all(8.0),
                    child: Text("Suggestions", style: TextStyle(color: Color(0xff2CAB00),),),
                    alignment: Alignment.topLeft,
                ),
                buildAdditionalImages(1) // For landscape mode, adjust as needed
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: 300, // Fixed height
          width: double.infinity, // Takes full width available
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget buildTextContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 10,),
          Text(
            "Detailed description of the image goes here. It can be longer and more elaborate, and is justified.",
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget buildAdditionalImages(int i) {
    // Mock data for additional images, replace with actual data as necessary
    List<Map<String, String>> additionalPhotos = [
      {"title": "Sunset", "image": "assets/4.jpeg"},
      {"title": "Snow", "image": "assets/6.jpeg"},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 17,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      itemCount: additionalPhotos.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              image: AssetImage(additionalPhotos[index]["image"]!),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                additionalPhotos[index]["title"]!,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}