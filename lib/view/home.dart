import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/homeController.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/colorConstant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController city_controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadCityName();
  }

  Future loadCityName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cityName = prefs.getString('city_name');
    if (cityName != null) {
      setState(() {
        city_controller.text = cityName;
        Provider.of<HomeController>(context, listen: false)
            .fetchData(city_controller.text, context);
      });
    }
  }

  Widget build(BuildContext context) {
    Future saveCityName(String city_name) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('city_name', city_name);
    }

    var homeController = Provider.of<HomeController>(context);
    return Scaffold(
      backgroundColor: ColorConstant.primary,

      // backgroundColor: ,
      appBar: AppBar(
        backgroundColor: ColorConstant.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Weather App",
              style: TextStyle(
                  color: ColorConstant.secondary, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.cloud,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter a city name to get weather information",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.secondary,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: city_controller,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    BeveledRectangleBorder(
                                        side: BorderSide(
                                            color: Color.fromARGB(
                                                255, 173, 173, 173)))),
                              ),
                              icon: Icon(Icons.search,
                                  color: ColorConstant.secondary),
                              onPressed: () {
                                if (city_controller == null ||
                                    city_controller.text.isEmpty) {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                          height: 100,
                                          width: double.infinity,
                                          child: Center(
                                            child: Text("City name is empty"),
                                          ));
                                    },
                                  );
                                } else if (!RegExp(r'^[a-zA-Z\s]+$')
                                    .hasMatch(city_controller.text)) {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: 100,
                                        width: double.infinity,
                                        child: Center(
                                          child: Text(
                                              "Invalid city name. Only letters and spaces are allowed."),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  saveCityName(city_controller.text);
                                  Provider.of<HomeController>(context,
                                          listen: false)
                                      .fetchData(city_controller.text, context);
                                }
                              },
                            ),
                          ),
                          label: Text(
                            "City",
                            style: TextStyle(color: ColorConstant.secondary),
                          ),
                          hintText: "City",
                          hintStyle: TextStyle(color: ColorConstant.secondary),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    homeController.responseData != null
                        ? Container(
                            decoration: BoxDecoration(
                                color: ColorConstant.tertiary,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.2),
                                    blurRadius: 2,
                                    offset: Offset(2, 4),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            height: MediaQuery.sizeOf(context).height / 3,
                            width: MediaQuery.sizeOf(context).width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.sizeOf(context).width / 2,
                                    height: double.maxFinite,
                                    // color: Colors.amber,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              textAlign: TextAlign.start,
                                              "Name",
                                              style: TextStyle(
                                                  color: Colors.white54,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.location_city,
                                              color: Color.fromARGB(
                                                  255, 252, 236, 231),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Weather Condition",
                                              style: TextStyle(
                                                  color: Colors.white54,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.sunny_snowing,
                                              color: Colors.amber,
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Temperature",
                                              style: TextStyle(
                                                  color: ColorConstant.white54,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.thermostat,
                                              color: Color.fromARGB(
                                                  255, 255, 155, 148),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Humidity",
                                              style: TextStyle(
                                                  color: ColorConstant.white54,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.water_drop_outlined,
                                              color: Colors.blue,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: double.maxFinite,

                                    //  MainAxisAlignment.spaceAround,

                                    // width: MediaQuery.sizeOf(context).width / 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          homeController.responseData!.name ??
                                              "Null",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: ColorConstant.white54,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          homeController.responseData!
                                                  .weather[0].description ??
                                              "Null",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: ColorConstant.white54,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          textAlign: TextAlign.right,
                                          " ${homeController.responseData!.main.temp != null ? homeController.responseData!.main.temp.toString() : 'No data available'}°C",
                                          style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          textAlign: TextAlign.right,
                                          " ${homeController.responseData!.main.humidity != null ? homeController.responseData!.main.temp.toString() : 'No data available'}°C",
                                          style: TextStyle(
                                            color: ColorConstant.white54,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              // child: Column(
                              //   // crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Text(
                              //       "Weather Information - ${city_controller.text}",
                              //       style: TextStyle(
                              //           fontSize: 18,
                              //           fontWeight: FontWeight.bold,
                              //           color: Colors.red),
                              //     ),
                              //     Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceEvenly,
                              //       children: [
                              //         Text(
                              //           "Name",
                              //           style: TextStyle(
                              //             color: Colors.white54,
                              //           ),
                              //         ),
                              //         Text(
                              //           homeController.responseData!.name ??
                              //               "Null",
                              //           style: TextStyle(
                              //               fontSize: 18,
                              //               color: Colors.white54,
                              //               fontWeight: FontWeight.bold),
                              //         ),
                              //       ],
                              //     ),
                              //     Row(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceEvenly,
                              //       children: [
                              //         Text(
                              //           "Weather Condition",
                              //           style: TextStyle(color: Colors.white54),
                              //           textAlign: TextAlign.left,
                              //         ),
                              //         Text(
                              //           homeController.responseData!.weather[0]
                              //                   .description ??
                              //               "Null",
                              //           style: TextStyle(
                              //               color: Colors.white54,
                              //               fontSize: 18,
                              //               fontWeight: FontWeight.bold),
                              //         ),
                              //       ],
                              //     ),
                              //     Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceEvenly,
                              //       children: [
                              //         // Container()
                              //         Text(
                              //           "Temperature",
                              //           style: TextStyle(color: Colors.white54),
                              //           textAlign: TextAlign.left,
                              //         ),
                              //         Text(
                              //           textAlign: TextAlign.right,
                              //           " ${homeController.responseData!.main.temp != null ? homeController.responseData!.main.temp.toString() : 'No data available'}°C",
                              //           style: TextStyle(
                              //             color: Colors.white54,
                              //             fontSize: 18,
                              //             fontWeight: FontWeight.bold,
                              //           ),
                              //         )
                              //       ],
                              //     ),
                              //     Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceEvenly,
                              //       children: [
                              //         Text(
                              //           "Humidity",
                              //           style: TextStyle(
                              //             color: Colors.white54,
                              //           ),
                              //           textAlign: TextAlign.left,
                              //         ),
                              //         Text(
                              //           textAlign: TextAlign.right,
                              //           " ${homeController.responseData!.main.humidity != null ? homeController.responseData!.main.temp.toString() : 'No data available'}°C",
                              //           style: TextStyle(
                              //             color: Colors.white54,
                              //             fontSize: 18,
                              //             fontWeight: FontWeight.bold,
                              //           ),
                              //         )
                              //       ],
                              //     ),
                              //   ],
                              // ),
                            ),
                          )
                        : Text(
                            "No data available",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
