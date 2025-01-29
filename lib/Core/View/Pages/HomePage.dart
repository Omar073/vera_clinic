import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/View/Pages/ClientDetailsPage.dart';
import '../../../NewClientRegistration/View/NewClientPage.dart';
import '../../Model/Classes/Client.dart';
import '../Reusable widgets/MyNavigationButton.dart';
import 'AnalysisPage.dart';
import 'CheckInPage.dart';
import 'ClientSearchPage.dart';
import 'FollowUpNav.dart';
import 'package:google_fonts/google_fonts.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[50]!,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildWelcomeSection(),
                        const SizedBox(height: 30),
                        _buildGridMenu(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/logo.png', height: 40), // Add your logo
          Text(
            'Vera-Life Clinic',
            style: GoogleFonts.cairo(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'مرحباً بكم',
            style: GoogleFonts.cairo(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'اختر من القائمة أدناه',
            style: GoogleFonts.cairo(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridMenu() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40), // Add padding to make the grid narrower
        child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 1.2,
          children: [
            _buildMenuCard(
              'عميل جديد',
              Icons.person_add,
              Colors.green,
                  () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewClientPage()),
              ),
            ),
            _buildMenuCard(
              'عميل سابق',
              Icons.person,
              Colors.blue,
                  () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClientSearchPage(state: "checkIn"),
                ),
              ),
            ),
            _buildMenuCard(
              'بحث',
              Icons.search,
              Colors.orange,
                  () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClientSearchPage(state: "search"),
                ),
              ),
            ),
            _buildMenuCard(
              'متابعة',
              Icons.person_search,
              Colors.purple,
                  () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FollowUpNav()),
              ),
            ),
            _buildMenuCard(
              'بيانات',
              Icons.area_chart,
              Colors.red,
                  () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AnalysisPage()),
              ),
            ),
          ],
        ),
    );
  }

  Widget _buildMenuCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: GoogleFonts.cairo(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}