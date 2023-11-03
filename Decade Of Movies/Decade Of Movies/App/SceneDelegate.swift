//
//  SceneDelegate.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 03/11/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Properties
    var window: UIWindow?
    private lazy var coordinator: MainCoordinator? = {
        return MainCoordinator()
    }()
    // MARK: - UIScenes
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        start()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

}
// MARK: - Coordinator
extension SceneDelegate {
    private func start() {
        coordinator?.start(controller: MasterViewController(), with: window)
    }
}
