import 'package:flutter/material.dart';

import 'package:transparent_image/transparent_image.dart';

import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item_trait.dart';

class MealItem extends StatelessWidget {
  const MealItem ({
    required this.meal,
    required this.onSelectMeal,
    super.key
    });
  
  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
     meal.complexity.name.substring(1); // 'Hello' + 'Wolrd' = 'HelloWorld'
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
     meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectMeal(meal);
        },
        child: Stack(
          children: [
            Hero(
              tag: meal.id, 
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom:0, // distance to FadeInImage Widget
              left:0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 44,
                ),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,                      // Restrict to 2 lines and cut of the rest if title is really long
                      textAlign: TextAlign.center,
                      softWrap: true,                   // Nice output if text need to be wrapped
                      overflow: TextOverflow.ellipsis,  // Very long text is cut of with ...
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        ),
                      ],
                    ),
                  ],
                ),          
              ),
            ),
          ],
        ),
      ),
    );
  }
}