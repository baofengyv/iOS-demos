//
//  DemoURL.swift
//
//  Created by CS193p Instructor.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import Foundation

// Model 
// 一些图片URL
struct DemoURL {
   
    static let Stanford = NSURL(string: "http://comm.stanford.edu/wp-content/uploads/2013/01/stanford-campus.png")
   
    struct NASA {
        static let Cassini = NSURL(string: "http://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg")
        static let Earth = NSURL(string: "http://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg")
        static let Saturn = NSURL(string: "http://www.nasa.gov/sites/default/files/saturn_collage.jpg")
    }
    
    struct Baidu {
        static let Img1 = NSURL(string: "https://ss3.bdstatic.com/lPoZeXSm1A5BphGlnYG/skin/1.jpg")
        static let Img2 = NSURL(string: "https://ss3.bdstatic.com/lPoZeXSm1A5BphGlnYG/skin/2.jpg")
        static let Img3 = NSURL(string: "https://ss3.bdstatic.com/lPoZeXSm1A5BphGlnYG/skin/3.jpg")
    }
}
