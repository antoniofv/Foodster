//
//  ScrollViewWithOffset.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 14/3/23.
//

import SwiftUI


/// Contains the gap between the smallest value for the y-coordinate of
/// the frame layer and the content layer.
private struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}


struct ScrollViewWithOffset<Content: View>: View {
    let content: () -> Content
    let onOffsetChange: (CGFloat) -> Void

    init(
        @ViewBuilder content: @escaping () -> Content,
        onOffsetChange: @escaping (CGFloat) -> Void
    ) {
        self.content = content
        self.onOffsetChange = onOffsetChange
    }

    var body: some View {
        ScrollView {
            offsetReader
            content()
                .padding(.top, -8) // 👈🏻 places the real content as if our `offsetReader` was not there.
        }
        .coordinateSpace(name: "frameLayer")
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self, perform: onOffsetChange)
    }

    var offsetReader: some View {
        GeometryReader { proxy in
            Color.clear
                .preference(
                    key: ScrollViewOffsetPreferenceKey.self,
                    value: proxy.frame(in: .named("frameLayer")).minY
                )
        }
        .frame(height: 0) // 👈🏻 make sure that the reader doesn't affect the content height
    }
}
