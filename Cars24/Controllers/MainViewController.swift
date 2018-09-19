//
//  ViewController.swift
//  Cars24
//
//  Created by Coffeebeans on 18/09/18.
//  Copyright © 2018 Coffeebeans. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class MainViewController: UIViewController,Navigationable,UITableViewDelegate,UICollectionViewDelegateFlowLayout {
   
    //MARK: Properties
    private var viewModelObject:MainViewModel?
    
    let holdingScrollView = UIScrollView(frame: UIScreen.main.bounds)
    
    let headerForCollectionView:UILabel = {
        let label = UILabel()
        label.textColor = AppColors.headingTextColor
        label.text = propertyHeaderText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = headingFont
        
        return label
    }()
    
    let facilityCollectionView:UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/3 - 80.0, height: 120.0)
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: UIScreen.main.bounds,collectionViewLayout:flowLayout)
        collectionView.register(FacilityCollectionViewCell.self, forCellWithReuseIdentifier: collectionViewCellIdentifier)
        collectionView.allowsMultipleSelection=false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator=false
        return collectionView
    }()
    
    let headerForTableView:UILabel = {
        let label = UILabel()
        label.text = facilityHeaderText
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = headingFont
        label.textColor = AppColors.headingTextColor
        return label
    }()
    
    let optionsTableView:UITableView = {
        let optionTableView = UITableView()
        optionTableView.translatesAutoresizingMaskIntoConstraints = false
        optionTableView.layer.borderWidth = 3.0
        optionTableView.layer.borderColor = AppColors.primaryColor.cgColor
        optionTableView.tableFooterView = UIView()
        return optionTableView
    }()
    
    let disposeBag = DisposeBag()
    
    func viewController() -> UIViewController {
        return self
    }
    
    //MARK: LifeCycle Methods
    init(viewModel:MainViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModelObject = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setupViewsOnMainView()
        bindViewsWithDataModel()
    }
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModelObject?.getDataForFacilitiesAndOptions()
    }
    
    //MARK: UIFormation (Constraints)
    func setupViewsOnMainView() {
        holdingScrollView.translatesAutoresizingMaskIntoConstraints=false
        holdingScrollView.backgroundColor = UIColor.white
        optionsTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        optionsTableView.estimatedRowHeight = ROW_HEIGHT;
        optionsTableView.rowHeight = UITableViewAutomaticDimension;
        
        facilityCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        addConstraints()
    }
    
    func addConstraints() {
        self.view.addSubview(holdingScrollView)
          holdingScrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: 800.0)
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: [], metrics: nil, views: ["scrollView":holdingScrollView]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|", options: [.alignAllCenterX], metrics: nil, views: ["scrollView":holdingScrollView,"view":self.view]))
        holdingScrollView.addSubview(headerForCollectionView)
        holdingScrollView.addSubview(facilityCollectionView)
        holdingScrollView.addSubview(headerForTableView)
        holdingScrollView.addSubview(optionsTableView)
        let viewDict = ["optionsTableView":optionsTableView,"facilityCollectionView":facilityCollectionView,"header1":headerForCollectionView,"header2":headerForTableView]
    
        holdingScrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(10)-[header1]-(10)-[facilityCollectionView(130)]-(20)-[header2]-(10)-[optionsTableView(400)]|", options: [], metrics: nil, views: viewDict))
        holdingScrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(20)-[facilityCollectionView(\(self.view.bounds.size.width - 40.0))]-(20)-|", options: [], metrics: nil, views: viewDict))
        holdingScrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(20)-[header1]|", options: [], metrics: nil, views: viewDict))
        holdingScrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(20)-[header2]|", options: [], metrics: nil, views: viewDict))
        holdingScrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(30)-[optionsTableView]-(30)-|", options: [], metrics: nil, views: viewDict))
        holdingScrollView.isScrollEnabled = true
    }
    
    //MARK: Binding Custom View & User Actions To ViewModel Properties
    func bindViewsWithDataModel() {
        
        //Binding TableView with viewmodel properties
        let tableDataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Option>>(
            configureCell: { dataSource, tableView, indexPath, optionobject in
                let cell = OptionsTableViewCell(frame: UIScreen.main.bounds)
                var newObject = optionobject
                if(indexPath.row == 0){
                    newObject.isActive = true
                }
                cell.configureCell(option: newObject)
                return cell 
        })
        
        
        self.viewModelObject?.facilitiesArray.asDriver()
            .map { [SectionModel(model: "Option", items: $0)] }
            .drive(self.optionsTableView.rx.items(dataSource: tableDataSource))
            .disposed(by: disposeBag)
        
        self.optionsTableView.rx.modelSelected(Option.self)
            .subscribe({ optionobject in
                if(optionobject.element?.id != self.viewModelObject?.lastSelectedOptionIndex){
                    
                    self.viewModelObject?.tapped(pageObject: optionobject.element!)
                    
                    if let oldCellIndex = self.viewModelObject?.facilitiesArray.value.index(where: { (option) -> Bool in
                        return option.id == self.viewModelObject?.lastSelectedOptionIndex
                    }) {
                        let oldCell = self.optionsTableView.cellForRow(at: IndexPath(item: oldCellIndex ,section:0)) as! OptionsTableViewCell
                        oldCell.selectCell(enabled: false)
                    }
                    if let newIndex = self.viewModelObject?.facilitiesArray.value.index(where: { (option) -> Bool in
                        return option.id == optionobject.element?.id
                    }) {
                        let newCell = self.optionsTableView.cellForRow(at: IndexPath(item: newIndex, section: 0)) as! OptionsTableViewCell
                        newCell.selectCell(enabled: true)
                    }
                    
                    self.viewModelObject?.lastSelectedOptionIndex = optionobject.element?.id ?? "6"
                    
                }else{
                    
                }
            }).disposed(by: disposeBag)
        
        //Binding CollectionView with viewmodel properties
        let collectionViewDataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Option>>(
            configureCell: { (datasource, collectionView, indexPath, option) -> UICollectionViewCell in
            let cell = self.facilityCollectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier, for: indexPath) as! FacilityCollectionViewCell
                var newOption=option
                if(indexPath.row == 0) {
                    newOption.isActive = true
                }
                cell.configureCell(option: newOption)
                return cell
            }
        )
        
        self.viewModelObject?.currentOptionsArray.asDriver()
            .map { [SectionModel(model: "Option", items: $0)]}
            .drive(self.facilityCollectionView.rx.items(dataSource: collectionViewDataSource))
            .disposed(by: disposeBag)
        
        self.facilityCollectionView.rx.modelSelected(Option.self)
            .subscribe(({optionobject in
                if(optionobject.element?.id != self.viewModelObject?.lastSelectedIndex){
                    if let cell = self.facilityCollectionView.cellForItem(at: IndexPath(row: Int(optionobject.element?.id ?? "1")! - 1, section: 0)) as? FacilityCollectionViewCell {
                        cell.showSelectedState(true)
                    }
                    
                    if let oldCell = self.facilityCollectionView.cellForItem(at: IndexPath(row: Int(self.viewModelObject?.lastSelectedIndex ?? "1")!-1, section: 0)) as? FacilityCollectionViewCell {
                        oldCell.showSelectedState(false)
                    }
                self.viewModelObject!.collectionViewSelected(optionObject:optionobject.element!)
                }
            })).disposed(by: disposeBag)
    }
}

extension MainViewController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.bounds.width
        let cellWidth = (width) / 3 - 35.0  // compute your cell width
        return CGSize(width: cellWidth, height: 100.0)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
}



