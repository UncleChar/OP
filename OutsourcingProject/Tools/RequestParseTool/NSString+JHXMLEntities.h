//
//  NSString+JHXMLEntities.h
//  JHSoap
//
//  Created by heJevon on 16/1/21.
//  Copyright © 2016年 jevon. All rights reserved.
//


#import <Foundation/Foundation.h>
@interface NSString (JHXMLEntities)

/**
 *  HTML转义/ unescape
 *
 *  @param string 含有转义字符的HTMLString
 *
 *  @return 标准标签的HTMLString(Fix：不需要传入该参数)
 */
-(NSString *)htmlEntityDecode;

-(NSString *)htmlEntityEncode;
@end
