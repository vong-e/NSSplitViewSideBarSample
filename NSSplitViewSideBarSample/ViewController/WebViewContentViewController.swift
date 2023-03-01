//
//  WebViewContentViewController.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/02.
//

import Cocoa
import WebKit

import SnapKit

final class WebViewContentViewController: NSViewController {
    
    private let webView = WKWebView()
    
    // MARK: - Initialize
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        let box = NSBox(fillColor: .lightGray)
        self.view = box
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubviews()
        setConstraints()
    }
    
    // MARK: - Configure
    private func configure() {
        webView.load(URLRequest(url: URL(string: "https://www.naver.com")!))
    }
    
    // MARK: - Set UI
    private func addSubviews() {
        self.view.addSubview(webView)
    }
    
    private func setConstraints() {
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
