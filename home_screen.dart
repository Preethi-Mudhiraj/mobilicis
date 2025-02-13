import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_any_logo/flutter_logo.dart';
import 'package:oruphones/common/app_images.dart';
import 'package:oruphones/common/product_card.dart';
import 'package:oruphones/pages/sort_bottom_sheet.dart';
import 'package:oruphones/pages/filter_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> buttonLabels = [
    "Buy Used Phones",
    "Sell Used Phones",
    "Compare Prices",
    "My Profile",
    "My Listings",
    "Services",
    "Device Health Check",
  ];

  final List<String> bannerImages = [
    AppImages.banner1,
    AppImages.banner2,
    AppImages.banner3,
    AppImages.banner4,
    AppImages.banner5,
  ];

  final List<Map<String, String>> faqs = [
    {
      'question': 'Why should you buy used phones on ORUPhones?',
      'answer': 'ORUPhones provides verified devices at competitive prices with warranty options.'
    },
    {
      'question': 'How to sell phone on ORUPhones?',
      'answer': 'Sell in 3 easy steps: Add Device, Verify, and Get Paid instantly.'
    },
    {
      'question': 'What payment methods are available?',
      'answer': 'We support UPI, bank transfers, and cash on delivery options.'
    },
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.menu, color: Colors.black),
            Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(AppImages.logo),
                ),
              ),
            ),
            const SizedBox(width: 150),
            const Text('India', style: TextStyle(fontSize: 18, color: Colors.black)),
            const Icon(Icons.location_on, color: Colors.black),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[700],
              ),
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search phones with make, model..',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            // Buttons Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: buttonLabels.map((label) => _buildBoxButton(label)).toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Carousel
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: bannerImages.map((imagePath) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(imagePath, fit: BoxFit.fill, width: double.infinity),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            // Dots Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: bannerImages.map((imagePath) {
                int index = bannerImages.indexOf(imagePath);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index ? Colors.blue : Colors.grey,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            // "What's on your mind?" Section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("What's on your mind?", style: TextStyle(fontSize: 18)),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              children: [
                _buildIconTile(Icons.shopping_cart, 'Buy Used'),
                _buildIconTile(Icons.sell, 'Sell Used'),
                _buildIconTile(Icons.compare, 'Compare'),
                _buildIconTile(Icons.person, 'My Profile'),
              ],
            ),
            // Top Brands Section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Top Brands', style: TextStyle(fontSize: 18)),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  _buildBrandTile(AnyLogo.tech.apple.image(height: 40, width: 40)),
                  const SizedBox(width: 30),
                  _buildBrandTile(AnyLogo.tech.samsung.image(height: 40, width: 40)),
                  const SizedBox(width: 30),
                  _buildBrandTile(AnyLogo.tech.xiaomi.image(height: 40, width: 40)),
                  const SizedBox(width: 30),
                  _buildBrandTile(Image.asset(AppImages.oppo, height: 50, width: 50, fit: BoxFit.contain)),
                  const SizedBox(width: 30),
                  _buildBrandTile(Image.asset(AppImages.vivo, height: 50, width: 50, fit: BoxFit.contain)),
                  const SizedBox(width: 30),
                  _buildBrandTile(Image.asset(AppImages.realme, height: 50, width: 50, fit: BoxFit.contain)),
                  const SizedBox(width: 30),
                  _buildBrandTile(Image.asset(AppImages.motorola, height: 50, width: 50, fit: BoxFit.contain)),
                  const SizedBox(width: 30),
                ],
              ),
            ),
            // Best Deals Section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Best deals in India', style: TextStyle(fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => showSortBottomSheet(context),
                      icon: const Icon(Icons.sort, size: 18),
                      label: const Text("Sort"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => showFilterBottomSheet(context),
                      icon: const Icon(Icons.filter_list, size: 18),
                      label: const Text("Filters"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Products Grid
            Container(
              height: 1700,
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.all(8.0)),
                  Expanded(child: ProductGrid()),
                ],
              ),
            ),
            // FAQs Section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Frequently Asked Questions',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: faqs.map((faq) {
                  return Card(
                    color: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ExpansionTile(
                      title: Text(
                        faq['question']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(faq['answer']!),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            // Newsletter Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Get Notified About Our\nLatest Offers and Price Drops",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Enter your email here",
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print("Send button clicked");
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.horizontal(right: Radius.circular(50)),
                            ),
                            child: const Text(
                              "Send",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Download & Invite Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Download App Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Download App",
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AppImages.qr1, width: 100),
                            const SizedBox(width: 20),
                            Image.asset(AppImages.qr2, width: 100),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Invite a Friend Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Invite a Friend",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Invite a friend to ORUPhones application. Tap to copy the respective download link to clipboard.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AppImages.google_play, width: 120),
                            const SizedBox(width: 10),
                            Image.asset(AppImages.apple_store, width: 120),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(icon: AnyLogo.media.telegram.image(height: 40, width: 40), onPressed: () {}),
                            IconButton(icon: AnyLogo.media.instagram.image(height: 40, width: 40), onPressed: () {}),
                            IconButton(icon: AnyLogo.media.whatsapp.image(height: 40, width: 40), onPressed: () {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Sell +'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }

  Widget _buildIconTile(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade200,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: Icon(icon, size: 30, color: Colors.black),
          ),
        ),
        const SizedBox(height: 5),
        Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildBrandTile(Widget iconWidget) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 70,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade200,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipOval(
            child: Center(child: iconWidget),
          ),
        ),
      ],
    );
  }

  Widget _buildBoxButton(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 4,
                spreadRadius: 1,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
