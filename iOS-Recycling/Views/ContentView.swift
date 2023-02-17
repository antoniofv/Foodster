//
//  ContentView.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 17/2/23.
//

import SwiftUI

struct ContentView: View {
    @State var posts: [Post] = [];
    private let postViewModel = PostViewModel()
    
    var body: some View {
        NavigationView {
            List(posts) { post in
                NavigationLink(destination: Text(post.title)) {
                    VStack(alignment: .leading) {
                        Text(post.title).font(.title2).bold()
                        Text(post.body)
                    }
                }
            }
            .listStyle(.plain)
            .navigationBarTitle(Text("Posts"))
        }.onAppear(perform: {
            postViewModel.getPosts { posts in
                self.posts = posts
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
