//
//  JHSoapRequest.m
//  JHSoap
//
//  Created by heJevon on 16/1/18.
//  Copyright © 2016年 jevon. All rights reserved.
//

#import "JHSoapRequest.h"
#import "JHXMLParser.h"
@implementation JHSoapRequest

+(void)operationManagerPOST:(NSString *)url requestBody:(NSString *)requestBody parseParameters:(NSMutableArray *)keys WithReturnValeuBlock:(ReturnValueBlock) block
         WithErrorCodeBlock: (ErrorCodeBlock) errorBlock
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [requestBody dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //构建session
    NSURLSession *session = [NSURLSession sharedSession];
    //创建task
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
            errorBlock(error);
        }else{
//            NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            
            
            //开始解析
            JHXMLParser *parse = [[JHXMLParser alloc] init];
            parse.returnBlock = block;
            [parse startParse:data parseParameters:keys];
            
            
        }
    }];
    
    [task resume];

}


@end
