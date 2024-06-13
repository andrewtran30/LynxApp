//
//  AppState.swift
//  lynx
//
//  Created by Arnav Wadehra on 8/22/22.
//

import Foundation

final class AppState : ObservableObject {
    @Published var rootViewId = UUID()
}
