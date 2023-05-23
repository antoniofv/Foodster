//
//  MockRecipe.swift
//  Foodster
//
//  Created by Antonio Fernandez Vega on 20/5/23.
//

import Foundation


#if DEBUG

struct MockRecipe {

    static let burgerRecipe1 = Recipe(
        id: "1",
        name: "Bacon cheeseburger",
        thumbnail: "https://img.freepik.com/premium-photo/craft-beef-burger-with-cheddar-bacon-pickles-purple-onion-sauce-wooden-background_74692-842.jpg",
        instructions: "First you make the angus meat, then you cook the bacon really crispy.\n\nPut a slice of cheddar over the bread, then the angus meat, another cheddar slice, barbecue sauce and then lots of bacon on top.\n\nAnd... that's it!",
        video: "https://www.youtube.com/watch?v=ZSrtDFR4yb8",
        ingredients: [
            RecipeIngredient(name: "Bacon", measure: "200g"),
            RecipeIngredient(name: "Cheddar cheese", measure: "100g"),
            RecipeIngredient(name: "Pickles", measure: "100g")
        ]
    )

    static let veganRecipe1 = Recipe(
        id: "52942",
        name: "Roast fennel and aubergine paella",
        thumbnail: "https://www.themealdb.com/images/media/meals/1520081754.jpg",
        instructions: "1 Put the fennel, aubergine, pepper and courgette in a roasting tray. Add a glug of olive oil, season with salt and pepper and toss around to coat the veggies in the oil. Roast in the oven for 20 minutes, turning a couple of times until the veg are pretty much cooked through and turning golden.\r\n\r\n2 Meanwhile, heat a paella pan or large frying pan over a low– medium heat and add a glug of olive oil. Sauté the onion for 8–10 minutes until softened. Increase the heat to medium and stir in the rice, paprika and saffron. Cook for around 1 minute to start toasting the rice, then add the white wine. Reduce by about half before stirring in two-thirds of the stock. Reduce to a simmer and cook for 10 minutes without a lid, stirring a couple of times.\r\n\r\n3 Stir in the peas, add some seasoning, then gently mix in the roasted veg. Pour over the remaining stock, arrange the lemon wedges on top and cover with a lid or some aluminium foil. Cook for a further 10 minutes.\r\n\r\n4 To ensure you get the classic layer of toasted rice at the bottom of the pan, increase the heat to high until you hear a slight crackle. Remove from the heat and sit for 5 minutes before sprinkling over the parsley and serving.",
        video: "https://www.youtube.com/watch?v=H5SmjR-fxUs",
        ingredients: [
            RecipeIngredient(name: "Baby Aubergine", measure: "6 small"),
            RecipeIngredient(name: "Fennel", measure: "4 small"),
            RecipeIngredient(name: "Red Pepper", measure: "1 thinly sliced"),
            RecipeIngredient(name: "Courgettes", measure: "1 medium"),
            RecipeIngredient(name: "Onion", measure: "1 finely chopped"),
            RecipeIngredient(name: "Paella Rice", measure: "300g"),
            RecipeIngredient(name: "Paprika", measure: "1 tsp"),
            RecipeIngredient(name: "Saffron", measure: "pinch"),
            RecipeIngredient(name: "White Wine", measure: "200ml"),
            RecipeIngredient(name: "Vegetable Stock", measure: "700ml"),
            RecipeIngredient(name: "Frozen Peas", measure: "100g"),
            RecipeIngredient(name: "Lemon", measure: "1 chopped"),
            RecipeIngredient(name: "Parsley", measure: "Handful"),
            RecipeIngredient(name: "Salt", measure: "pinch"),
            RecipeIngredient(name: "Black Pepper", measure: "pinch")
        ]
    )

