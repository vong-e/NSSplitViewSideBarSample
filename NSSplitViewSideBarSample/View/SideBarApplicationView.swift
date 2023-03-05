//
//  SideBarApplicationView.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/04.
//

import Cocoa

import RxCocoa
import RxSwift
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
    
    // Rx
    private let disposeBag = DisposeBag()    
    
    init(application: SideBarApplication) {
        self.application = application
        super.init(frame: .zero)
        configure()
        addSubviews()
        setConstraints()
        binding()
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
            make.width.equalTo(26)
            make.verticalEdges.equalToSuperview()
        }
        
        toggleEffectLineBox.snp.makeConstraints { make in
            make.width.equalTo(3)
            make.leading.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }
        
        applicationLogoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(18)
        }
    }
    
    private func setSelectedUI() {
        toggleEffectContainerBox.fillColor = .getBackground(color: .light)
        toggleEffectLineBox.fillColor = .getPoint(color: .primary)
        applicationLogoImageView.image = .getIcon(image: .close)
    }
    
    private func setDeselectedUI() {
        toggleEffectContainerBox.fillColor = .clear
        toggleEffectLineBox.fillColor = .clear
        applicationLogoImageView.image = application.logo
    }
    
    // MARK: - Binding
    private func binding() {
        SideBarApplicaitonHelper.shared
            .selectedApplicationIDObservable
            .asDriver(onErrorJustReturn: nil)
            .drive(with: self,
                   onNext: { owner, selectedID in
                if owner.application.id == selectedID {
                    owner.setSelectedUI()
                } else {
                    owner.setDeselectedUI()
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Mouse Event Tracking
extension SideBarApplicationView {
    override func mouseDown(with event: NSEvent) {
        isSelected = !isSelected
        SideBarApplicaitonHelper.shared.setApplication(selected: isSelected, id: application.id)
        
    }
    override func mouseEntered(with event: NSEvent) {
        setMouseEnteredUI()
    }
    
    override func mouseExited(with event: NSEvent) {
        setMouseExitedUI()
    }
    
    private func setMouseEnteredUI() {
        NSCursor.pointingHand.set()
        setApplicationLogoImage(size: 22)
        
        if isSelected {
            applicationLogoImageView.image = .getIcon(image: .close)
        } else {
            applicationLogoImageView.image = application.logo
        }
    }
    
    private func setMouseExitedUI() {
        NSCursor.arrow.set()
        applicationLogoImageView.image = application.logo
        
        if isSelected {
            setApplicationLogoImage(size: 22)
        } else {
            setApplicationLogoImage(size: 18)
        }
    }
    
    private func setApplicationLogoImage(size: CGFloat) {
        applicationLogoImageView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(size)
        }
    }
}
