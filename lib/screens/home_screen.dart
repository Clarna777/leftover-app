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
  String selectedCategory = 'Breakfast';
  String selectedTaste = 'Any';
  bool healthyOnly = false;

  final categories = const ['Breakfast', 'Lunch', 'Dinner'];
  final tastes = const ['Any', 'Savory', 'Mild', 'Sweet'];

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
      final tasteMatch = selectedTaste == 'Any' || recipe.taste == selectedTaste;
      final healthyMatch = !healthyOnly || recipe.isHealthy;

      final keywords = _ingredientKeywords;
      final ingredientMatch = keywords.isEmpty ||
          keywords.every(
            (keyword) => recipe.ingredients
                .join(' ')
                .toLowerCase()
                .contains(keyword.toLowerCase()),
          );

      return categoryMatch && tasteMatch && healthyMatch && ingredientMatch;
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
      appBar: AppBar(title: const Text('Find Recipes')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: _ingredientsController,
              decoration: const InputDecoration(
                hintText: 'Enter ingredients (e.g. egg, tomato)',
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedTaste,
              decoration: const InputDecoration(labelText: 'Taste'),
              items: tastes
                  .map(
                    (taste) => DropdownMenuItem(
                      value: taste,
                      child: Text(taste),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() => selectedTaste = value);
              },
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Healthy'),
              value: healthyOnly,
              activeColor: const Color(0xFF8FCF86),
              onChanged: (value) => setState(() => healthyOnly = value),
            ),
            const SizedBox(height: 8),
            const Text('Category'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: categories
                  .map(
                    (category) => ChoiceChip(
                      label: Text(category),
                      selected: selectedCategory == category,
                      selectedColor: const Color(0xFFDDF3D8),
                      onSelected: (_) => setState(() => selectedCategory = category),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),
            RoundedPrimaryButton(
              label: 'Find recipes',
              onPressed: () => setState(() => showRecipes = true),
            ),
            const SizedBox(height: 20),
            if (showRecipes)
              ...filteredRecipes.map(
                (recipe) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
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
              const Text('No recipes found for selected filters.'),
          ],
        ),
      ),
    );
  }
}
