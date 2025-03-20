import 'package:flutter/material.dart';
import 'package:shopx/core/utils/shared_prefs.dart';
import 'package:shopx/presentation/screens/auth/login_screen.dart';
import 'package:shopx/presentation/widgets/custom_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // onboarding slides in JSON
  final List _slides = [
    {
      "title": "Welcome",
      "description":
          "Discover amazing products with a visually engaging introduction to ShopX.",
      "image": "assets/images/onboard1.png",
    },
    {
      "title": "Explore",
      "description":
          "Browse through various categories to find what you love effortlessly.",
      "image": "assets/images/onboard2.png",
    },
    {
      "title": "Get Started",
      "description":
          "Begin your shopping journey and enjoy a seamless experience!",
      "image": "assets/images/onboard3.png",
    },
  ];

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _goToNextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _completeOnboarding() async {
    await SharedPrefs.setOnboardingShown();
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _slides.length,
            itemBuilder: (context, index) {
              final slide = _slides[index];
              return _OnboardingPage(
                title: slide['title'],
                description: slide['description'],
                image: slide['image'],
                isLastPage: index == _slides.length - 1,
              );
            },
          ),
          _currentPage != _slides.length - 1
              ? Positioned(
                bottom: 40,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Previous Button
                    if (_currentPage > 0)
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: _goToPreviousPage,
                      ),
                    // Slide Indicator
                    Row(
                      children: List.generate(
                        _slides.length,
                        (index) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                _currentPage == index
                                    ? Colors.blue
                                    : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    // Next Button
                    IconButton(
                      icon: Icon(Icons.arrow_forward, color: Colors.black),
                      onPressed: _goToNextPage,
                    ),
                  ],
                ),
              )
              : Positioned(
                bottom: 40,
                left: 20,
                right: 20,
                child: CustomElevatedButton(
                  text: 'Get Started',
                  onPressed: _completeOnboarding,
                  textColor: Colors.white,
                  borderRadius: 16.0,
                ),
              ),
        ],
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final bool isLastPage;
  const _OnboardingPage({
    required this.title,
    required this.description,
    required this.image,
    this.isLastPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 200),
          SizedBox(height: 24),
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          SizedBox(height: 16),
          Text(
            description,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
