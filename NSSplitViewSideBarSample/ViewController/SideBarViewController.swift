//
//  SideBarViewController.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/02.
//

import Cocoa

final class SideBarViewController: NSViewController {
    
    private let scrollView: NSScrollView = {
       let scrollView = NSScrollView()
        return scrollView
    }()
    
    private let flippedClipView: FlippedClipView = {
        let flippedClipView = FlippedClipView()
        flippedClipView.translatesAutoresizingMaskIntoConstraints = false
        return flippedClipView
    }()
    
    private let sideBarAppStackView: NSStackView = {
        let stackView = NSStackView()
        stackView.orientation = .vertical
        stackView.alignment = .centerX
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    private var sideBarApplicationViewList: [SideBarApplicationView] = []
    
    // MARK: - Initialize
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        let box = NSBox(fillColor: .clear)
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
        SideBarApplication.allCases.forEach { application in
            let sidebarApplicationView = SideBarApplicationView(application: application)
            sideBarApplicationViewList.append(sidebarApplicationView)
        }
    }
    
    // MARK: - Set UI
    private func addSubviews() {
        self.view.addSubview(scrollView)
        scrollView.contentView = flippedClipView
        scrollView.documentView = sideBarAppStackView
        
        sideBarApplicationViewList.forEach { applicationView in
            sideBarAppStackView.addArrangedSubview(applicationView)
        }
    }
    
    private func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        sideBarAppStackView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
        }
        
        sideBarApplicationViewList.forEach { applicationView in
            applicationView.snp.makeConstraints { make in
                make.height.equalTo(30)
                make.horizontalEdges.equalToSuperview()
            }
        }
    }
}