    static let veganRecipe2 = Recipe(
        id: "52794",
        name: "Vegan Chocolate Cake",
        thumbnail: "https://www.themealdb.com/images/media/meals/qxutws1486978099.jpg",
        instructions: "Simply mix all dry ingredients with wet ingredients and blend altogether. Bake for 45 min on 180 degrees. Decorate with some melted vegan chocolate.",
        video: "https://www.youtube.com/watch?v=C3pAgB7pync",
        ingredients: [
            RecipeIngredient(name: "self raising flour", measure: "1 1/4 cup"),
            RecipeIngredient(name: "coco sugar", measure: "1/2 cup"),
            RecipeIngredient(name: "cacao", measure: "1/3 cup raw"),
            RecipeIngredient(name: "baking powder", measure: "1 tsp"),
            RecipeIngredient(name: "flax eggs", measure: "2"),
            RecipeIngredient(name: "almond milk", measure: "1/2 cup"),
            RecipeIngredient(name: "vanilla", measure: "1 tsp"),
            RecipeIngredient(name: "water", measure: "1/2 cup boiling")
        ]
    )

    static let beefRecipe1 = Recipe(
        id: "53058",
        name: "Croatian Bean Stew",
        thumbnail: "https://www.themealdb.com/images/media/meals/tnwy8m1628770384.jpg",
        instructions: "Heat the oil in a pan. Add the chopped vegetables and sauté until tender. Take a pot, empty the beans together with the vegetables into it, put the sausages inside and cook for further 20 minutes on a low heat. Or, put it in an oven and bake it at a temperature of 180ºC/350ºF for 30 minutes. This dish is even better reheated the next day.",
        video: "https://www.youtube.com/watch?v=mrjnQal3S1A",
        ingredients: [
            RecipeIngredient(name: "Cannellini Beans", measure: "2 cans"),
            RecipeIngredient(name: "Vegetable Oil", measure: "3 tbs"),
            RecipeIngredient(name: "Tomatoes", measure: "2 cups"),
            RecipeIngredient(name: "Challots", measure: "5"),
            RecipeIngredient(name: "Garlic", measure: "2 cloves"),
            RecipeIngredient(name: "Parsley", measure: "Pinch"),
            RecipeIngredient(name: "Chorizo", measure: "1/2 kg chopped")
        ]
    )

    static let beefRecipe2 = Recipe(
        id: "53071",
        name: "Beef Asado",
        thumbnail: "https://www.themealdb.com/images/media/meals/pkopc31683207947.jpg",
        instructions: "0.\tCombine beef, crushed peppercorn, soy sauce, vinegar, dried bay leaves, lemon, and tomato sauce. Mix well. Marinate beef for at least 30 minutes.\r\n1.\tPut the marinated beef in a cooking pot along with remaining marinade. Add water. Let boil.\r\n2.\tAdd Knorr Beef Cube. Stir. Cover the pot and cook for 40 minutes in low heat.\r\n3.\tTurn the beef over. Add tomato paste. Continue cooking until beef tenderizes. Set aside.\r\n4.\tHeat oil in a pan. Fry the potato until it browns. Turn over and continue frying the opposite side. Remove from the pan and place on a clean plate. Do the same with the carrots.\r\n5.\tSave 3 tablespoons of cooking oil from the pan where the potato was fried. Saute onion and garlic until onion softens.\r\n6.\tPour-in the sauce from the beef stew. Let boil. Add the beef. Cook for 2 minutes.\r\n7.\tAdd butter and let it melt. Continue cooking until the sauce reduces to half.",
        video: "https://www.youtube.com/watch?v=lNlK8DVhXXA",
        ingredients: [
            RecipeIngredient(name: "Beef", measure: "1.5kg"),
            RecipeIngredient(name: "Beef Stock Concentrate", measure: "1"),
            RecipeIngredient(name: "Tomato Puree", measure: "8 ounces"),
            RecipeIngredient(name: "Water", measure: "3 cups"),
            RecipeIngredient(name: "Soy Sauce", measure: "6 tablespoons"),
            RecipeIngredient(name: "White Wine Vinegar", measure: "1 tbs"),
            RecipeIngredient(name: "Pepper", measure: "2 tbs"),
            RecipeIngredient(name: "Bay Leaf", measure: "4"),
            RecipeIngredient(name: "Lemon", measure: "1/2"),
            RecipeIngredient(name: "Tomato Sauce", measure: "2 tbs"),
            RecipeIngredient(name: "Butter", measure: "3 tbs"),
            RecipeIngredient(name: "Olive Oil", measure: "1/2 cup"),
            RecipeIngredient(name: "Onion", measure: "1 chopped"),
            RecipeIngredient(name: "Garlic", measure: "4 cloves")
        ]
    )

}

#endif
