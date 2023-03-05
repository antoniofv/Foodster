//
//  PostListView.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 23/2/23.
//

import SwiftUI

struct PostListView: View {

    @StateObject private var postViewModel = PostViewModel()

    var body: some View {
        NavigationView {
            List(postViewModel.posts) { post in
                NavigationLink(destination: PostDetailView(post: post)) {
                    VStack(alignment: .leading) {
                        Text(post.title).font(.title2).bold()
                        Text(post.body).lineLimit(3)
                    }
                }
            }
            .listStyle(.plain)
            .navigationBarTitle(Text("Posts"))
            .toolbarBackground(Color.orange, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .accentColor(.white)
        .onAppear {
            loadViewContent()
        }
    }

    private func loadViewContent() {
        Task(priority: .medium) {
            do {
                try await self.postViewModel.getPosts()
            } catch {
                print(error)
            }
        }
    }

}

#if DEBUG
struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
    }
}
#endif
