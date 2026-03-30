class Recipe {
  const Recipe({
    required this.title,
    required this.category,
    required this.taste,
    required this.isHealthy,
    required this.ingredients,
    required this.instructions,
  });

  final String title;
  final String category;
  final String taste;
  final bool isHealthy;
  final List<String> ingredients;
  final List<String> instructions;
}

const List<Recipe> dummyRecipes = [
  Recipe(
    title: 'Veggie Omelette',
    category: 'Breakfast',
    taste: 'Savory',
    isHealthy: true,
    ingredients: ['Eggs', 'Spinach', 'Tomato', 'Onion'],
    instructions: [
      'Whisk eggs with a small pinch of salt.',
      'Cook chopped vegetables for 2 minutes.',
      'Add eggs and cook until set.',
    ],
  ),
  Recipe(
    title: 'Banana Oat Bowl',
    category: 'Breakfast',
    taste: 'Sweet',
    isHealthy: true,
    ingredients: ['Oats', 'Milk', 'Banana', 'Honey'],
    instructions: [
      'Cook oats with milk over low heat.',
      'Top with sliced banana.',
      'Drizzle a little honey and serve warm.',
    ],
  ),
  Recipe(
    title: 'Chicken Rice Bowl',
    category: 'Lunch',
    taste: 'Savory',
    isHealthy: true,
    ingredients: ['Rice', 'Chicken breast', 'Carrot', 'Soy sauce'],
    instructions: [
      'Cook sliced chicken in a pan.',
      'Add carrots and sauté for 2 minutes.',
      'Serve over warm rice with soy sauce.',
    ],
  ),
  Recipe(
    title: 'Creamy Pasta',
    category: 'Dinner',
    taste: 'Mild',
    isHealthy: false,
    ingredients: ['Pasta', 'Milk', 'Cheese', 'Garlic'],
    instructions: [
      'Boil pasta until tender.',
      'Simmer milk, garlic, and cheese.',
      'Mix pasta with sauce and serve.',
    ],
  ),
];
