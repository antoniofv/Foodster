//
//  RecipeListView.swift
//  Foodster
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
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .navigationBarTitle(Text(recipeCategory.name))
        .toolbarBackground(Color.orange, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .background(Assets.Colors.recipesBackground)
        .onAppear {
            loadViewContent()
        }
    }

}


extension RecipeListView {

    private func loadViewContent() {
        Task(priority: .background) {
            do {
                try await recipeListViewModel.getRecipes(forCategory: recipeCategory)
            } catch {
                print(error)
            }
        }
    }

}


#if DEBUG

struct RecipeListView_Previews: PreviewProvider {

    static var previews: some View {
        let recipeListViewModel = RecipeListViewModel(
            api: MockTheMealDBAPI(),
            context: DataStoreProvider(inMemory: true).container.viewContext
        )

        return NavigationStack {
            RecipeListView(
                recipeCategory: MockRecipeCategory.category1
            )
            .environmentObject(recipeListViewModel)
        }
    }
}

#endif
