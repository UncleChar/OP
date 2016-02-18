//
//  JHXMLParser.h
//  JHSoap
//
//  Created by heJevon on 16/1/18.
//  Copyright © 2016年 jevon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHXMLParser : NSObject<NSXMLParserDelegate>

//解析出得数据，内部是字典类型
@property (strong,nonatomic) NSMutableArray *resultArray;

// 当前标签的名字 ,currentTagName 用于存储正在解析的元素名
@property (strong ,nonatomic) NSString * currentTagName ;

//开始解析
-(void)startParse:(NSData *)data parseParameters:(NSArray *)keys;

//需要解析的key
@property (strong,nonatomic) NSArray *parseKeys;


//用于解析完成回调的block
@property (nonatomic,weak) ReturnValueBlock returnBlock;


@property (nonatomic,strong) NSMutableString  *currentText;


/**
 *  根据请求参数封装XML
 *
 *  @param keyAndValues 请求参数（如无参数提交null）
 *  @param host         主机名
 *  @param elementKey   请求Method
 *
 *  @return XMLString
 */
//+(NSString *)generateXMLString:(NSDictionary *)keyAndValues hostName:(NSString *)host startElementKey:(NSString *)elementKey;

/**
 *  根据请求参数封装XML
 *
 *  @param keyAndValues  请求参数（如无参数提交null）
 *  @param host          主机名
 *  @param elementKey    请求Method
 *  @param hasxmlInfo    是否含有xmlInfo
 *  @param resourcesInfo resourcesInfo信息（字典）
 *  @param fileNames     NSArray
 *  @param fileExtNames  NSArray
 *  @param fileDescs     NSArray
 *  @param fileDatas     NSArray
 *
 *  @return XMLString
 */
+(NSString *)generateXMLString:(NSDictionary *)keyAndValues hostName:(NSString *)host startElementKey:(NSString *)elementKey xmlInfo:(BOOL)hasxmlInfo resouresInfo:(NSDictionary *)resourcesInfo fileNames:(NSArray *)fileNames fileExtNames:(NSArray *)fileExtNames fileDesc:(NSArray *)fileDescs fileData:(NSArray *)fileDatas;
@end
