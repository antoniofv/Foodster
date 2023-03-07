//
//  RecipeCategoryListView.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 7/3/23.
//

import SwiftUI

struct RecipeCategoryListView: View {
    
    @StateObject private var recipeListViewModel = RecipeListViewModel()

    var body: some View {
        NavigationView {
            List(recipeListViewModel.categories.sorted(by: { $0.strCategory < $1.strCategory })) { category in
                    HStack(alignment: .center, spacing: 16) {
                        AsyncImage(url: URL(string: category.strCategoryThumb)) { image in
                            image.image?.resizable()
                        }
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .padding(6)
                            .background(.gray.opacity(0.2))
                            .cornerRadius(40)
                            
                            
                        Text(category.strCategory).font(.title3)
                    }
            }
            .listStyle(.plain)
            .navigationBarTitle(Text("Recipes"))
            .toolbarBackground(Color.orange, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .accentColor(.white)
        .onAppear {
            loadViewContent()
        }
    }

    private func loadViewContent() {
        Task(priority: .background) {
            do {
                try await self.recipeListViewModel.getRecipeCategories()
            } catch {
                print(error)
            }
        }
    }
    
}

struct RecipeCategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCategoryListView()
    }
}
