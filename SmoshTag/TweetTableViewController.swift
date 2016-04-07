//
//  TweetTableViewController.swift
//  SmoshTag
//
//  Created by b on 16/3/28.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

import UIKit

class TweetTableViewController: UITableViewController,UITextFieldDelegate {
//MARK: 搜索框
    // 搜索框文本 默认值"#stanford"
    //    初始化时 设置成默认值 但不会执行 didSet
    var searchText: String! = "#stanford" {
        didSet {
            lastSuccessfulRequest = nil
            // 设置搜索框
            searchTextFiled?.text = searchText
            
            // 清空当前的tableView
            tweets.removeAll()
            tableView.reloadData()
            
            // 刷新 table
            refreshGO()
        }
    }
    // 搜索文本输入框   在viewDidLoad之前outlet会被设置 设置时调用其didSet
    @IBOutlet weak var searchTextFiled: UITextField!{
        didSet{
            // delegate 指向自己
            searchTextFiled.delegate = self
            // 填充上默认文本
            searchTextFiled.text = searchText
        }
    }


    // MARK: -View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //行高适应内容
        //   估计高度 ＝ 当前的 估计行高  :这个好像没啥用
        tableView.estimatedRowHeight = tableView.rowHeight
        //   实际行高 ＝ 计算值
        tableView.rowHeight = UITableViewAutomaticDimension

        // 刷新UI
        refreshGO()
    }

    func refreshGO() {
        assert(refreshControl != nil,"我靠！refreshControl")
        refresh(refreshControl!)
    }
    // 下拉刷新
    @IBAction func refresh(refreshC: UIRefreshControl) {
        
        //开始转圈
        refreshC.beginRefreshing()
        
        assert(searchText != nil,"我靠！searchText")
        let request = nextRequestToAttemp // 获取用来请求的request
        
        //使用了trailing closure
        // !! 这是个异步调用API
        // MARK: @todo 研究下这个异步调用怎么写的
        request.fetchTweets { (newTweets: [Tweet]) -> Void in
            //回到主线程进行更新UI
            dispatch_async(dispatch_get_main_queue()){
                if newTweets.count > 0 {
                    // 保存最后一次成功的请求
                    self.lastSuccessfulRequest = request
                    // 替换为最新的tweets数据
                    self.tweets.insert(newTweets, atIndex: 0)
                    
                    // 重新加载数据
                    self.tableView.reloadData()
                    refreshC.endRefreshing() // 停止转圈
                }
            }
        }
    }

    private var lastSuccessfulRequest: TwitterRequest?
    // 如果上次成功过 返回上次的请求
    // 如果上次没成功 返回一个新建的Request
    private var nextRequestToAttemp: TwitterRequest {
        if lastSuccessfulRequest == nil {
            return TwitterRequest(search: searchText!, count: 10)
        } else {
            return lastSuccessfulRequest!.requestForNewer!
        }
    }
    
    
    // 点击回车按钮
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // 如果触发的textField是searchTextFiled
        // 因为这个 controlor 可能有很多textFiled
        if  textField == searchTextFiled{
            // resignFirstResponder 后键盘就隐藏了
            textField.resignFirstResponder() // resign:辞职
            searchText = textField.text
        }
        return true
    }
    
    // MARK: - UITableViewDataSource
    // 二维数组，类型:Tweet
    var tweets = [[Tweet]]()
    
    // 共多少个section 二维数组的第一层结构
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tweets.count
    }
    // 二维数组的第二层结构每个section中有多少row
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets[section].count
    }

    private struct Storyboard {
        static let CellReuseIdentifier = "Tweet"
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 从队列中取cell
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! TweetTableViewCell

        // Configure the cell...
//        let tweet = tweets[indexPath.section][indexPath.row]
//        cell.textLabel?.text = tweet.text
//        cell.detailTextLabel?.text = tweet.user.name

        cell.tweet = tweets[indexPath.section][indexPath.row]
        return cell
    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
