//
//  AppArguments.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 12/5/23.
//

import Foundation


public enum AppArguments: String {

    case uiTests = "-uiTests"
    case networkOffline = "-networkOffline"
    case requestFail = "-requestFail"


    static func contains(_ argument: AppArguments) -> Bool {
        CommandLine.arguments.contains(argument.rawValue)
    }

    static func buildArguments(_ arguments: [AppArguments]) -> [String] {
        arguments.map { $0.rawValue }
    }

}
