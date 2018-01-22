//
//  StoryboardAssembly.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/11/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import ViperKit

class StoryboardAssembly: BaseCoreAssembly {
    var splashStoryboard: UIStoryboard {
        return resolve(tag: "splash")
    }
    
    var signinStoryboard: UIStoryboard {
        return resolve(tag: "signin")
    }
    
    var mainStoryboard: UIStoryboard {
        return resolve(tag: "main")
    }
    
    var postsStoryboard: UIStoryboard {
        return resolve(tag: "posts")
    }
    
    var postStoryboard: UIStoryboard {
        return resolve(tag: "post")
    }
    
    var createPostStoryboard: UIStoryboard {
        return resolve(tag: "createPost")
    }
    
    var searchStoryboard: UIStoryboard {
        return resolve(tag: "search")
    }
    
    var segmentControlTestStoryboard: UIStoryboard {
        return resolve(tag: "segmentControlTest")
    }
    
    var firstStoryboard: UIStoryboard {
        return resolve(tag: "first")
    }
    
    var secondStoryboard: UIStoryboard {
        return resolve(tag: "second")
    }
    
    init(withRoot root: RootCoreAssembly, system: SystemAssembly) {
        super.init(withRoot: root)
        
        container.register(.singleton, tag: "splash") { UIStoryboard(name: "Splash", bundle: system.bundle) }
        container.register(.singleton, tag: "signin") { UIStoryboard(name: "Signin", bundle: system.bundle) }
        container.register(.singleton, tag: "main") { UIStoryboard(name: "Main", bundle: system.bundle) }
        container.register(.singleton, tag: "posts") { UIStoryboard(name: "Posts", bundle: system.bundle) }
        container.register(.singleton, tag: "post") { UIStoryboard(name: "Post", bundle: system.bundle) }
        container.register(.singleton, tag: "createPost") { UIStoryboard(name: "CreatePost", bundle: system.bundle) }
        container.register(.singleton, tag: "search") { UIStoryboard(name: "Search", bundle: system.bundle) }
        container.register(.singleton, tag: "segmentControlTest") { UIStoryboard(name: "SegmentControlTest", bundle: system.bundle) }
        container.register(.singleton, tag: "first") { UIStoryboard(name: "First", bundle: system.bundle) }
        container.register(.singleton, tag: "second") { UIStoryboard(name: "Second", bundle: system.bundle) }
        
        bootstrap()
    }
}
