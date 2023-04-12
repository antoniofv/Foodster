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
        List(recipeCategory.recipes.sorted(by: { $0.name < $1.name })) { recipe in
            NavigationLink(destination: {
                RecipeDetailsView(recipeId: recipe.id)
            }) {
                HStack(alignment: .center, spacing: 16) {
                    AsyncImage(
                        url: URL(string: recipe.thumbnail),
                        transaction: Transaction(
                            animation: .easeIn(duration: 0.15)
                        )
                    ) { image in
                        image.image?.resizable()
                    }
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .cornerRadius(50)

                    Text(recipe.name).font(.title3)
                }
            }
        }
        .listStyle(.plain)
        .navigationBarTitle(Text(recipeCategory.name))
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
        let recipeListViewModel = RecipeListViewModel(
            api: MockTheMealDBAPI(),
            context: DataStoreProvider(inMemory: true).container.viewContext
        )

        let recipeCategory = RecipeCategory(
            id: "1",
            name: "Pizza",
            thumbnail: "",
            description: "Best food in the World!"
        )

        recipeListViewModel.categories = [recipeCategory]

        return RecipeListView(
            recipeCategory: recipeCategory
        ).environmentObject(recipeListViewModel)
    }
}
