//
//  ViewController.swift
//  MJRefreshDemo
//
//  Created by fcn on 2020/10/13.
//

import UIKit

let MJEx1_baseComponent = "刷新控件基类 -- Component"
let MJEx2_header = "下拉刷新控件 -- Header"
let MJEx3_footer = "上拉刷新控件 -- Footer"
let MJEx4_trailer = "左滑刷新控件 -- Trailer"


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private lazy var examples: [[MJExample]] = {
        var examples = [[MJExample]]()
        
        // 基类
        let ex1_baseComponent = MJExample.init("MJRefreshComponent", ViewController.self)
        ex1_baseComponent.header = MJEx1_baseComponent
        examples.append([ex1_baseComponent])
        
        // 下拉刷新
        let ex2_baseHeader = MJExample.init("MJRefreshHeader", ViewController.self)
        ex2_baseHeader.header = MJEx2_header
        let ex2_1_StateHeader = MJExample.init("MJRefreshStateHeader", ViewController.self)
        let ex2_2_NormalHeader = MJExample.init("MJRefreshNormalHeader", ViewController.self)
        let ex2_3_GifHeader = MJExample.init("MJRefreshGifHeader", ViewController.self)
        examples.append([ex2_baseHeader, ex2_1_StateHeader, ex2_2_NormalHeader, ex2_3_GifHeader])

        // 上拉刷新
        let ex3_baseFooter = MJExample.init("MJRefreshFooter", ViewController.self)
        ex3_baseFooter.header = MJEx3_footer
        
        let ex3_1_backFooter = MJExample.init("MJRefreshBackFooter", ViewController.self)
        let ex3_3_backStateFooter = MJExample.init("MJRefreshBackStateFooter", ViewController.self)
        let ex3_5_backNormalFooter = MJExample.init("MJRefreshBackNormalFooter", ViewController.self)
        let ex3_6_backGifFooter = MJExample.init("MJRefreshBackGifFooter", ViewController.self)
        
        let ex3_2_autoFooter = MJExample.init("MJRefreshAutoFooter", ViewController.self)
        let ex3_4_autoStateFooter = MJExample.init("MJRefreshAutoStateFooter", ViewController.self)
        let ex3_7_autoNormalFooter = MJExample.init("MJRefreshAutoNormalFooter", ViewController.self)
        let ex3_8_autoGifFooter = MJExample.init("MJRefreshAutoGifFooter", ViewController.self)
        examples.append([ex3_baseFooter, ex3_1_backFooter, ex3_3_backStateFooter, ex3_5_backNormalFooter, ex3_6_backGifFooter, ex3_2_autoFooter, ex3_4_autoStateFooter, ex3_7_autoNormalFooter, ex3_8_autoGifFooter])
        
        // 左滑刷新
        let ex4_baseTrailer = MJExample.init("MJRefreshTrailer", ViewController.self)
        ex4_baseTrailer.header = MJEx4_trailer
        
        let ex4_stateTrailer = MJExample.init("MJRefreshStateTrailer", ViewController.self)
        let ex4_normalTrailer = MJExample.init("MJRefreshNormalTrailer", ViewController.self)
        examples.append([ex4_baseTrailer])
        
        return examples
    }()
    
    // prama MARK - Property
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: self.view.bounds, style: UITableView.Style.plain)
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.estimatedSectionHeaderHeight = 30
        tableView.estimatedSectionFooterHeight = 0.01
        return tableView
    }()
    
    // prama MARK - VC life
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.tableView.isHidden = false
    }
    
    // prama MARK - UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.examples.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.examples[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ex = self.examples[indexPath.section][indexPath.row]
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = ex.title
        return cell
    }
    
    // prama MARK - UITableViewDataSource
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let header = self.examples[section].first!.header {
            return "  \(header)"
        }
        return ""
    }
}

