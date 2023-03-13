//
//  RecipeListView.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 7/3/23.
//

import SwiftUI

struct RecipeListView: View {
    
    @EnvironmentObject var recipeListViewModel: RecipeListViewModel
    
    let recipeCategory: RecipeCategory!
    
    var body: some View {
        List(recipeCategory.recipes.sorted(by: { $0.strMeal < $1.strMeal })) { recipe in
            NavigationLink(destination: {
                RecipeDetailsView(recipeId: recipe.id)
            }) {
                HStack(alignment: .center, spacing: 16) {
                    AsyncImage(url: URL(string: recipe.strMealThumb)) { image in
                        image.image?.resizable()
                    }
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .cornerRadius(50)

                    Text(recipe.strMeal).font(.title3)
                }
            }
        }
        .listStyle(.plain)
        .navigationBarTitle(Text(recipeCategory.strCategory))
        .toolbarBackground(Color.orange, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear {
            loadViewContent()
        }
    }

    private func loadViewContent() {
        Task(priority: .background) {
            do {
                try await self.recipeListViewModel.getRecipes(forCategory: recipeCategory)
            } catch {
                print(error)
            }
        }
    }

}

struct RecipeListView_Previews: PreviewProvider {

    static var previews: some View {
        let recipeListViewModel = RecipeListViewModel(api: MockTheMealDBAPI())

        let recipeCategory = RecipeCategory(
            idCategory: "1",
            strCategory: "Pizza",
            strCategoryThumb: "",
            strCategoryDescription: "Best food in the World!"
        )

        recipeListViewModel.categories = [recipeCategory]

        return RecipeListView(
            recipeCategory: recipeCategory
        ).environmentObject(recipeListViewModel)
    }
}
