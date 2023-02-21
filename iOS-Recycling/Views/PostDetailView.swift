//
//  PostDetailView.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 18/2/23.
//

import SwiftUI

struct PostDetailView: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(post.title)
                .font(.title2)
                .bold()

            Text(post.body)
            
            Spacer()
        }
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity)
        .padding(5)
        .navigationBarTitleDisplayMode(.inline)

    }
}

#if DEBUG
struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostDetailView(post: Post(id: 1, userId: 1, title: "Post title", body: "Post body"))
        }
    }
}
#endif
