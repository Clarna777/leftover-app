import 'package:flutter/material.dart';

import '../data/recipes.dart';

class RecipeDetailScreen extends StatelessWidget {
  const RecipeDetailScreen({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.title)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(recipe.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 14),
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF7E7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(child: Text('Image placeholder')),
            ),
            const SizedBox(height: 20),
            Text('Ingredients', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ...recipe.ingredients.map((item) => Text('• $item')),
            const SizedBox(height: 18),
            Text('Instructions', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ...recipe.instructions.asMap().entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text('${entry.key + 1}. ${entry.value}'),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
