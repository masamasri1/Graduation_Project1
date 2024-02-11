import 'package:flutter/material.dart';
import 'package:graduation_project/files/cleaningpage.dart';
import 'package:graduation_project/files/menu.dart';
import 'package:graduation_project/files/pages.dart';

class crafts extends StatefulWidget {
  // const crafts({Key? key}) : super(key: key);
  final String userName;

  crafts({required this.userName});

  @override
  craftsState createState() => craftsState();
}

class craftsState extends State<crafts> {
  bool isSearching = false;
  final searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose(); // Clean up the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 255, 255),
      child: SafeArea(
        child: Scaffold(
          drawer: menu(userName: widget.userName),
          body: ListView(
            children: [
              Container(
                child: AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Expanded(
                      //   child: TextField(
                      //     controller: searchController,
                      //     decoration: InputDecoration(
                      //       hintText: "Search here",
                      //     ),
                      //   ),
                      // ),
                      Row(
                        children: [
                          // IconButton(
                          //     onPressed: () async {
                          //       if (isSearching) {
                          //         // Execute the search
                          //         String title = searchController.text;
                          //         //   List<dynamic> results = await searchByTitle(title);
                          //         //  print(results);
                          //         // You can update the UI using setState() with the search results
                          //       }
                          //       setState(() {
                          //         this.isSearching = !this.isSearching;
                          //       });
                          //     },
                          //     icon: Icon(Icons.search)),
                          SizedBox(
                            width: 270,
                          ),
                          Icon(Icons.notifications),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Text('Which service do you want?',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 50),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // To space the buttons
                children: [
                  Expanded(
                    child: serviceButton(
                      id: 1,
                      title: 'Carpenter',
                      iconPath: "lib/icon/icons8-carpenter-64.png",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => cleaningpage(
                                      jop_id: 1,
                                      userName: widget.userName,
                                    )));
                      },
                    ),
                  ),
                  SizedBox(width: 15), // Space between the buttons
                  Expanded(
                    child: serviceButton(
                      id: 2,
                      title: 'Cleaning',
                      iconPath: "lib/icon/icons8-cleaning-64.png",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => cleaningpage(
                                      jop_id: 2,
                                      userName: widget.userName,
                                    )));
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: serviceButton(
                      id: 3,
                      title: 'Driver',
                      iconPath: "lib/icon/icons8-driver-64.png",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => cleaningpage(
                                      jop_id: 3,
                                      userName: widget.userName,
                                    )));
                      },
                    ),
                  ),
                  SizedBox(width: 15), // Space between the buttons
                  Expanded(
                    child: serviceButton(
                      id: 4,
                      title: 'Electrician',
                      iconPath: "lib/icon/icons8-electrician-64.png",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => cleaningpage(
                                      jop_id: 4,
                                      userName: widget.userName,
                                    )));
                      },
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: serviceButton(
                      id: 5,
                      title: 'Gardener',
                      iconPath: "lib/icon/gardener1.png",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => cleaningpage(
                                      jop_id: 5,
                                      userName: widget.userName,
                                    )));
                      },
                    ),
                  ),
                  SizedBox(width: 15), // Space between the buttons
                  Expanded(
                    child: serviceButton(
                      id: 6,
                      title: 'Painter',
                      iconPath: "lib/icon/icons8-painter-64.png",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => cleaningpage(
                                      jop_id: 6,
                                      userName: widget.userName,
                                    )));
                      },
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: serviceButton(
                      id: 7,
                      title: 'Tailor',
                      iconPath: "lib/icon/icons8-tailor-64.png",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => cleaningpage(
                                      jop_id: 7,
                                      userName: widget.userName,
                                    )));
                      },
                    ),
                  ),
                  SizedBox(width: 15), // Space between the buttons
                  Expanded(
                    child: serviceButton(
                      id: 8,
                      title: 'Plumber',
                      iconPath: "lib/icon/plumbe.png",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => cleaningpage(
                                      jop_id: 8,
                                      userName: widget.userName,
                                    )));
                      },
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: serviceButton(
                      id: 9,
                      title: 'Smith',
                      iconPath: "lib/icon/smith.png",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => cleaningpage(
                                      jop_id: 9,
                                      userName: widget.userName,
                                    )));
                      },
                    ),
                  ),
                  SizedBox(width: 15), // Space between the buttons
                  Expanded(
                    child: serviceButton(
                      id: 10,
                      title: 'Tiler',
                      iconPath: "lib/icon/tiler.png",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => cleaningpage(
                                      jop_id: 10,
                                      userName: widget.userName,
                                    )));
                      },
                    ),
                  ),
                ],
              ),

              // ... [continue with other services, replicating the above structure]
            ],
          ),
        ),
      ),
    );
  }

  Widget serviceButton(
      {required int id,
      required String title,
      required String iconPath,
      VoidCallback? onPressed}) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 50, right: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                minimumSize: Size(150, 80),
              ),
              onPressed: () {
                if (onPressed != null) {
                  onPressed();
                } else {
                  handleJobSelection(id);
                }
              },
              icon: Image.asset(iconPath),
              label: Text(title.toLowerCase()),
            ),
          ),
        ),
      ],
    );
  }

  void handleJobSelection(int jop_id) {
    // Use jobId to determine the action or display the information
    switch (jop_id) {
      case 1:
        // Handle Carpenter selection
        break;
      case 2:
        // Handle Cleaning selection, although it's already covered in onPressed
        break;
      // ... continue with other job IDs
    }
  }
}
