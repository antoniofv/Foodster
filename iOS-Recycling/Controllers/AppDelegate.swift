//
//  AppDelegate.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 19/3/23.
//

import Intents
import UIKit


class AppDelegate: NSObject, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        requestSiriIntegration()

        return true
    }

}


extension AppDelegate {

    func requestSiriIntegration() {
        INPreferences.requestSiriAuthorization { _ in
        }
    }

}
