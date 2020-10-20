//
//  ExampleViewController.swift
//  DJPullMenuDemo
//
//  Created by fcn on 2020/10/14.
//

import UIKit

class ExampleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var componentTitle: String?
    var dataCount = 10
    
    // prama MARK - Property
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: self.view.bounds, style: UITableView.Style.grouped)
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.estimatedSectionHeaderHeight = 10
        tableView.estimatedSectionFooterHeight = 0.01
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        return tableView
    }()
    
    // prama MARK - VC life
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.tableView.isHidden = false
        
        switch self.componentTitle {
        case "MJRefreshComponent":do {
            print("mj_header 所指向的是MJRefreshHeader类及其子类")
            print("mj_footer 所指向的是MJRefreshFooter类及其子类")
        }
        case "MJRefreshHeader":do {
            self.tableView.mj_header = MJRefreshHeader.init(refreshingTarget: self, refreshingAction: #selector(loadNewData))
        }
        case "MJRefreshStateHeader":do {
            self.tableView.mj_header = MJRefreshStateHeader.init(refreshingTarget: self, refreshingAction: #selector(loadNewData))
        }
        case "MJRefreshNormalHeader":do {
            self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(loadNewData))
        }
        case "MJRefreshGifHeader":do {

        }
        case "MJRefreshFooter":do {
            self.tableView.mj_footer = MJRefreshFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        }
        case "MJRefreshBackFooter":do {
            self.tableView.mj_footer = MJRefreshBackFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMoreData))

        }
        case "MJRefreshBackStateFooter":do {
            self.tableView.mj_footer = MJRefreshBackStateFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMoreData))

        }
        case "MJRefreshBackNormalFooter":do {
            self.tableView.mj_footer = MJRefreshBackNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMoreData))

        }
        case "MJRefreshBackGifFooter":do {

        }
        case "MJRefreshAutoFooter":do {
            self.tableView.mj_footer = MJRefreshAutoFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        }
        case "MJRefreshAutoStateFooter":do {
            self.tableView.mj_footer = MJRefreshAutoStateFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMoreData))

        }
        case "MJRefreshAutoNormalFooter":do {
            self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMoreData))

        }
        case "MJRefreshAutoGifFooter":do {

        }
        case "MJRefreshTrailer":do {

        }
        case "MJRefreshStateTrailer":do {

        }
        case "MJRefreshNormalTrailer":do {

        }
        default:
            print("无匹配项")
        }
    }
    
    // prama MARK - UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    // prama MARK - UITableViewDataSource
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    @objc func loadNewData() {
        print("下拉刷新")
        self.dataCount = 10
        self.tableView.reloadData()
        self.tableView.mj_header?.endRefreshing()
    }
    
    @objc func loadMoreData() {
        print("上拉加载")
        self.dataCount += 2
        self.tableView.reloadData()
        self.tableView.mj_footer?.endRefreshing()
    }
}
