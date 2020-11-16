//
//  ExampleViewController.swift
//  DJPullMenuDemo
//
//  Created by fcn on 2020/10/14.
//

import UIKit

class ExampleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {

    var componentTitle: String?
    var dataCount = 6
    
    lazy var dropdown_loading_images: [UIImage] = {
        var dropdown_loading_images = [UIImage]()
        for i in 1...3 {
            dropdown_loading_images.append(UIImage.init(named: "dropdown_loading_0\(i)")!)
        }
        return dropdown_loading_images
    }()
    
    lazy var dropdown_anim_images: [UIImage] = {
        var dropdown_anim_images = [UIImage]()
        for i in 1...60 {
            dropdown_anim_images.append(UIImage.init(named: "dropdown_anim__000\(i)")!)
        }
        return dropdown_anim_images
    }()

    
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        return tableView
    }()
    
    private lazy var collectionView: UICollectionView = {
        
        var flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSize.init(width: 30, height: 450)
        flowLayout.minimumLineSpacing = 10
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: (self.view.bounds.size.height - flowLayout.itemSize.height - flowLayout.minimumLineSpacing * 2) / 2, width: self.view.bounds.size.width, height: flowLayout.itemSize.height + flowLayout.minimumLineSpacing * 2), collectionViewLayout: flowLayout)
        self.view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .lightGray
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        
        return collectionView
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
            let mj_header = MJRefreshGifHeader.init(refreshingTarget: self, refreshingAction: #selector(loadNewData))
            mj_header.setImages(self.dropdown_anim_images, for: .idle)
            mj_header.setImages(self.dropdown_loading_images, for: .pulling)
            mj_header.setImages(self.dropdown_loading_images, for: .refreshing)
            self.tableView.mj_header = mj_header
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
            self.tableView.isPagingEnabled = true
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
            self.tableView.isHidden = true
            self.collectionView.isHidden = false
            self.collectionView.mj_trailer = MJRefreshTrailer.init(refreshingTarget: self, refreshingAction: #selector(trailLoad))
        }
        case "MJRefreshStateTrailer":do {
            self.tableView.isHidden = true
            self.collectionView.isHidden = false
            self.collectionView.mj_trailer = MJRefreshStateTrailer.init(refreshingTarget: self, refreshingAction: #selector(trailLoad))
        }
        case "MJRefreshNormalTrailer":do {
            self.tableView.isHidden = true
            self.collectionView.isHidden = false
            self.collectionView.mj_trailer = MJRefreshNormalTrailer.init(refreshingTarget: self, refreshingAction: #selector(trailLoad))
        }
        default:
            print("无匹配项")
        }
    }
    
    // prama MARK - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    // prama MARK - UITableViewDelegate
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
    
    // prama MARK - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.contentView.backgroundColor = .white
        var lab: UILabel? = cell.contentView.subviews.first as? UILabel
        if lab == nil {
            lab = UILabel.init(frame: cell.bounds)
            cell.contentView.addSubview(lab!)
            lab?.textAlignment = .center
        }
        lab!.text = "\(indexPath.row)"
        return cell
    }

    // prama MARK - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
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
    
    @objc func trailLoad() {
        print("左滑加载")
        self.dataCount += 2
        self.collectionView.reloadData()
        self.collectionView.mj_trailer?.endRefreshing()
    }
}
