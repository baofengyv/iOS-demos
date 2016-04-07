//
//  User.swift
//  Autolayout
//
//  Created by CS193p Instructor.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

//import Foundation

struct User
{
    let name: String
    let company: String
    let login: String
    let password: String
    
    // 这个叫Type Methods , 这个方法是属于struct 这个 type的而不是属于实例的
    static func login(login: String, password: String) -> User? {
        if let user = database[login] {
            if user.password == password {
                return user
            }
        }
        return nil
    }
    
    // 定义一个属于User的属性 用闭包来初始化
    static let database: Dictionary<String, User> = {
        var theDatabase = Dictionary<String, User>()
        for user in [
            User(name: "b", company: "Apple", login: "b", password: "a"),
            User(name: "Madison Bumgarner", company: "World Champion San Francisco Giants", login: "a", password: "a"),
            User(name: "John Hennessy", company: "Stanford", login: "c", password: "a"),
            User(name: "Bad Guy", company: "Criminals, Inc.", login: "d", password: "a")
            ] {
                theDatabase[user.login] = user
        }
        return theDatabase
    }()
}
