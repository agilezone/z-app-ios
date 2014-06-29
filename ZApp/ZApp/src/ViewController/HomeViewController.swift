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
            break
        case .firstLevelMenu:
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "firstLevelMenuCell")
            } else {
                cell = tableView.dequeueReusableCellWithIdentifier("firstLevelMenuCell") as? UITableViewCell
            }
            cell!.text = homeSection.sectionName
            break
        case .secondLevelMenu:
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "secondLevelMenuCell")
            } else {
                cell = tableView.dequeueReusableCellWithIdentifier("secondLevelMenuCell") as? UITableViewCell
            }
            cell!.text = homeSection.sectionName
            break
        default:
            break
        }

        
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
        var homeSection = self.homeSectionList[indexPath.row]
        
        switch homeSection.componentType! {
        case .homeSection:
            print("is I")
        case .firstLevelMenu:
            
            
            for subSection in homeSection.subSection! {
                var i = indexPath.row + 1
                homeSectionList.insert(subSection, atIndex: i)
                i++
                var tableCell : UITableViewCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0))
            }
            break;
        default:
            break;
        }
        self.homeTable!.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Fade)
        
        //self.homeTable!.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    func initSectionList() {
        var soldSection : HomeComponent = HomeComponent(componentType: HomeComponent.kComponentType.homeSection, sectionName: "SOLDES")
        
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
        
        homeSectionList.append(soldSection)
        homeSectionList.append(femmeSection)
        homeSectionList.append(trfSection)
        homeSectionList.append(hommeSection)
        homeSectionList.append(enfantsSection)
        
    }
}
