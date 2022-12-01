//
//  WebViewTestVC.swift
//  MySwiftToys
//
//  Created by SongMengLong on 2022/12/1.
//

import UIKit
import WebKit

class WebViewTestVC: UIViewController {

    private lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        configuration.preferences = WKPreferences()
        configuration.preferences.minimumFontSize = 10
        configuration.preferences.javaScriptEnabled = true // 该属性稍后关闭
        let jScript = "`var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta)`;"
        let wkUScript = WKUserScript(source: jScript, injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: true)
        
        let wkUController = WKUserContentController()
        wkUController.addUserScript(wkUScript)
        
        configuration.userContentController = wkUController
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
//        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.isScrollEnabled = true
        webView.clipsToBounds = true
        webView.isUserInteractionEnabled = true
        return webView
    }()
    
    /// 进度条
    private var progressView: UIProgressView = {
        let progressView = UIProgressView(frame: CGRect.zero)
        return progressView
    }()
            
    /// url路径名字
    var htmlFile: String = String() {
        didSet {
            guard let path = Bundle.main.path(forResource: self.htmlFile, ofType: "html") else {
                debugPrint("获取路径失败？")
                return
            }
                    
            // 加载本地html
            self.webView.load(URLRequest(url: URL(fileURLWithPath: path)))
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "测试WebView"
        
        self.setupSubViews()
        
        
//        self.requestUrl()
        
    }
    
    
    private func requestUrl() -> Void {
        guard let path = Bundle.main.path(forResource: "JStoOC", ofType: "html") else {
            debugPrint("获取路径失败？")
            return
        }
                
        // 加载本地html
        self.webView.load(URLRequest(url: URL(fileURLWithPath: path)))
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WebViewTestVC: WKUIDelegate {
    
    
}

extension WebViewTestVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
       debugPrint("didFinish 已经加载了??")
        // 创建js字符串
        let js = """
                function imgAutoFit() {
                var imgs = document.getElementsByTagName('img');
                for (var i = 0; i < imgs.length; ++i) {
                var img = imgs[i];
                img.style.maxWidth = '100%';
                img.style.height = 'auto';
                }
                }
                """
        
        // 注入js到html中
        self.webView.evaluateJavaScript(js) { (object, error) in
            debugPrint("注入JS", object as Any, error as Any)
        }
        // 调用
        self.webView.evaluateJavaScript("imgAutoFit()") { (object, error) in
            debugPrint("调用JS", object as Any, error as Any)
        }
    }
            
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//
//        debugPrint("进入该页面？")
//    }
//
//    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        debugPrint("????")
//    }
    
    
    
}

extension WebViewTestVC {
    
    private func setupSubViews() -> Void {
        self.view.addSubview(self.webView)
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self.webView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.webView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.webView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.webView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0),
        ])
    }
}
