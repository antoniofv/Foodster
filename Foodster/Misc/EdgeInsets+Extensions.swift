//
//  EdgeInsets+Extensions.swift
//  Foodster
//
//  Created by Antonio Fernandez Vega on 14/3/23.
//

import SwiftUI


extension EdgeInsets {

    static let zero = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)


    public func insetBy(
        top: CGFloat = 0,
        leading: CGFloat = 0,
        bottom: CGFloat = 0,
        trailing: CGFloat = 0
    ) -> EdgeInsets {
        EdgeInsets(
            top: self.top + top,
            leading: self.leading + leading,
            bottom: self.bottom + bottom,
            trailing: self.trailing + trailing
        )
    }

    public func insetBy(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> EdgeInsets {
        self.insetBy(
            top: vertical,
            leading: horizontal,
            bottom: vertical,
            trailing: horizontal
        )
    }

}
