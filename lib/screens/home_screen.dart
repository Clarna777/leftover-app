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
  int _selectedNavIndex = 0;
  String selectedCategory = 'Breakfast';
  String selectedHealth = 'Healthy';

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

  bool _matchesHealth(Recipe recipe) {
    if (selectedHealth == 'Healthy') {
      return recipe.isHealthy;
    }

    return recipe.isHealthy && recipe.ingredients.length <= 4;
  }

  List<Recipe> get filteredRecipes {
    return dummyRecipes.where((recipe) {
      final categoryMatch = recipe.category == selectedCategory;
      final healthyMatch = _matchesHealth(recipe);

      final keywords = _ingredientKeywords;
      final ingredientMatch = keywords.isEmpty ||
          keywords.every(
            (keyword) => recipe.ingredients
                .join(' ')
                .toLowerCase()
                .contains(keyword.toLowerCase()),
          );

      return categoryMatch && healthyMatch && ingredientMatch;
    }).toList();
  }

  @override
  void dispose() {
    _ingredientsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
          children: [
            Row(
              children: [
                _TrendingButton(
                  onPressed: () {
                    setState(() {
                      showRecipes = true;
                    });
                  },
                ),
                const Spacer(),
                _FilterChipGroup(
                  label: 'Category',
                  options: categories,
                  selectedValue: selectedCategory,
                  onChanged: (value) => setState(() => selectedCategory = value),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Find Recipes',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _ingredientsController,
              decoration: const InputDecoration(
                hintText: 'Enter ingredients (e.g. egg, tomato)',
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: _FilterChipGroup(
                label: 'Health',
                options: healthOptions,
                selectedValue: selectedHealth,
                onChanged: (value) => setState(() => selectedHealth = value),
              ),
            ),
            const SizedBox(height: 16),
            RoundedPrimaryButton(
              label: 'Find Recipes',
              onPressed: () => setState(() => showRecipes = true),
            ),
            const SizedBox(height: 16),
            if (showRecipes)
              ...filteredRecipes.map(
                (recipe) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: RecipeCard(
                    title: recipe.title,
                    category: recipe.category,
                    subtitle: recipe.taste,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RecipeDetailScreen(recipe: recipe),
                      ),
                    ),
                  ),
                ),
              ),
            if (showRecipes && filteredRecipes.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text('No recipes found for selected filters.'),
              ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedNavIndex,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFDDF3D8),
        onDestinationSelected: (index) {
          setState(() => _selectedNavIndex = index);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(
            icon: Icon(Icons.cloud_upload_rounded),
            label: 'Upload',
          ),
          NavigationDestination(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}

class _TrendingButton extends StatelessWidget {
  const _TrendingButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF8A4E00),
        backgroundColor: const Color(0xFFFFE3BE),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),
      icon: const Icon(Icons.local_fire_department_rounded, size: 16),
      label: const Text('Trending'),
    );
  }
}

class _FilterChipGroup extends StatelessWidget {
  const _FilterChipGroup({
    required this.label,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  });

  final String label;
  final List<String> options;
  final String selectedValue;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 6,
      runSpacing: 6,
      children: [
        Text(
          '$label:',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.black54,
            fontWeight: FontWeight.w600,
          ),
        ),
        ...options.map(
          (option) => ChoiceChip(
            showCheckmark: false,
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            label: Text(option),
            selected: selectedValue == option,
            selectedColor: const Color(0xFFDDF3D8),
            side: const BorderSide(color: Color(0xFFE9EFE7)),
            onSelected: (_) => onChanged(option),
          ),
        ),
      ],
    );
  }
}
