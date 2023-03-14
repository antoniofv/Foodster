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

    let recipeImageHeight: CGFloat = 260

    @State private var loadedRecipe: Recipe?
    @State private var scrollOffset: CGFloat = .zero

    var body: some View {
        ZStack(alignment: .topLeading) {

            GeometryReader { proxy in
                AsyncImage(url: URL(string: loadedRecipe?.strMealThumb ?? "")) { image in
                    image.image?
                        .resizable()
                        .scaledToFill()
                }
                .blur(
                    radius: abs(min(scrollOffset, 0)) / recipeImageHeight * 20,
                    opaque: true
                )
                .frame(
                    width: proxy.size.width,
                    height: recipeImageHeight + max(0, scrollOffset),
                    alignment: .top
                )
                .clipped()
                .background(.gray.opacity(0.15))
            }

            ScrollViewWithOffset {

                VStack(alignment: .leading) {

                    VStack(alignment: .leading, spacing: 20) {

                        Text(loadedRecipe?.strMeal ?? "")
                            .font(.title)
                            .bold()

                        VStack(alignment: .leading, spacing: 30) {
                            IngredientListView()

                            InstructionsView()
                        }

                    }
                    .padding(EdgeInsets(
                        top: 20,
                        leading: 20,
                        bottom: 400,
                        trailing: 20
                    ))
                    .background(.white)
                    .cornerRadius(16)
                }
                .padding(.zero.insetBy(top: recipeImageHeight - 20, bottom: -380))

            } onOffsetChange: { offset in
                scrollOffset = offset
            }.shadow(radius: 20, y: 2)

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
        .navigationBarTitle("Recipe", displayMode: .inline)
        .toolbarBackground(Color.orange, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)

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
                        .padding(.zero)
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
                .padding(.zero.insetBy(top: 5, bottom: 10))
            }

            Text(loadedRecipe?.strInstructions ?? "")
                .font(.callout)
                .padding(.zero.insetBy(leading: 1, trailing: 20))

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
