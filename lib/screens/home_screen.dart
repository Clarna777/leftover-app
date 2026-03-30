import 'package:flutter/material.dart';

import '../data/recipes.dart';
import '../widgets/recipe_card.dart';
import '../widgets/rounded_primary_button.dart';
import 'recipe_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _ingredientsController = TextEditingController();

  bool showRecipes = false;
  bool trendingMode = false;
  String selectedCategory = 'Breakfast';
  String selectedHealth = 'Healthy';
  int activeTab = 0;

  final categories = const ['Breakfast', 'Lunch', 'Dinner'];
  final healthOptions = const ['Healthy', 'Very Healthy'];

  List<String> get _ingredientKeywords {
    return _ingredientsController.text
        .toLowerCase()
        .split(',')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();
  }

  List<Recipe> get filteredRecipes {
    return dummyRecipes.where((recipe) {
      final categoryMatch = recipe.category == selectedCategory;
      final healthyMatch = recipe.isHealthy;

      final keywords = _ingredientKeywords;
      final ingredientMatch = keywords.isEmpty ||
          keywords.every(
            (keyword) => recipe.ingredients.join(' ').toLowerCase().contains(keyword),
          );

      return categoryMatch && healthyMatch && ingredientMatch;
    }).toList();
  }

  @override
  void dispose() {
    _ingredientsController.dispose();
    super.dispose();
  }

  Widget _buildChoiceGroup({
    required String title,
    required List<String> options,
    required String selected,
    required ValueChanged<String> onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Color(0xFF5B675A)),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options
              .map(
                (option) => GestureDetector(
                  onTap: () => onTap(option),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected == option
                          ? const Color(0xFFDDF3D8)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE4ECE1)),
                    ),
                    child: Text(option),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => trendingMode = !trendingMode),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: trendingMode
                            ? const Color(0xFFF29B39)
                            : const Color(0xFFFFE5C8),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        'Trending',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: trendingMode
                              ? Colors.white
                              : const Color(0xFF8C540F),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: _buildChoiceGroup(
                      title: 'Category',
                      options: categories,
                      selected: selectedCategory,
                      onTap: (value) => setState(() => selectedCategory = value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildChoiceGroup(
                title: 'Health',
                options: healthOptions,
                selected: selectedHealth,
                onTap: (value) => setState(() => selectedHealth = value),
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Find Recipes',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _ingredientsController,
                decoration: const InputDecoration(hintText: 'Enter ingredients'),
              ),
              const SizedBox(height: 12),
              RoundedPrimaryButton(
                label: 'Find Recipes',
                onPressed: () => setState(() => showRecipes = true),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: showRecipes
                    ? ListView.separated(
                        itemCount: filteredRecipes.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final recipe = filteredRecipes[index];
                          return RecipeCard(
                            title: recipe.title,
                            category: recipe.category,
                            subtitle: selectedHealth,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RecipeDetailScreen(recipe: recipe),
                              ),
                            ),
                          );
                        },
                      )
                    : const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Tap “Find Recipes” to see results.',
                          style: TextStyle(color: Color(0xFF6D786B)),
                        ),
                      ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE7EEE4)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _BottomBubbleItem(
                      label: 'Home',
                      icon: Icons.home_outlined,
                      active: activeTab == 0,
                      onTap: () => setState(() => activeTab = 0),
                    ),
                    _BottomBubbleItem(
                      label: 'Upload',
                      icon: Icons.upload_outlined,
                      active: activeTab == 1,
                      onTap: () => setState(() => activeTab = 1),
                    ),
                    _BottomBubbleItem(
                      label: 'Profile',
                      icon: Icons.person_outline,
                      active: activeTab == 2,
                      onTap: () => setState(() => activeTab = 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomBubbleItem extends StatelessWidget {
  const _BottomBubbleItem({
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFDDF3D8) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: const Color(0xFF3E4A3E)),
            const SizedBox(width: 5),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
