import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:orchids/screens/category/category_screen.dart';

import '../../appbars/custom_appbar.dart';
import '../../commonwidgets/leave_space_widget.dart';
import '../../commonwidgets/recommendation_wid.dart';
import '../../constants.dart';
import '../../drawers/homescreendrawer.dart';
import '../../modal/tokenModel.dart';
import 'expandablewid.dart';
import 'magazinewidget.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home-screen';
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: ""),
      body: HomeScreenBody(),
      drawer: const MyDrawer(),
    );
  }
}

class HomeScreenBody extends StatefulWidget {
  HomeScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LeaveSpaceWidget(20),
          const Center(
            child: Text(
              "Free shipping for members above Rs 999.join Now!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          LeaveSpaceWidget(36),
          //New styles added & further price drops widget
          SaleOfferWidget(),
          LeaveSpaceWidget(36),

          LeaveSpaceWidget(36),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('categories')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ));
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryScreen(
                                      dimage: snapshot.data!.docs[index]
                                          ['image1'],
                                      dtitle: snapshot.data!.docs[index]
                                          ['title'],
                                      dDescription: snapshot.data!.docs[index]
                                          ['description'],
                                      cateId: snapshot.data!.docs[index].id,
                                    ),
                                  ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                snapshot.data!.docs[index]['image'],
                              ))),
                            ),
                          ),
                        ),
                        LeaveSpaceWidget(4),
                        Text(
                          snapshot.data!.docs[index]['name'],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
          LeaveSpaceWidget(36),

          // RecommendedItem(
          //   bgImageUrl: imageUrl7,
          //   title: "Sequin season",
          //   desc: "It's time to sparkle.",
          // ),
          // LeaveSpaceWidget(36),
          // const TrendingCategoriesWidget(),
          // LeaveSpaceWidget(20),
          // SectionsList(),
          // LeaveSpaceWidget(36),
          // const NewArrivalsWidget(),
          // LeaveSpaceWidget(20),
          // RecommendedItem(
          //   bgImageUrl: imageUrl9,
          //   title: "Jingle all the way",
          //   desc:
          //       "Spread a little festive cheer with the perfect holiday outfit.",
          // ),
          // LeaveSpaceWidget(20),
          RecommendedItem(
            bgImageUrl: imageUrl10,
            title: "Night Moves",
            desc:
                "Reflective runwear to move whenever the mood takes you, by H&M Move",
          ),
          LeaveSpaceWidget(36),
          const MagazineWidget(),
        ],
      ),
    );
  }
}

final fbm = FirebaseMessaging.instance;

Future<void> saveTokenToDatabase(String token) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  final tokenRef = FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('tokens')
      .doc(token);
  await tokenRef.set(
      TokenModel(token: token, creadtedAt: FieldValue.serverTimestamp())
          .toJson());
}

void getToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  await saveTokenToDatabase(token!);
  FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
}
