//
//  SideBarViewController.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/02.
//

import Cocoa

import RxCocoa
import RxSwift
import SnapKit

final class SideBarViewController: NSViewController {
    
    private let scrollView: NSScrollView = {
        let scrollView = NSScrollView()
        return scrollView
    }()
    
    private let flippedClipView: FlippedClipView = {
        let flippedClipView = FlippedClipView()
        flippedClipView.translatesAutoresizingMaskIntoConstraints = false
        flippedClipView.backgroundColor = .getBackground(color: .base)
        return flippedClipView
    }()
    
    private let sideBarAppStackView: NSStackView = {
        let stackView = NSStackView()
        stackView.orientation = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    // Rx
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialize
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        let box = NSBox(fillColor: .getBackground(color: .base))
        self.view = box
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        binding()
    }
    
    // MARK: - Set UI
    private func addSubviews() {
        self.view.addSubview(scrollView)
        scrollView.contentView = flippedClipView
        scrollView.documentView = sideBarAppStackView
    }
    
    private func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview()
        }
        
        sideBarAppStackView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
        }
        
    }
    
    private func setSideBar(applicaitonList: [SideBarApplication]) {
        sideBarAppStackView.subviews.removeAll()
        
        applicaitonList.forEach { application in
            let sideBarApplicationView = SideBarApplicationView(application: application)
            sideBarAppStackView.addArrangedSubview(sideBarApplicationView)
            
            sideBarApplicationView.snp.makeConstraints { make in
                make.height.equalTo(30)
                make.horizontalEdges.equalToSuperview()
            }
        }
    }
    
    // MARK: - Binding
    private func binding() {
        SideBarApplicaitonHelper.shared
            .sideBarApplicaitonListObservable
            .asDriver(onErrorJustReturn: [])
            .drive(with: self,
                   onNext: { owner, applicationList in
                owner.setSideBar(applicaitonList: applicationList)
            })
            .disposed(by: disposeBag)
    }
}
