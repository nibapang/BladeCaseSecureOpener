//
//  BladePrivacyVC.swift
//  BladeCaseSecureOpener
//
//  Created by SunTory on 2025/2/17.
//

import UIKit
import WebKit

class BladePrivacyVC: UIViewController , WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate{

    @IBOutlet weak var bladeWebView: WKWebView!
    @IBOutlet weak var bladeIndView: UIActivityIndicatorView!
    @IBOutlet weak var bladeBackBtn: UIButton!

    //MARK: - Declare Variables
    var url: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.bladeBackBtn.isHidden = self.url != nil
        self.bladeIndView.hidesWhenStopped = true
        
        bladeInitWebView()
    }
    @IBAction  func CLICCKbtnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func bladeInitWebView() {
        self.bladeWebView.backgroundColor = .black
        self.bladeWebView.scrollView.backgroundColor = .black
        self.bladeWebView.navigationDelegate = self
        self.bladeWebView.uiDelegate = self
        
        self.bladeIndView.startAnimating()
        if let adurl = url {
            if let urlRequest = URL(string: adurl) {
                let Request = URLRequest(url: urlRequest)
                bladeWebView.load(Request)
            }
        } else {
            if let urlRequest = URL(string: "https://www.termsfeed.com/live/e058b36e-0d73-4456-9860-088839b59712") {
                let Request = URLRequest(url: urlRequest)
                bladeWebView.load(Request)
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
            self.bladeIndView.stopAnimating()
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        DispatchQueue.main.async {
            self.bladeIndView.stopAnimating()
        }
    }

    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            if let url = navigationAction.request.url {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        return nil
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "" {
         
        } else if message.name == "" {
          
        }
    }

}
