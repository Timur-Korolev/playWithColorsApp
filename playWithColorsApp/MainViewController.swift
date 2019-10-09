//
//  MainViewController.swift
//  playWithColorsApp
//
//  Created by admin on 10/9/19.
//  Copyright © 2019 Timur Korolev. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setBackgroundColor(_ color: UIColor)
}

class MainViewController: UIViewController {
    @IBOutlet var mainView: UIView!

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsVC = segue.destination as! SettingsViewController
        settingsVC.delegate = self
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func setBackgroundColor(_ color: UIColor) {
        mainView.backgroundColor = color
    }
}
