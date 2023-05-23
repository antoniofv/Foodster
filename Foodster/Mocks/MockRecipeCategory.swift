//
//  MockRecipeCategory.swift
//  Foodster
//
//  Created by Antonio Fernandez Vega on 20/5/23.
//

import Foundation


#if DEBUG

struct MockRecipeCategory {

    static let category1 = RecipeCategory(
        id: "1",
        name: "Beef",
        thumbnail: "https://www.themealdb.com/images/category/beef.png",
        description: "Beef is the culinary name for meat from cattle, particularly skeletal muscle. Humans have been eating beef since prehistoric times.[1] Beef is a source of high-quality protein and essential nutrients.[2]",
        recipes: [MockRecipe.beefRecipe1, MockRecipe.beefRecipe2]
    )

    static let category2 = RecipeCategory(
        id: "11",
        name: "Vegan",
        thumbnail: "https://www.themealdb.com/images/category/vegan.png",
        description: "Veganism is both the practice of abstaining from the use of animal products, particularly in diet, and an associated philosophy that rejects the commodity status of animals.[b] A follower of either the diet or the philosophy is known as a vegan (pronounced /ˈviːɡən/ VEE-gən). Distinctions are sometimes made between several categories of veganism. Dietary vegans (or strict vegetarians) refrain from consuming animal products, not only meat but also eggs, dairy products and other animal-derived substances.[c] The term ethical vegan is often applied to those who not only follow a vegan diet but extend the philosophy into other areas of their lives, and oppose the use of animals for any purpose.[d] Another term is environmental veganism, which refers to the avoidance of animal products on the premise that the harvesting or industrial farming of animals is environmentally damaging and unsustainable.!",
        recipes: [MockRecipe.veganRecipe1, MockRecipe.veganRecipe2]
    )

}

#endif
