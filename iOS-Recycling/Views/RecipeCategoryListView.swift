//
//  RecipeCategoryListView.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 7/3/23.
//

import CoreData
import SwiftUI


struct RecipeCategoryListView: View {

    @StateObject private var recipeListViewModel: RecipeListViewModel


    var body: some View {
        NavigationView {
            List(recipeListViewModel.categories.sorted(by: { $0.name < $1.name })) { category in
                NavigationLink(destination: RecipeListView(recipeCategory: category)) {

                    HStack(alignment: .center, spacing: 16) {
                        AsyncImage(
                            url: URL(string: category.thumbnail),
                            transaction: Transaction(
                                animation: .easeIn(duration: 0.15)
                            )
                        ) { image in
                            image.image?.resizable()
                        }
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding(6)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(40)

                        Text(category.name)
                            .font(.title3)
                    }

                }
                .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
            .navigationBarTitle(Text("Recipes"))
            .toolbarBackground(Color.orange, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .background(Assets.Colors.recipesBackground)
        }
        .environmentObject(recipeListViewModel)
        .accentColor(.white)
        .onAppear {
            loadViewContent()
        }
    }


    init(api: TheMealDBAPIProtocol, context: NSManagedObjectContext) {
        _recipeListViewModel = StateObject(wrappedValue: {
            RecipeListViewModel(api: api, context: context)
        }())
    }

}


extension RecipeCategoryListView {

    private func loadViewContent() {
        Task(priority: .background) {
            do {
                try await recipeListViewModel.getRecipeCategories()
            } catch {
                print(error)
            }
        }
    }

}


#if DEBUG

struct RecipeCategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCategoryListView(
            api: MockTheMealDBAPI(),
            context: DataStoreProvider(inMemory: true).container.viewContext
        )
    }
}

#endif
