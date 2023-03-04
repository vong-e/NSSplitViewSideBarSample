//
//  SideBarApplicationView.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/04.
//

import Cocoa

import SnapKit

final class SideBarApplicationView: NSView {
    
    private let toggleEffectContainerBox: NSBox = {
        let box = NSBox(cornerRadius: 4, fillColor: .systemGray)
        return box
    }()
    
    private let toggleEffectLineBox: NSBox = {
        let box = NSBox(fillColor: .red)
        return box
    }()
    
    private let applicationLogoImageView: NSImageView = {
        let imageView = NSImageView()
        return imageView
    }()

    private var isSelected: Bool = false
    
    private var application: SideBarApplication
    
    init(application: SideBarApplication) {
        self.application = application
        super.init(frame: .zero)
        addSubviews()
        setConstraints()
        self.setTrackingArea()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    private func configure() {
        applicationLogoImageView.image = application.logo
    }
    
    // MARK: - Set UI
    private func addSubviews() {
        self.addSubview(toggleEffectContainerBox)
        self.addSubview(toggleEffectLineBox)
        
        toggleEffectContainerBox.addSubview(applicationLogoImageView)
    }
    
    private func setConstraints() {
        toggleEffectContainerBox.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(40)
            make.verticalEdges.equalToSuperview()
        }
        
        toggleEffectLineBox.snp.makeConstraints { make in
            make.width.equalTo(3)
            make.leading.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }
        
        applicationLogoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setSelectedUI() {
        
    }
    private func setDeselectedUI() {
//        toggleEffectContainerBox.fillColor = .
//        toggleEffectLineBox.fillColor = .clear
    }
}

// MARK: - Mouse Event Tracking
extension SideBarApplicationView {
    override func mouseDown(with event: NSEvent) {
        print("mouse down")
    }
    override func mouseEntered(with event: NSEvent) {
//        if isEnabled {
//            NSCursor.pointingHand.set()
//        } else {
//            NSCursor.arrow.set()
//        }
    }
    
    override func mouseExited(with event: NSEvent) {
//        NSCursor.arrow.set()
    }
}