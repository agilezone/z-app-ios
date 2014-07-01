//
//  HomeViewController.swift
//  ZApp
//
//  Created by Numericable on 25/06/2014.
//  Copyright (c) 2014 AgileZone. All rights reserved.
//

import Foundation

class HomeViewController : UIViewController, WidgetIsClickedProtocol, UITableViewDataSource, UITableViewDelegate {
    var homeTable: UITableView?
    var homeWidgetList : Array<HomeBasicWidget> = HomeBasicWidget[]()
    let widgetHeight : CGFloat = 200
    let widegtWidth : CGFloat = 320
    var sectionList : HomeComponent[]?
    var splitMenu : SplitMenuWidget?
    var homeSectionList : HomeComponent[] = HomeComponent[]()
    
    override func viewDidLoad()  {
        //let atHome : Bool = true
        var productURl: String = ""
        let topBarHeight : CGFloat = 60
        let tabBarHeight : CGFloat = 40
        
        homeTable = UITableView(frame: CGRectMake(0, topBarHeight, widegtWidth, self.view.frame.size.height - topBarHeight - tabBarHeight))
        homeTable!.dataSource = self
        homeTable!.delegate = self
        self.view.addSubview(homeTable)
        
        initSectionList()
        homeTable!.reloadData()
        homeTable!.separatorStyle = UITableViewCellSeparatorStyle.None
        
        /*
        if !atHome {
            productURl = "http://192.168.0.32:3000/api/products?token=4f751e4e4f773a9611dd62f051d7a99cb1aa75a78dea79a7"
        } else {
            productURl = "http://192.168.0.12:3000/api/products?token=fbc33ec2976f2c70b36a989dc28041f942f89e1e9c16eb56"
        }
        
        var error : NSError?
        var jsonError : NSError?
        var productUrl : NSURL = NSURL.URLWithString(productURl)
        let jsonData = NSData.dataWithContentsOfURL(productUrl, options: nil, error: &error)
        let jsonDict = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &jsonError) as NSDictionary
        
        var productsList : NSArray = jsonDict.objectForKey("products") as NSArray
        */
        
        var error : NSError?
        
        var path = NSBundle.mainBundle().pathForResource("sampleData", ofType: "json")
        var jsonData = NSData.dataWithContentsOfFile(path, options: nil, error: &error)
        let jsonDict = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
        
        let productsList : NSArray = jsonDict.objectForKey("products") as NSArray
        
        var proList = ZProduct[]()
        
        for product:AnyObject in productsList {
            var zProduct = ZProduct();
            let pro = product as NSDictionary

            zProduct.available_on = pro.objectForKey("available_on") as? String
            zProduct.price = pro.objectForKey("price") as? Int
            zProduct.shippingCategory = pro.objectForKey("shipping_category_id") as? Int
            zProduct.id = pro.objectForKey("id") as? Int
            zProduct.description = pro.objectForKey("description") as? String
            proList.append(zProduct);
            
        }
        var i:CGFloat = 0
        
        /*
        //Init Menu
        //splitMenu = SplitMenuWidget(frame: CGRectMake(0, widgetHeight, 320, CGFloat(productsStringList.count) * 40))
        splitMenu = SplitMenuWidget(frame: CGRectZero)
        splitMenu!.compile()
        splitMenu!.tableDataSourceList = productsStringList
        splitMenu!.update()
        //self.scrollView.addSubview(splitMenu)
        //Initailly hidden
        splitMenu!.hidden = true
        
        for aString in sectionList {
            var aElement : HomeBasicWidget = HomeBasicWidget(frame: CGRectMake(0, i * widgetHeight, widegtWidth, widgetHeight))
            aElement.clickedDelegate = self
            homeWidgetList.append(aElement)
            //scrollView.addSubview(aElement)
            i++;
        }
        //scrollView.contentSize = CGSizeMake(widegtWidth, widgetHeight * i)
        */
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    func widgetIsClicked(widget : HomeBasicWidget)   {
        
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        println("homeSectionCount: \(homeSectionList.count)")
        return homeSectionList.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) ->UITableViewCell! {
        var cell : UITableViewCell?
        var homeSection = self.homeSectionList[indexPath.row]
        switch homeSection.componentType! {
        case .homeSection:
            if cell == nil {
                cell = HomeBasicWidget(style: UITableViewCellStyle.Default, reuseIdentifier: "homeSectionCell")
                (cell as HomeBasicWidget).compile()
            } else {
                cell = tableView.dequeueReusableCellWithIdentifier("homeSectionCell") as HomeBasicWidget
                (cell as HomeBasicWidget).update()
            }
            (cell as HomeBasicWidget).homeComponent = (homeSection as HomeComponent)
            break
        case .firstLevelMenu:
            if cell == nil {
                cell = FirstLevelMenuCell(style: UITableViewCellStyle.Default, reuseIdentifier: "firstLevelMenuCell")
            } else {
                cell = tableView.dequeueReusableCellWithIdentifier("firstLevelMenuCell") as? FirstLevelMenuCell
            }
            (cell as FirstLevelMenuCell).homeComponent = (homeSection as HomeComponent)
            cell!.text = homeSection.sectionName
            break
        case .secondLevelMenu:
            if cell == nil {
                cell = SecondLevelMenuCell(style: UITableViewCellStyle.Default, reuseIdentifier: "secondLevelMenuCell")
            } else {
                cell = tableView.dequeueReusableCellWithIdentifier("secondLevelMenuCell") as? SecondLevelMenuCell
            }
            (cell as SecondLevelMenuCell).homeComponent = (homeSection as HomeComponent)
            cell!.text = homeSection.sectionName
            break
        default:
            break
        }
        
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        var homeSection = self.homeSectionList[indexPath.row]
        switch homeSection.componentType! {
        case .homeSection:
            return 200
        case .firstLevelMenu:
            return 64
        case .secondLevelMenu:
            return 40
        default:
            return 44
        }
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        var homeSection = self.homeSectionList[indexPath.row]
        var insertedIndexPaths : NSIndexPath[] = NSIndexPath[]()
        var deleteIndexPaths : NSIndexPath[] = NSIndexPath[]()
        var shouldOpen : Bool = false
        switch homeSection.componentType! {
        case .homeSection:
            var i = indexPath.row + 1
            var newIndexPath = NSIndexPath(forRow: i, inSection: 0)
            // Get next cell
            var nextSection = homeSectionList[i]
            switch nextSection.componentType! {
            case .homeSection:
                shouldOpen = true
                if homeSection.subSection {
                    for subSection in homeSection.subSection! {
                        homeSectionList.insert(subSection, atIndex: i)
                        insertedIndexPaths += newIndexPath
                        i++
                        newIndexPath = NSIndexPath(forRow: i, inSection: 0)
                    }
                }
                break
            case .firstLevelMenu:
                shouldOpen = false
                var j : Int = i
                while nextSection.componentType! == HomeComponent.kComponentType.firstLevelMenu || nextSection.componentType! == HomeComponent.kComponentType.secondLevelMenu{
                    print(newIndexPath)
                    deleteIndexPaths += newIndexPath
                    homeSectionList.removeAtIndex(j)
                    print(nextSection.sectionName!)
                    nextSection = homeSectionList[j]
                    i++
                    newIndexPath = NSIndexPath(forRow: i, inSection: 0)
                }
                print(deleteIndexPaths)
                break
            case .secondLevelMenu:
                shouldOpen = false
                var j : Int = i
                while  nextSection.componentType! == HomeComponent.kComponentType.firstLevelMenu || nextSection.componentType! == HomeComponent.kComponentType.secondLevelMenu{
                    deleteIndexPaths += newIndexPath
                    homeSectionList.removeAtIndex(j)
                    print(nextSection.sectionName!)
                    nextSection = homeSectionList[j]
                    i++
                    newIndexPath = NSIndexPath(forRow: i, inSection: 0)
                }
                break
            default:
                break
            }
        case .firstLevelMenu:
            var i = indexPath.row + 1
            var newIndexPath = NSIndexPath(forRow: i, inSection: 0)
            // Get next section
            var nextSection = homeSectionList[i]
            
            switch nextSection.componentType! {
            case .firstLevelMenu:
                shouldOpen = true
                if homeSection.subSection {
                    for subSection in homeSection.subSection! {
                        homeSectionList.insert(subSection, atIndex: i)
                        insertedIndexPaths += newIndexPath
                        i++
                        newIndexPath = NSIndexPath(forRow: i, inSection: 0)
                    }
                }
                break
            case .secondLevelMenu:
                shouldOpen = false
                var j : Int = i
                while nextSection.componentType! == HomeComponent.kComponentType.secondLevelMenu{
                    deleteIndexPaths += newIndexPath
                    homeSectionList.removeAtIndex(j)
                    print(nextSection.sectionName!)
                    nextSection = homeSectionList[j]
                    i++
                    newIndexPath = NSIndexPath(forRow: i, inSection: 0)
                }
                break
            default:
                break
            }
        default:
            break
        }
        
        //self.homeTable!.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Fade)
        if shouldOpen {
            self.homeTable!.insertRowsAtIndexPaths(insertedIndexPaths, withRowAnimation: UITableViewRowAnimation.Fade)
        } else {
            self.homeTable!.deleteRowsAtIndexPaths(deleteIndexPaths, withRowAnimation: UITableViewRowAnimation.Fade)
        }
        
    }
    
    func initSectionList() {
        var soldSection : HomeComponent = HomeComponent(componentType: HomeComponent.kComponentType.homeSection, sectionName: "SOLDES")
        var collectionSection : HomeComponent = HomeComponent(componentType: HomeComponent.kComponentType.homeSection, sectionName: "COLLECTION")
        var lookBookSection : HomeComponent = HomeComponent(componentType: HomeComponent.kComponentType.homeSection, sectionName: "LOOKBOOK")
        var pictureSection : HomeComponent = HomeComponent(componentType: HomeComponent.kComponentType.homeSection, sectionName: "PICTURE")
        var dailySection : HomeComponent = HomeComponent(componentType: HomeComponent.kComponentType.homeSection, sectionName: "DAILY")
        var campaignSection : HomeComponent = HomeComponent(componentType: HomeComponent.kComponentType.homeSection, sectionName: "CAMPAIGN")
        
        //Sub Section
        var femmeSection : HomeComponent = HomeComponent(componentType: HomeComponent.kComponentType.firstLevelMenu, sectionName: "FEMME")
        
        var trfSection : HomeComponent = HomeComponent(componentType: HomeComponent.kComponentType.firstLevelMenu, sectionName: "TRF")
        
        var hommeSection : HomeComponent = HomeComponent(componentType: HomeComponent.kComponentType.firstLevelMenu, sectionName: "HOMME")
        
        var enfantsSection : HomeComponent = HomeComponent(componentType: HomeComponent.kComponentType.firstLevelMenu, sectionName: "ENFANTS")

        //Second Section
        var femmeSecondMenuList : String[] = ["Manteaux", "Veste", "Robes", "Chemises", "Pantalons", "Jeans", "Jupes", "Maille", "T-shirts", "Chaussures", "Sacs", "Accessoires", "Dernières tailles"]
        var femmeComponentList : HomeComponent[] = HomeComponent[]()
        for menuTitle in femmeSecondMenuList {
            var aFemmeComponent: HomeComponent = HomeComponent(componentType: HomeComponent.kComponentType.secondLevelMenu, sectionName: menuTitle)
            femmeComponentList.append(aFemmeComponent)
        }
        femmeSection.subSection = femmeComponentList
        
        var hommeSecondMenuList : String[] = ["Blousons", "Vestes", "Costumes", "Pantalons", "Jeans", "Bermudas", "Chemises", "T-Shirts", "Sweat-shirts", "Maille", "Chaussures", "Sacs", "Accessoirs", "Maillots de bain", "Dernière tailles"]
        var hommeComponentList : HomeComponent[] = HomeComponent[]()
        for menuTitle in hommeSecondMenuList {
            var aHommeComponent: HomeComponent = HomeComponent(componentType: HomeComponent.kComponentType.secondLevelMenu, sectionName: menuTitle)
            hommeComponentList.append(aHommeComponent)
        }
        hommeSection.subSection = hommeComponentList
        
        var soldSectionList = HomeComponent[]()
        soldSectionList.append(femmeSection)
        soldSectionList.append(trfSection)
        soldSectionList.append(hommeSection)
        soldSectionList.append(enfantsSection)
        soldSection.subSection = soldSectionList
        
        homeSectionList.append(soldSection)
        homeSectionList.append(collectionSection)
        homeSectionList.append(lookBookSection)
        homeSectionList.append(pictureSection)
        homeSectionList.append(dailySection)
        homeSectionList.append(campaignSection)
        
        var collectionFirstMenuList : String[] = ["Femme", "TRF", "Homme", "Fille","Garçon", "Bébé filette", "Bébé garçon", "Mini"]
        var collectionComponentList : HomeComponent[] = HomeComponent[]()
        for menuTitle in collectionFirstMenuList {
            var aCollectionComponent: HomeComponent = HomeComponent(componentType: HomeComponent.kComponentType.firstLevelMenu, sectionName: menuTitle)
            collectionComponentList.append(aCollectionComponent)
        }
        collectionSection.subSection = collectionComponentList
        
        var lookBookFirstMenu : String[] = ["Play", "Woman", "TRF", "Man", "Kids", "Bébé", "Mini"]
        var lookComponentList : HomeComponent[] = HomeComponent[]()
        for menuTitle in lookBookFirstMenu {
            var aLookComponent: HomeComponent = HomeComponent(componentType: HomeComponent.kComponentType.firstLevelMenu, sectionName: menuTitle)
            lookComponentList.append(aLookComponent)
        }
        lookBookSection.subSection = lookComponentList
        
    }
}
