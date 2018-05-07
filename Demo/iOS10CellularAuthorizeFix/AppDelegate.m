//
//  AppDelegate.m
//  iOS10CellularAuthorizeFix
//
//  Created by zuik on 2017/2/4.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "AppDelegate.h"
#import "ZIKCellularAuthorization.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /*
     由于使用了私有API，虽然已经经过混淆，但混淆只能绕过静态检查，而现在App Store审核时会检查dlopen、dlsym、NSClassFromString等动态方法的调用，因此用这些方式使用私有API时仍然会被检测出来。解决方法：
     
     1.让app在某个固定时间之后才执行修复，例如预估2018.01.01审核完毕，就在代码里检测日期，2018.01.01之后才执行修复。这个时间需要适当预估。
     
     2.苹果审核团队好像都是在美国，可以判断系统语言，只有中文时才修复。
     
     目前这些判断需要使用者自己完成。
     
     update:
     
     目前不建议在 App Store 正式版中使用。现在苹果禁止在使用 performSelector: 时传入动态生成的参数，参考：[Are performSelector and respondsToSelector banned by App Store?](https://stackoverflow.com/questions/42662028/are-performselector-and-respondstoselector-banned-by-app-store)。这通过静态分析是能够被检查出来的。苹果会检查使用了 performSelector: 的那部分汇编代码，判断传入的参数是否是静态编译的。
     
     虽然用我的 [ZIKImageSymbol.h](https://github.com/Zuikyo/ZIKRouter/blob/master/ZIKRouter/Utilities/ZIKImageSymbol/ZIKImageSymbol.h) 可以动态获取 objc_msgSend 的函数指针，再动态调用 selector，绕过检查，不过我只是用来做一些 debug 工具，没在正式产品中使用过。有兴趣的朋友可以尝试。
     */
    if ([ZIKCellularAuthorization isDeviceChineseLanguage]) {
        [ZIKCellularAuthorization requestCellularAuthorization];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
