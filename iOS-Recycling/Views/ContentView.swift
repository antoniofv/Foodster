//
//  ContentView.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 17/2/23.
//

import SwiftUI

struct ContentView: View {
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
        }.onAppear {
            self.postViewModel.getPosts()
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
