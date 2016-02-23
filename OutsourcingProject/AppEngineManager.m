//
//  AppEngineManager.m
//  UncleCharDemos
//
//  Created by UncleChar on 15/12/25.
//  Copyright © 2015年 hailong.xie. All rights reserved.
//

#import "AppEngineManager.h"

static  AppEngineManager *sharedElement = nil;
@implementation AppEngineManager


+ (instancetype)sharedInstance {
    
    @synchronized(self) {
        
        if (sharedElement == nil) {
            
            sharedElement = [[self alloc]init];
        }
    }
    
    return sharedElement;
}

+(id)allocWithZone:(struct _NSZone *)zone {
    
    @synchronized(self) {
        
        if (sharedElement == nil) {
            
            sharedElement = [super allocWithZone:zone];
            return  sharedElement;
        }
        
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    
    return self;
}

- (instancetype)init {
    
    if (self = [super init]) {

        
        self.dirDocument = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];

        self.dirCache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        
        self.dirTemp  = NSTemporaryDirectory();
        
        self.dirDBSqlite = [self.dirDocument stringByAppendingPathComponent:@"MyAppDataBase.sqlite"];


        OPLog(@"          DocumentPath : %@",self.dirDocument);
//        OPLog(@"          DocumentSize : %ld",[self.dirDocument fileSize]);
        OPLog(@"             CachePath : %@",self.dirCache);
        OPLog(@"              TempPath : %@",self.dirTemp);
    }
    return self;
}


- (void)writeDataToDirectoryWithData:(NSData *)data fileNameForData:(NSString *)fileName underSuperDirecotry:(NSString *)directory {


    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 创建目录
    BOOL res=[fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
    if (res) {
        OPLog(@"目录-%@创建成功",directory);
        [self writeDirWithData:data withFileName:fileName atTargetPath:directory];
    }else{
        OPLog(@"目录-%@-创建失败",directory);
    }
    

}
-(void )writeDirWithData:(NSData *)data withFileName:(NSString *)fileName atTargetPath:(NSString *)path{

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [path stringByAppendingPathComponent:fileName];

    BOOL res=[fileManager createFileAtPath:testDirectory contents:data attributes:nil];
    
    if (res) {
        OPLog(@"%@写入成功:",fileName );
    }else{
        OPLog(@"%@写入失败",fileName);}

}

- (void)createSubDirectoryName:(NSString *)subDirectoryName underSuperDirectory:(NSString *)superDirectory {

     NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *directory = [NSString stringWithFormat:@"%@/%@",superDirectory,subDirectoryName];
    // 创建目录
    BOOL res = [fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
    if (res) {
        OPLog(@"目录-%@创建成功",subDirectoryName);
        self.leftViewElementsPath = directory;
        [[NSUserDefaults standardUserDefaults]setObject:directory forKey:@"avatarPath"];
    }else{
        OPLog(@"目录-%@-创建失败",subDirectoryName);
        self.leftViewElementsPath = nil;
    }
}

+ (void)showTipsWithTitle:(NSString *)title {


    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    

}

//+ (BOOL)isNetworkConecting {
//    
//    if ([[NSUserDefaults standardUserDefaults]boolForKey:kNetworkConnecting]) {
//        
//        return YES;
//        
//    }else {
//        
//        return NO;
//
//    }
//   
//}

//- (void)baseViewControllerPushViewController:(UIViewController *)targetViewController animated:(BOOL)animated {
//
//    [[AppEngineManager sharedInstance].baseViewController.navigationController pushViewController:targetViewController animated:animated];
//
//}

@end
