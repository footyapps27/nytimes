//
//  HomePageViewControllerTests.swift
//  PG_NYTimes
//
//  Created by Samrat on 25/1/17.
//  Copyright © 2017 SMRT. All rights reserved.
//

import XCTest
@testable import PG_NYTimes


class HomePageViewControllerTests: XCTestCase {
    
    
    
    /****************************/
    // MARK: - Properties
    /****************************/
    var viewController: HomePageViewController!
    
    /****************************/
    // MARK: - Setup & Teardown
    /****************************/
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        viewController = navigationController.topViewController as! HomePageViewController
        
        UIApplication.shared.keyWindow!.rootViewController = viewController
        
        // Test and Load the View at the Same Time!
        XCTAssertNotNil(navigationController.view)
        XCTAssertNotNil(viewController.view)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /****************************/
    // MARK: - Tests
    /****************************/
    
    func testStoryBoardConnections() {
        XCTAssertNotNil(viewController.activityIndicator)
        XCTAssertNotNil(viewController.collectionView)
        XCTAssertNotNil(viewController.tableView)
        XCTAssertNotNil(viewController.searchBar)
    }
    
    func testObjectInitializationOnLaunch() {
        XCTAssertNotNil(viewController.manager)
    }
    
    func testIsTableViewHidden() {
        viewController.isTableViewHidden = true
        XCTAssertTrue(viewController.tableView.isHidden)
        XCTAssertFalse(viewController.collectionView.isHidden)
        
        viewController.isTableViewHidden = false
        XCTAssertFalse(viewController.tableView.isHidden)
        XCTAssertTrue(viewController.collectionView.isHidden)
    }
    
    func testPerformSearchForText() {
        XCTAssertEqual("", viewController.searchBar.text)
        viewController.performSearchForText("Manchester United", AndRememberText: true)
        XCTAssertEqual("Manchester United", viewController.searchBar.text)
    }
    
    func testRemoveSearchBarAsFirstResponderAndHideTableView() {
        viewController.searchBar.becomeFirstResponder()
        viewController.tableView.isHidden = false
        
        viewController.removeSearchBarAsFirstResponderAndHideTableView()
        
        XCTAssertFalse(viewController.searchBar.isFirstResponder)
        XCTAssertFalse(viewController.tableView.isHidden)
    }
    
    /****************************/
    // MARK: - Private Methods
    /****************************/
    func getTestData() -> [NewsArticle] {
        
        let headline1 = [Constants.ResponseParameters.GetArticlesHeadlineMain : "Increase in oil prices"]
        
        let headline2 = [Constants.ResponseParameters.GetArticlesHeadlineMain : "Manchester United planning to increase the stadium size to 88000"]
        
        let imageUrl1 = [Constants.ResponseParameters.GetArticlesMultimediaUrl : "nus/api/v1.json"]
        
        let imageUrl2 = [Constants.ResponseParameters.GetArticlesMultimediaUrl : "nus/api/v2.json"]
        
        // Article 1
        var doc1: [String:Any] = [:]
        doc1[Constants.ResponseParameters.GetArticlesId] = "12345678900ae512"
        doc1[Constants.ResponseParameters.GetArticlesSnippet] = "Oil prices are increasing due to the high demand.."
        doc1[Constants.ResponseParameters.GetArticlesWebUrl] = "https://nytimes.com/"
        doc1[Constants.ResponseParameters.GetArticlesHeadline] = headline1
        doc1[Constants.ResponseParameters.GetArticlesMultimedia] = [imageUrl1]
        doc1[Constants.ResponseParameters.GetArticlesPublicationDate] = "2017-01-25T09:51:34+0000"
        let article1 = NewsArticle.init(doc1)
        
        
        // Article 2
        var doc2: [String:Any] = [:]
        doc2[Constants.ResponseParameters.GetArticlesId] = "142091818490te11"
        doc2[Constants.ResponseParameters.GetArticlesSnippet] = "Manchester United have been granted the permission by FA to increase their stadium size from current 75000 to 88000."
        doc2[Constants.ResponseParameters.GetArticlesWebUrl] = "https://nytimes.com/manchester_united"
        doc2[Constants.ResponseParameters.GetArticlesHeadline] = headline2
        doc2[Constants.ResponseParameters.GetArticlesMultimedia] = [imageUrl2]
        doc2[Constants.ResponseParameters.GetArticlesPublicationDate] = "2017-01-25T09:51:34+0000"
        let article2 = NewsArticle.init(doc2)
        
        return [article1!, article2!]
    }
    
    func getTestFilteredData() -> [NewsArticle] {
        let headline1 = [Constants.ResponseParameters.GetArticlesHeadlineMain : "Obama serves his last day at office."]
        
        let imageUrl1 = [Constants.ResponseParameters.GetArticlesMultimediaUrl : "nus/api/v1.json"]
        
        // Article 1
        var doc1: [String:Any] = [:]
        doc1[Constants.ResponseParameters.GetArticlesId] = "14612678900ae512"
        doc1[Constants.ResponseParameters.GetArticlesSnippet] = "President Obama is servign his last day at office. Lets have a look.."
        doc1[Constants.ResponseParameters.GetArticlesWebUrl] = "https://nytimes.com/"
        doc1[Constants.ResponseParameters.GetArticlesHeadline] = headline1
        doc1[Constants.ResponseParameters.GetArticlesMultimedia] = [imageUrl1]
        doc1[Constants.ResponseParameters.GetArticlesPublicationDate] = "2017-01-27T09:51:34+0000"
        let article1 = NewsArticle.init(doc1)
        
        return [article1!]
    }
}
