//
//  NSString+JHXMLEntities.m
//  JHSoap
//
//  Created by heJevon on 16/1/21.
//  Copyright © 2016年 jevon. All rights reserved.
//

#import "NSString+JHXMLEntities.h"

@implementation NSString (JHXMLEntities)

-(NSString *)htmlEntityDecode{
    NSString *string = [self mutableCopy];
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@"\n"];

    
    
    
    
    return string;
}


-(NSString *)htmlEntityEncode{
    
    NSString *string = [self mutableCopy];
    string = [string stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
    string = [string stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
//    string = [string stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    string = [string stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
    string = [string stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
    
    
    
    
    return string;

}
@end
