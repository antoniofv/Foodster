//
//  AppArguments.swift
//  Foodster
//
//  Created by Antonio Fernandez Vega on 12/5/23.
//

import Foundation


public enum AppArguments: String {

    case inMemoryDatabase = "-inMemoryDatabase"
    case networkOffline = "-networkOffline"
    case requestFail = "-requestFail"
    case uiTests = "-uiTests"



    static func contains(_ argument: AppArguments) -> Bool {
        CommandLine.arguments.contains(argument.rawValue)
    }

    static func buildArguments(_ arguments: [AppArguments]) -> [String] {
        arguments.map { $0.rawValue }
    }

}
