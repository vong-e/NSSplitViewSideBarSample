//
//  SideBarApplicationViewController.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/05.
//

import Cocoa
import WebKit

import RxCocoa
import RxSwift
import SnapKit

final class SideBarApplicationViewController: NSViewController {
    
    private let webView = WKWebView()
    
    private let setStatusBarApplicationTextField: NSTextField = {
        let textField = NSTextField(font: .systemFont(ofSize: 14), color: .getText(color: .primary))
        textField.stringValue = "스테이터스바 애플리케이션 등록"
        return textField
    }()
    
    private let setStatusBarApplicaitonSwitch: NSSwitch = {
        let toggleSwitch = NSSwitch()
        toggleSwitch.state = .off
        toggleSwitch.stringValue = "토글스위치"
        return toggleSwitch
    }()
    
    private let applicaiton: SideBarApplication
    
    // Rx
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialize
    init(application: SideBarApplication) {
        self.applicaiton = application
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        let box = NSBox(fillColor: applicaiton.backgroundColor)
        self.view = box
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubviews()
        setConstraints()
        binding()
    }
    
    deinit {
        webView.stopLoading()
    }
    
    // MARK: - Configure
    private func configure() {
        webView.load(URLRequest(url: URL(string: "https://www.naver.com")!))
        
        if DBService.getStatusBarApplicationID() == applicaiton.id {
            setStatusBarApplicaitonSwitch.state = .on
        } else {
            setStatusBarApplicaitonSwitch.state = .off
        }
        
        setStatusBarApplicaitonSwitch.target = self
        setStatusBarApplicaitonSwitch.action = #selector(setStatusBarApplicationSwitchAciton(_:))
    }
    
    // MARK: - Set UI
    private func addSubviews() {
        self.view.addSubview(webView)
        self.view.addSubview(setStatusBarApplicaitonSwitch)
        self.view.addSubview(setStatusBarApplicationTextField)
    }
    
    private func setConstraints() {
        webView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
        
        setStatusBarApplicationTextField.snp.makeConstraints { make in
            make.centerY.equalTo(setStatusBarApplicaitonSwitch.snp.centerY)
        }
        
        setStatusBarApplicaitonSwitch.snp.makeConstraints { make in
            make.leading.equalTo(setStatusBarApplicationTextField.snp.trailing).offset(10)
            make.bottom.trailing.equalToSuperview().inset(10)
        }
    }
    
    // MARK: - Binding
    private func binding() {
        self.view.rx
            .observe(\.frame)
            .asDriver(onErrorJustReturn: .zero)
            .skip(1) // SplitViewItem 으로 추가될 때 불리는 첫 번째 call 무시
            .drive(with: self,
                   onNext: { owner, frame in
                let width = max(frame.width, 300)
                DBService.setSideBarApplicaiton(width: width, appID: owner.applicaiton.id)
            })
            .disposed(by: disposeBag)
    }
    
    @objc func setStatusBarApplicationSwitchAciton(_ sender: NSSwitch) {
        switch sender.state {
        case .on:
            DBService.setStatusBarAppication(appID: applicaiton.id)
        default: // Off, Mixed State
            DBService.deleteStatusBarAppication()
        }
        
        /// StatusBar Applicaiton 설정 이후 StatusBarMenu 리프레시
        StatusBarHelper.shared.setStatusBarMenu()
    }
}
