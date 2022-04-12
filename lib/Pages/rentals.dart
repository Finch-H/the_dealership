import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:the_dealership/widgets/bottom_nav_bar.dart';
import 'package:the_dealership/widgets/bottom_nav_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dealership/widgets/drawer.dart';
import 'package:the_dealership/widgets/homePage/fleets.dart';
import 'package:the_dealership/widgets/homePage/most_rented.dart';
import 'package:the_dealership/widgets/homePage/top_brands.dart';
import 'package:unicons/unicons.dart';

class RentalPage extends StatefulWidget {
  const RentalPage({Key? key}) : super(key: key);

  @override
  _RentalPageState createState() => _RentalPageState();
}

class _RentalPageState extends State<RentalPage> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  bool drawerOpen = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //check the size of device
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness ==
        Brightness.dark; //check if device is in dark or light mode

    return Scaffold(
      key: scaffoldKey,
      drawer: MyDrawer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0), //appbar size
        child: AppBar(
          shadowColor: Colors.transparent,

          backgroundColor:
          isDarkMode ? const Color(0xff06090d) : const Color(0xfff8f8f8),
          leading: Builder(
              builder: (context) => IconButton(
                icon: new Icon(
                  Icons.menu,
                  color: isDarkMode
                      ? Colors.white
                      : Colors.black, //icon bg color
                  size: size.height * 0.025,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
                // ),
                //       bottomOpacity: 0.0,
                //       elevation: 0.0,
                //       shadowColor: Colors.transparent,
                //       backgroundColor:
                //           isDarkMode ? const Color(0xff06090d) : const Color(0xfff8f8f8),
                //       //appbar bg color
                //       leading: Padding(
                //         padding: EdgeInsets.only(
                //           left: size.width * 0.05,
                //         ),
                //         child: SizedBox(
                //           height: size.width * 0.1,
                //           width: size.width * 0.1,
                //
                //
                //          child: Container(
                //                 decoration: BoxDecoration(
                //                   color: isDarkMode
                //                       ? const Color(0xff070606)
                //                       : Colors.white, //icon bg color
                //                   borderRadius: const BorderRadius.all(
                //                     Radius.circular(
                //                       10,
                //                     ),
                //                   ),
                //                 ),
                //
                //
                //                   child: IconButton(
                //
                //
                //
                //                     icon:
                //                     Icon(
                //                       UniconsLine.bars,
                //                       color: isDarkMode
                //                           ? Colors.white
                //                           : Colors.black, //icon bg color
                //                       size: size.height * 0.025,
                //                     ),
                //             onPressed: ()=> Scaffold.of(context).openDrawer(),
                //                   ),
                //                 ),
                //               ),
                //        ),
              )),

          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leadingWidth: size.width * 0.15,
          title: Text("DEALERSHIP",
              style: GoogleFonts.poppins(
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: size.width * 0.06,
                fontWeight: FontWeight.bold,
              )),

          // Image.asset(
          //   isDarkMode
          //       ? 'assets/icons/SobGOGlight.png'
          //       : 'assets/icons/SobGOGdark.png', //logo
          //   height: size.height * 0.06,
          //   width: size.width * 0.35,
          // ),
          centerTitle: true,
                ),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,

      body: Center(
        child: Container(
          height: size.height,
          width: size.height,
          decoration: BoxDecoration(
            color: isDarkMode
                ? const Color(0xff06090d)
                : const Color(0xfff8f8f8), //background color
          ),
          child: SafeArea(
            child: ListView(
              children: [

                Positioned.fill(
                  child: CachedNetworkImage(
                    placeholder: (context, _) => Container(
                      color: Colors.black26,
                    ),
                    imageUrl: item.url,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.04,
                    left: size.width * 0.05,
                    right: size.width * 0.05,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: isDarkMode
                          ? const Color(0xff070606)
                          : Colors.white, //section bg color
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.04,
                          ),
                          child: Align(
                            child: Text(
                              'With Corporate Difference',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: isDarkMode ? Colors.white : Colors.black,
                                fontSize: size.width * 0.06,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.01,
                          ),
                          child: Align(
                            child: Text(
                              'Enjoy Driving In Style',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: isDarkMode ? Colors.white : Colors.black,
                                fontSize: size.width * 0.035,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.03,
                            left: size.width * 0.04,
                            bottom: size.height * 0.025,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.65,
                                height: size.height * 0.06,
                                child: TextField(
                                  //searchbar
                                  style: GoogleFonts.poppins(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      top: size.height * 0.01,
                                      left: size.width * 0.04,
                                      right: size.width * 0.04,
                                    ),
                                    enabledBorder: textFieldBorder(),
                                    focusedBorder: textFieldBorder(),
                                    border: textFieldBorder(),
                                    hintStyle: GoogleFonts.poppins(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    hintText: 'Search a car',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: size.width * 0.025,
                                ),
                                child: Container(
                                  height: size.height * 0.06,
                                  width: size.width * 0.14,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        10,
                                      ),
                                    ),
                                    color: Colors.black, //filters bg color
                                  ),
                                  child: Icon(
                                    UniconsLine.sliders_v,
                                    color: Colors.white,
                                    size: size.height * 0.032,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // buildTopBrands(size, isDarkMode),
                buildMostRented(size, isDarkMode),

              ],
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder textFieldBorder() {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.5),
        width: 1.0,
      ),
    );
  }

  void resetApp() {
    setState(() {
      drawerOpen = true;
    });
  }
}
