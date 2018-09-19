//
//  MainViewModel.swift
//  Cars24
//
//  Created by Coffeebeans on 18/09/18.
//  Copyright © 2018 Coffeebeans. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {
    
    //MARK: Properties
    var coordinator: SceneCoordinatorType?
    let sharedInstance = NetworkManager.sharedInstance
    private var modelData:BehaviorRelay<FacilitiesModel>
    var lastSelectedIndex = "1"
    var lastSelectedOptionIndex = "6"
    var facilitiesArray: BehaviorRelay<[Option]>
    var currentOptionsArray: BehaviorRelay<[Option]>
    let disposeBag = DisposeBag()
    
    init(coordinator:SceneCoordinatorType) {
        self.coordinator=coordinator
        self.facilitiesArray = BehaviorRelay<[Option]>(value:[])
        self.currentOptionsArray = BehaviorRelay<[Option]>(value:[])
        self.modelData = BehaviorRelay<FacilitiesModel>(value: FacilitiesModel(facilities: nil, exclusions: nil))
        
        self.modelData.asObservable().subscribe(onNext: {data in
            let extractedFacilitiesArray = data.facilities?.filter({ (facility) -> Bool in
                return facility.facility_id == "1" && facility.name == "Property Type"
            }).first?.options
            
            if(extractedFacilitiesArray?[0].id != nil){
                self.currentOptionsArray.accept(extractedFacilitiesArray ?? [])
                let selectedOptionsArray = self.findOptionsArrayForSelectedProperty(forId:extractedFacilitiesArray?[0].id ?? "")
                self.facilitiesArray.accept(selectedOptionsArray)
            }
            
        }).disposed(by: disposeBag)
    }
    //MARK:NetworkCall
    func getDataForFacilitiesAndOptions() {
        
        //MARK:Logic For CoreData Lies here
        /*if(timestamp saved in coredata is old){
         we can hit the api
         }else{
         fetch from coredata model Object and populate facilitiesArray
         & OptionsArray to show locally saved UI
         }*/
        
        
        
        sharedInstance.getDataForFacilititesAndOptions { (model, error) in
            if(error == nil && model != nil) {
                self.modelData.accept(model!)
            }else{
                //TODO: Handle Error
            }
        }
    }
    
    //MARK: Populate options array for Selected Property based on exclusion array.
    func findOptionsArrayForSelectedProperty(forId:String) -> [Option] {
        var options:[Option] = []
        
        for facility in modelData.value.facilities ?? [] {
            if(facility.facility_id != "1"){
                options += facility.options ?? []
            }
        }
        
        for exclusion in modelData.value.exclusions ?? [[]] {
            if(exclusion[0].options_id == forId) {
                if(Int(lastSelectedOptionIndex)! < Int(exclusion[1].options_id!)! || Int(lastSelectedIndex)! < Int(exclusion[1].options_id!)!){
                    let index = options.index(where: { (option) -> Bool in
                        return option.id! == exclusion[1].options_id!
                    }) ?? 0
                    options[index].isDisabled = true
                }else{
                    
                    if let index = options.index(where: { (option) -> Bool in
                        return option.id! == exclusion[1].options_id!
                    }) {
                        if(exclusion[1].facility_id == forId) {
                            options[index].isActive = true
                        }else{
                            options[index].isActive = false
                        }
                    }
                }
            }else{
                //TODO:Handle Error
            }
        }
        return options
    }
    
    
    //MARK: CollectionView And TableView Cell Select
    func collectionViewSelected(optionObject:Option) {
       lastSelectedIndex = optionObject.id ?? "1"
       self.facilitiesArray.accept((self.findOptionsArrayForSelectedProperty(forId: optionObject.id ?? "1")))
        lastSelectedOptionIndex = "6"
    }
    
    func tapped(pageObject:Option) {
        self.facilitiesArray.accept((self.findOptionsArrayForSelectedProperty(forId: pageObject.id ?? "1")))
    }
}
