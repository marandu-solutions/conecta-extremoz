import 'package:flutter/material.dart';
import 'package:conecta/theme/app_theme.dart';
import 'components/custom_app_bar.dart';
import 'components/hero_section.dart';
import 'components/features_section.dart';
import 'components/about_section.dart';
import 'components/footer_section.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          const CustomAppBar(),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: AppTheme.lightGradient,
              ),
              child: const HeroSection(),
            ),
          ),
          const SliverToBoxAdapter(
            child: FeaturesSection(),
          ),
          const SliverToBoxAdapter(
            child: AboutSection(),
          ),
          const SliverToBoxAdapter(
            child: FooterSection(),
          ),
        ],
      ),
    );
  }
}
