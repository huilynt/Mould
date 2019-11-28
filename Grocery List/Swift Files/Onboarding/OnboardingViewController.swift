//
//  OnboardingViewController.swift
//  Grocery List
//
//  Created by MAD2 on 25/1/19.
//  Copyright © 2019 Weijie. All rights reserved.
//

import UIKit
import paper_onboarding

class OnboardingViewController: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate {
    func onboardingItemsCount() -> Int {
        return 3
    }

    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return [
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "one"),
                               title: "title",
                               description: "description",
                               pageIcon: #imageLiteral(resourceName: "one"),
                               color: UIColor.green,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: UIFont.preferredFont(forTextStyle: UIFont.TextStyle(rawValue: "Arial")),
                               descriptionFont: UIFont.preferredFont(forTextStyle: UIFont.TextStyle(rawValue: "Arial"))),

            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "one"),
                               title: "title",
                               description: "description",
                               pageIcon: #imageLiteral(resourceName: "one"),
                               color: UIColor.green,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: UIFont.preferredFont(forTextStyle: UIFont.TextStyle(rawValue: "Arial")),
                               descriptionFont: UIFont.preferredFont(forTextStyle: UIFont.TextStyle(rawValue: "Arial"))),

            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "one"),
                               title: "title",
                               description: "description",
                               pageIcon: #imageLiteral(resourceName: "one"),
                               color: UIColor.green,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: UIFont.preferredFont(forTextStyle: UIFont.TextStyle(rawValue: "Arial")),
                               descriptionFont: UIFont.preferredFont(forTextStyle: UIFont.TextStyle(rawValue: "Arial"))),
            ][index]
    }



    @IBOutlet weak var onboardingView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let onboarding = PaperOnboarding()
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)

        // add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
    }
}




