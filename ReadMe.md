# Cars24
### MVVM RX Swift based ExclusionList

### Views
  Generic UI Components responsible for presenting data binded to viewmodel. 
  It takes care to update specific change in the view element whose binded data in viewModel undergoes any changes.
  
### ViewModels
  Binded with viewcontroller to modularize actions and business logic in seperate place.
  Containing Coordinator + NetworkManager sharedInstance to handle ViewController's responsibilities in a \
  modular way by binding techniques provided by rx libaries eg Observable+Driver..etc classes .
 
### ViewControllers
  UIViewControllers asserting to different protocols to manage api calls, caching, RxObservers, etc depending upon business
   logic requirements. 
  It holds a private instance of viewModel to bind viewModelData to its view components, which can be then changed based on 
   set of User Actions OR Any Change In Server Data(WebHooks) resulting in chaining of events.
   Along with which we can combine events to deduce information based on multiple events happening asyncronously.
  
### NetworkingAndModels
  ## NetworkLayer 
    API Parsing using Codables Protocol
    -It has completionHandlers which passes the data to specific viewModel which changes the binded properties to execute the
      changes accordingly.
       
  ## Models
    -# FacilitiesModel containing -: facilities and exclusions array.
    
### Resources
  Contains image assets along with some important project files like info.plist + CoreData +
   LaunchScreen.storyboard+Info.plist.
  
### Coordinators
  This has a main single generic singleton class with the name AppCoordinator responsible for managing routing mechanism of
   the app.
  It handles application-stack of viewControllers by implementing efficient memory management techniques along with simplified
  mechanism to re-route your application in different use case scenerios.
  ## AppCoordinator-: 
    -actualViewController(),-pop(),-push(),-popToRoot() helps in managing view heirarchy without any glitches.
    -transition() delegate method help in executing deciding part for managing heirarchy. 
        
### HelperFiles
 Constants.swift file used for all static data of app at 1 place to reuse it.


### Protocols in the app  
    ## Scene -: Implementing InstantiatableFromNIB,InstantiatableFromStoryboard,Navigationable protocols.
    
    ## SceneCoordinatorType -: Implementing transition protocol for navigation in the app to retrieve saved state without
                              loading the content again.
    ## RxProtocols for observing changes in ui elements.

## Dependencies
   # pod 'RxCocoa'
   # pod 'RxSwift'
      It makes it modular to test your code further. Improves maintanance, scalability , 
      robustness , feasibility of code resulting in smart debugging.
   # pod 'RxDataSources' used for tableView listing to bind datasource of tableview with respective viewmodel's property.
