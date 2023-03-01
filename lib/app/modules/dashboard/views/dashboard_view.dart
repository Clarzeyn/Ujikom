import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ujikom/app/data/entertainment_response.dart';
import 'package:ujikom/app/data/sports_response.dart';
import 'package:ujikom/app/data/technology_response.dart';
import 'package:ujikom/app/modules/dashboard/views/numbers_widget.dart';
import 'package:ujikom/app/modules/home/views/home_view.dart';
import '../../../data/headline_response.dart';
import '../controllers/dashboard_controller.dart';
import 'package:lottie/lottie.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());
    final ScrollController scrollController = ScrollController();
    final auth = GetStorage();
    return SafeArea(
        child: DefaultTabController(
      length: 5,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await auth.erase();
            Get.offAll(() => const HomeView());
          },
          backgroundColor: Colors.redAccent,
          child: const Icon(Icons.logout_rounded),
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120.0),
          child: Column(
            children: [
              ListTile(
                title: const Text(
                  'Hallo!',
                  textAlign: TextAlign.end,
                ),
                subtitle: Text(
                  auth.read('full_name').toString(),
                  textAlign: TextAlign.end,
                ),
                trailing: Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 50.0,
                  height: 50,
                  child: Lottie.network(
                      'https://gist.githubusercontent.com/olipiskandar/2095343e6b34255dcfb042166c4a3283/raw/d76e1121a2124640481edcf6e7712130304d6236/praujikom_kucing.json',
                      fit: BoxFit.cover),
                ),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: TabBar(
                    labelColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: true,
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(text: "Headline"),
                      Tab(text: "Teknologi"),
                      Tab(text: "Olahraga"),
                      Tab(text: "Hiburan"),
                      Tab(text: "Profile"),
                    ]),
              )
            ],
          ),
        ),
        body: TabBarView(children: [
          headline(controller, scrollController),
          technology(controller, scrollController),
          sports(controller, scrollController),
          entertainment(controller, scrollController),
          profile(controller, scrollController)
        ]),
      ),
    ));
  }

  FutureBuilder<HeadlineResponse> headline(
      DashboardController controller, ScrollController scrollController) {
    return FutureBuilder<HeadlineResponse>(
        future: controller.getHeadline(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.network(
                  'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
                  repeat: true,
                  width: MediaQuery.of(context).size.width / 1),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("Tidak ada data"));
          }
          return ListView.builder(
            itemCount: snapshot.data!.data!.length,
            controller: scrollController,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding:
                    const EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 5),
                height: 110,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        snapshot.data!.data![index].urlToImage.toString(),
                        height: 130,
                        width: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          snapshot.data!.data![index].title.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Author : ${snapshot.data!.data![index].author}'),
                            Text('Sumber : ${snapshot.data!.data![index].name}')
                          ],
                        )
                      ],
                    ))
                  ],
                ),
              );
            },
          );
        });
  }

  FutureBuilder<TechnologyResponse> technology(
      DashboardController controller, ScrollController scrollController) {
    return FutureBuilder<TechnologyResponse>(
        future: controller.getTechnology(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.network(
                  'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
                  repeat: true,
                  width: MediaQuery.of(context).size.width / 1),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("Tidak ada data"));
          }
          return ListView.builder(
            itemCount: snapshot.data!.data!.length,
            controller: scrollController,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding:
                    const EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 5),
                height: 110,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        snapshot.data!.data![index].urlToImage.toString(),
                        height: 130,
                        width: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          snapshot.data!.data![index].title.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Author : ${snapshot.data!.data![index].author}'),
                            Text('Sumber : ${snapshot.data!.data![index].name}')
                          ],
                        )
                      ],
                    ))
                  ],
                ),
              );
            },
          );
        });
  }

  FutureBuilder<SportsResponse> sports(
      DashboardController controller, ScrollController scrollController) {
    return FutureBuilder<SportsResponse>(
        future: controller.getSports(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.network(
                  'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
                  repeat: true,
                  width: MediaQuery.of(context).size.width / 1),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("Tidak ada data"));
          }
          return ListView.builder(
            itemCount: snapshot.data!.data!.length,
            controller: scrollController,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding:
                    const EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 5),
                height: 110,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        snapshot.data!.data![index].urlToImage.toString(),
                        height: 130,
                        width: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          snapshot.data!.data![index].title.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Author : ${snapshot.data!.data![index].author}'),
                            Text('Sumber : ${snapshot.data!.data![index].name}')
                          ],
                        )
                      ],
                    ))
                  ],
                ),
              );
            },
          );
        });
  }

  FutureBuilder<EntertainmentResponse> entertainment(
      DashboardController controller, ScrollController scrollController) {
    return FutureBuilder<EntertainmentResponse>(
        future: controller.getEntertainment(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.network(
                  'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
                  repeat: true,
                  width: MediaQuery.of(context).size.width / 1),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("Tidak ada data"));
          }
          return ListView.builder(
            itemCount: snapshot.data!.data!.length,
            controller: scrollController,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding:
                    const EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 5),
                height: 110,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        snapshot.data!.data![index].urlToImage.toString(),
                        height: 130,
                        width: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          snapshot.data!.data![index].title.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Author : ${snapshot.data!.data![index].author}'),
                            Text('Sumber : ${snapshot.data!.data![index].name}')
                          ],
                        )
                      ],
                    ))
                  ],
                ),
              );
            },
          );
        });
  }

  ListView profile(
      DashboardController controller, ScrollController Scrollcontroller) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        buildTop(),
        buildContent(),
      ],
    );
  }

  Widget buildTop() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 144 / 2),
          child: buildCoverImage(),
        ),
        Positioned(
          top: 210,
          child: buildProfileImage(),
        ),
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.network(
          "https://images.unsplash.com/photo-1555066931-4365d14bab8c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Y29kaW5nfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
          width: double.infinity,
          height: 280,
          fit: BoxFit.cover,
        ),
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: 144 / 2,
        backgroundColor: Colors.grey.shade800,
        child: Lottie.network(
            'https://assets9.lottiefiles.com/packages/lf20_8pL7DHZXvo.json'),
      );

  Widget buildContent() => Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Text(
            "Wildanmnf",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Text(
            "Software Engineer",
            style: TextStyle(fontSize: 20, color: Colors.black45),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildSosialIcon(FontAwesomeIcons.slack),
              const SizedBox(
                height: 12,
              ),
              buildSosialIcon(FontAwesomeIcons.github),
              const SizedBox(
                height: 12,
              ),
              buildSosialIcon(FontAwesomeIcons.twitter),
              const SizedBox(
                height: 12,
              ),
              buildSosialIcon(FontAwesomeIcons.linkedin),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Divider(),
          const SizedBox(
            height: 16,
          ),
          NumbersWidget(),
          const SizedBox(
            height: 16,
          ),
          Divider(),
          const SizedBox(height: 16),
          buildAbout(),
          const SizedBox(
            height: 32,
          ),
        ],
      );
  Widget buildAbout() => Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Hello, My name is Wildan Mochamad Nur Fallah. My age is seventeen. Assalaam Vocational High School Bandung is where I attend classes. I enjoy reading, playing basketball, and playing video games, among other things, as hobbies.",
              style: TextStyle(fontSize: 18, height: 1.4),
            ),
          ],
        ),
      );

  Widget buildSosialIcon(IconData icon) => CircleAvatar(
        radius: 25,
        child: Material(
          shape: CircleBorder(),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Center(
                child: Icon(
              icon,
              size: 32,
            )),
          ),
        ),
      );
}
