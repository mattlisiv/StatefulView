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
    private var viewDictionary:[ViewState:String] = [:]
    private var views:[ViewState:UIView] = [:]
    private var completionBlocks:[ViewState:CompletionHandler] = [:]
    public typealias CompletionHandler = () -> Void
    public typealias ClickHandler = (UITapGestureRecognizer) -> Void
    
    // Set Views By Direct Reference
    public func setAvailableViews(loadingView: UIView? = nil, errorView: UIView? = nil, emptyView: UIView? = nil, customView: UIView? = nil){
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
    
    // Set Views By Dictionary
    public func setAvailableViewsByName(loadingView: String? = nil, errorView: String? = nil, emptyView: String? = nil, customView: String? = nil){
        // Loading
        if let loading = loadingView{
            viewDictionary[ViewState.loading] = loading
        }
        // Error
        if let error = errorView{
            viewDictionary[ViewState.error] = error
        }
        // Empty
        if let empty = emptyView{
            viewDictionary[ViewState.empty] = empty
        }
        // Custom
        if let custom = customView{
            viewDictionary[ViewState.custom] = custom
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
        if let view = UINib(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView{
            return view
        }
        return nil
    }
    // Select View And Redraw
    private func setSelectedView(){
        self.removeCurrentView()
        var stateView: UIView? = nil
        if let viewByRef = views[self.state]{
            stateView = viewByRef
        }else if let stateViewByName = viewDictionary[self.state]{
            if let view = self.instanceFromNib(name: stateViewByName){
                stateView = view
            }
        }
        if completionBlocks[self.state] != nil{
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
            stateView!.addGestureRecognizer(tapGesture)
        }
        stateView?.frame = self.bounds
        self.addSubview(stateView!)
        stateView?.setNeedsLayout()
        stateView?.setNeedsDisplay()
        self.setNeedsLayout()
        self.setNeedsDisplay()
    }

    @objc func handleTap(sender: UITapGestureRecognizer){
        if let block = completionBlocks[self.state]{
            block()
        }
    }
    
    // Handle Simple Action Events of Views
    public func setHandlers(loadingView: CompletionHandler? = nil, errorView: CompletionHandler? = nil, emptyView: CompletionHandler? = nil, customView: CompletionHandler? = nil){
        // Loading
        if let loading = loadingView{
            completionBlocks[ViewState.loading] = loading
        }
        // Error
        if let error = errorView{
            completionBlocks[ViewState.error] = error
        }
        // Empty
        if let empty = emptyView{
            completionBlocks[ViewState.empty] = empty
        }
        // Custom
        if let custom = customView{
            completionBlocks[ViewState.custom] = custom
        }
    }
}
