import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/colors/colors.dart';
import 'package:weather_app/services/services.dart';
import 'package:weather_app/weatherData/weather_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    fetchWeatherInfo("london").then((data) {
      setState(() {
        weatherData = data;
      });
    });
    super.initState();
  }

  WeatherData? weatherData;
  final _changeLocationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    DateFormat dateFormat = DateFormat(
        'EEEE, d MMMM y'); // Format: "Day, Day of the Month, Month Year"
    String formattedDate = dateFormat.format(currentDate);

    void changeLocation() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: mainColor,
            content: Title(
              color: Colors.black,
              child: Text(
                "Change location",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            actions: [
              Column(
                children: [
                  TextField(
                    controller: _changeLocationController,
                    decoration: const InputDecoration(
                      hintText: "Enter the location",
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        child: IconButton(
                          onPressed: () async {
                            try {
                              WeatherData newWeatherData =
                                  await fetchWeatherInfo(
                                      _changeLocationController.text);
                              _changeLocationController.clear();
                              setState(() {
                                weatherData = newWeatherData;
                              });
                              Navigator.of(context).pop();
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Country/City not found, try correcting it"),
                                ),
                              );
                            }
                          },
                          icon: Icon(
                            Icons.change_circle_outlined,
                            color: mainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    double kelvinToCelsius(double kelvin) {
      return kelvin - 273.15;
    }

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    void _openDrawer() {
      _scaffoldKey.currentState?.openDrawer();
    }

    double temperature = kelvinToCelsius(weatherData?.temperature ?? 0);
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
          child: Container(
        color: mainColor,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const DrawerHeader(
                    child: Icon(
                      Icons.favorite,
                      size: 100,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.edit_location_alt_rounded,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Change location",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: changeLocation,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.cancel_sharp,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Go back",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      Icons.color_lens,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Themes",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        mainColor = const Color(0xFFF2C641);
                      });
                    },
                    leading: const Icon(
                      Icons.circle,
                      color: Color.fromARGB(255, 235, 212, 6),
                    ),
                    title: Text(
                      "Main",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        mainColor = Colors.white;
                      });
                    },
                    leading: Icon(
                      Icons.circle,
                      color: Colors.grey[100],
                    ),
                    title: Text(
                      "White",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        mainColor = secondMainColor;
                      });
                    },
                    leading: const Icon(
                      Icons.circle,
                      color: Colors.blue,
                    ),
                    title: Text(
                      "Blue",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        mainColor = thirdMainColor;
                      });
                    },
                    leading: Icon(
                      Icons.circle,
                      color: Colors.purple[200],
                    ),
                    title: Text(
                      "Pink",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 20),
                Text(
                  "Made with ❤️ by Fadile",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20)
          ],
        ),
      )),
      backgroundColor: mainColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _openDrawer();
                      },
                      child: const Icon(
                        Icons.menu,
                        size: 40,
                        color: Colors.black,
                      ),
                    ),
                    Text(weatherData?.name ?? "loading",
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                    IconButton(
                        onPressed: changeLocation,
                        icon: const Icon(
                          Icons.location_on,
                          size: 40,
                        ))
                  ],
                ),
                const SizedBox(height: 20),

                // current date time
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.black,
                  ),
                  child: Text(
                    formattedDate,
                    style: GoogleFonts.poppins(color: mainColor),
                  ),
                ),

                const SizedBox(height: 20),
                // The state of the weather !
                Text(
                  weatherData?.main ?? "loading",
                  style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                // the temperature
                Text(
                  "${kelvinToCelsius(weatherData?.temperature ?? 0).toStringAsFixed(0)}°",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: kelvinToCelsius(weatherData?.temperature ?? 0)
                                .toStringAsFixed(0)
                                .length >=
                            3
                        ? 110
                        : 180,
                  ),
                ),

                // Description
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Daily summary",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // The feeling of the weather
                    Text(
                        "Now it feels ${(temperature + 5).toStringAsFixed(0)}°C in ${weatherData?.name ?? "No name"} , actually ${temperature.toStringAsFixed(0)}. Today, the temperature is felt in the range from ${(temperature - 7).toStringAsFixed(0)}° to ${(temperature + 5).toStringAsFixed(0)}°"),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(14)),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    Icons.wind_power_outlined,
                                    color: mainColor,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "${weatherData?.windSpeed}km/h",
                                    style: GoogleFonts.poppins(
                                      color: mainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "wind",
                                    style: GoogleFonts.poppins(
                                      color: mainColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 40),
                              Column(
                                children: [
                                  Icon(
                                    Icons.water_drop_outlined,
                                    color: mainColor,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "${weatherData?.humidity}%",
                                    style: GoogleFonts.poppins(
                                      color: mainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Humidity",
                                    style:
                                        GoogleFonts.poppins(color: mainColor),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 40),
                              Column(
                                children: [
                                  Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: mainColor,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "${weatherData?.visibility}km",
                                    style: GoogleFonts.poppins(
                                      color: mainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Visibility",
                                    style:
                                        GoogleFonts.poppins(color: mainColor),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
