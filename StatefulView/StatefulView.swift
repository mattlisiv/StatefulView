//
//  StatefulView.swift
//  StatefulView
//
//  Created by Matthew Lisivick on 11/2/17.
//  Copyright © 2017 Redi. All rights reserved.
//

import UIKit
import Foundation

/// Possible States
public enum ViewState: String {
    case loading = "loading"
    case error = "error"
    case empty = "empty"
    case custom = "custom"
}

public class StatefulView: UIView {

    // Default Views
    private var state: ViewState = ViewState.loading
    private var views:[ViewState:String] = [:]
    private var currentView: UIView?
    
    // Set Views
    public func setAvailableViews(loadingView: String? = nil, errorView: String? = nil, emptyView: String? = nil, customView: String? = nil){
        // Loading
        if let loading = loadingView{
            views[ViewState.loading] = loading
        }
        // Error
        if let error = errorView{
            views[ViewState.error] = error
        }
        // Empty
        if let empty = emptyView{
            views[ViewState.empty] = empty
        }
        // Custom
        if let custom = customView{
            views[ViewState.custom] = custom
        }
    }
    // Set Current State
    public func setState(state: ViewState){
        self.state = state
        self.reloadView()
    }
    // Remove Current View
    private func removeCurrentView(){
        for view in self.subviews{
            view.removeFromSuperview()
        }
    }
    
    // Reload View
    private func reloadView(){
        self.removeCurrentView()
        self.setSelectedView()
    }
    // Load View from NIB
    private func instanceFromNib(name: String,useDefault: Bool = false) -> UIView? {
        if !useDefault{
            if let view = UINib(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView{
                return view
            }
        }else{
            if let view = UINib(nibName: name, bundle: Bundle(identifier: "StatefulView")).instantiate(withOwner: nil, options: nil)[0] as? UIView{
                return view
            }
        }
        return nil
    }
    // Select View And Redraw
    private func setSelectedView(){
        self.removeCurrentView()
        if let stateView = views[self.state]{
            if let view = self.instanceFromNib(name: stateView){
                view.frame = self.bounds
                self.addSubview(view)
            }
        }else{
            var local: String = ""
            switch self.state{
            case .empty:
                local = "EmptyView"
                break
            case .loading:
                local = "LoadingView"
                break
            case .error:
                local = "ErrorView"
                break
            default:
                print("Cannot process local custom")
            }
            if let view = self.instanceFromNib(name: local, useDefault: true){
                view.frame = self.bounds
                self.addSubview(view)
            }
        }
        self.setNeedsLayout()
        self.setNeedsDisplay()
    }
}
