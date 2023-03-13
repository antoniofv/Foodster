//
//  RecipeDetailsView.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 9/3/23.
//

import SwiftUI


struct RecipeDetailsView: View {

    @EnvironmentObject var recipeListViewModel: RecipeListViewModel

    let recipeId: String

    @State private var loadedRecipe: Recipe?

    var body: some View {
        ScrollView {

            VStack(alignment: .leading) {

                AsyncImage(url: URL(string: loadedRecipe?.strMealThumb ?? "")) { image in
                        image.image?
                            .resizable()
                            .scaledToFill()
                    }
                    .frame(height: 260, alignment: .topLeading)
                    .clipped()
                    .backgroundStyle(.yellow)

                VStack(alignment: .leading, spacing: 20) {

                    Text(loadedRecipe?.strMeal ?? "")
                        .font(.title)
                        .bold()

                    VStack(alignment: .leading, spacing: 30) {
                        IngredientListView()

                        InstructionsView()
                    }

                }
                .padding(20)
            }
            .navigationBarTitle("Recipe", displayMode: .inline)
            .toolbarBackground(Color.orange, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .overlay {
            if loadedRecipe == nil {
                Group {
                    VStack {
                        Text("Loading...")
                            .font(.title2)
                            .bold()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.white)
                }
            }
        }
        .task {
            do {
                loadedRecipe = try await recipeListViewModel.getRecipe(id: recipeId)
            } catch {
                print(error)
            }
        }

    }

    fileprivate func IngredientListView() -> some View {
        VStack(alignment: .leading) {

            Text("Ingredients")
                .font(.title3)
                .bold()

            VStack(alignment: .leading, spacing: 10) {

                ForEach(loadedRecipe?.ingredients ?? []) { ingredient in
                    Text(ingredient.description)
                        .font(.callout)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }

            }
            .frame(maxWidth: .infinity)
            .padding(20)
            .background(.gray.opacity(0.15))
            .cornerRadius(10)

        }
    }

    fileprivate func InstructionsView() -> some View {
        VStack(alignment: .leading, spacing: 10) {

            Text("Instructions")
                .font(.title3)
                .bold()

            if let youtubeLink = loadedRecipe?.strYoutube, !youtubeLink.isEmpty {
                Link(destination: URL(string: youtubeLink)!) {
                    HStack {
                        Image(systemName: "play.rectangle.fill")
                        Text("Watch on YouTube").font(.callout).bold()
                    }
                }
                .buttonStyle(.bordered)
                .tint(.orange)
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 10, trailing: 0))
            }

            Text(loadedRecipe?.strInstructions ?? "")
                .font(.callout)
                .padding(EdgeInsets(top: 0, leading: 1, bottom: 0, trailing: 20))

        }
    }

}


#if DEBUG

struct RecipeDetailsView_Previews: PreviewProvider {

    static var previews: some View {
        @ObservedObject var mockModel = RecipeListViewModel(
            api: MockTheMealDBAPI()
        )

        return NavigationView {
            RecipeDetailsView(recipeId: "1")
                .environmentObject(mockModel)
        }
    }

}

#endif
