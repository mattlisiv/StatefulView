//
//  ViewController.swift
//  StatefulViewExample
//
//  Created by Matthew Lisivick on 11/2/17.
//  Copyright © 2017 Redi. All rights reserved.
//

import UIKit
import StatefulView

class ViewController: UIViewController {

    @IBOutlet var segmentSelector: UISegmentedControl!
    @IBOutlet var statefulView: StatefulView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.segmentSelector.addTarget(self, action: #selector(segmentedControlComparisonChanged), for: .allEvents)
        self.statefulView.setAvailableViews(loadingView: "LoadingView", errorView: "ErrorView", emptyView: "EmptyView", customView: "MyCustomView")
        self.statefulView.setState(state: .empty)
    }
    
//    override func viewDidLayoutSubviews() {
//        state = StatefulView(frame: statefulView.frame)
//        self.view.addSubview(state)
//        state.setLoadView()
//        state.setEmptyView()
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func segmentedControlComparisonChanged(segment: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0:
            self.statefulView.setState(state: .empty)
            break
        case 1:
            self.statefulView.setState(state: .loading)
            break
        case 2:
            self.statefulView.setState(state: .error)
            break
        default:
            self.statefulView.setState(state: .custom)

        }

    }

}

