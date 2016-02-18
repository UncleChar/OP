//
//  JHSoapRequest.h
//  JHSoap
//
//  Created by heJevon on 16/1/18.
//  Copyright © 2016年 jevon. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JHSoapRequest : NSObject

/**
 *  HTTP+XML
 *
 *  @param url         请求域
 *  @param requsetBody 请求体（string类型）
 *  @param block       请求成功回调block
 *  @param parseParameters 需要解析的参数
 *  @param errorBlock  请求失败回调block
 
 */
+(void)operationManagerPOST:(NSString *)url requestBody:(NSString *)requestBody parseParameters:(NSArray *)keys WithReturnValeuBlock:(ReturnValueBlock) block
         WithErrorCodeBlock: (ErrorCodeBlock) errorBlock;

@end
