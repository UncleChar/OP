//
//  JHXMLParser.m
//  JHSoap
//
//  Created by heJevon on 16/1/18.
//  Copyright © 2016年 jevon. All rights reserved.
//

#import "JHXMLParser.h"
#import "XMLWriter.h"

#import "NSString+JHXMLEntities.h"
@implementation JHXMLParser
// 开始解析
-(void)startParse:(NSData *)data parseParameters:(NSArray*)keys{
    
    //开始解析 xml
    NSXMLParser * parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self ;
    self.parseKeys = keys;
    [parser parse];
    
    
}
//文档开始时触发 ,开始解析时 只触发一次
-(void)parserDidStartDocument:(NSXMLParser *)parser{
    _resultArray = [NSMutableArray new];
}

// 文档出错时触发
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    OPLog(@"%@",parseError);
}

//遇到一个开始标签触发
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    //把elementName 赋值给 成员变量 currentTagName
    _currentTagName  = elementName ;
    
    self.currentText = [[NSMutableString alloc]init];
    
    for (NSString *keyName in self.parseKeys) {
        //如果名字 是Note就取出 id
        if ([_currentTagName isEqualToString:keyName]) {
            
            // 实例化一个可变的字典对象,用于存放
            NSMutableDictionary *dict = [NSMutableDictionary new];

            [dict setObject:[NSNull null] forKey:keyName];
            
            // 把可变字典 放入到 可变数组集合_resultArray 变量中
            [_resultArray addObject:dict];
            
    
            
        }
    }
    
    
    
    
}
#pragma mark 该方法主要是解析元素文本的主要场所，由于换行符和回车符等特殊字符也会触发该方法，因此要判断并剔除换行符和回车符
// 遇到字符串时 触发
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    //替换回车符 和空格,其中 stringByTrimmingCharactersInSet 是剔除字符的方法,[NSCharacterSet whitespaceAndNewlineCharacterSet]指定字符集为换行符和回车符;
    
    
    [self.currentText appendString:string];
    if ([string isEqualToString:@""]) {
        return;
    }
    
    NSMutableDictionary * dict = [_resultArray lastObject];
    if ([_currentTagName isEqualToString:[[dict allKeys] objectAtIndex:0]] && dict) {
        [dict setObject:self.currentText forKey:[[dict allKeys] objectAtIndex:0]];
    }
    
    
    
}

//遇到结束标签触发
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    self.currentTagName = nil ;
    self.currentText = nil;
    //该方法主要是用来 清理刚刚解析完成的元素产生的影响，以便于不影响接下来解析
}

// 遇到文档结束时触发
-(void)parserDidEndDocument:(NSXMLParser *)parser{

//    OPLog(@"%@",self.resultArray);
    self.returnBlock(self.resultArray);
    //进入该方法就意味着解析完成，需要清理一些成员变量，同时要将数据返回给表示层（表示图控制器）
    self.resultArray = nil;
    
    
}





+(NSString *)generateXMLString:(NSDictionary *)keyAndValues hostName:(NSString *)host startElementKey:(NSString *)elementKey xmlInfo:(BOOL)hasxmlInfo resouresInfo:(NSDictionary *)resourcesInfo fileNames:(NSArray *)fileNames fileExtNames:(NSArray *)fileExtNames fileDesc:(NSArray *)fileDescs fileData:(NSArray *)fileDatas {

    
    XMLWriter *xmlFile = [[XMLWriter alloc] init];
    [xmlFile writeStartDocumentWithEncodingAndVersion:@"gb2312" version:@"1.0"];
    
    
    
    [xmlFile writeStartElement:@"DATA"];
    
    
    [xmlFile writeStartElement:@"ResourceInfo"];
    
    
    for (NSString *keyString in resourcesInfo) {
        [xmlFile writeStartElement:keyString];
        
        if (resourcesInfo[keyString]==[NSNull null]||resourcesInfo[keyString]==nil||[[NSString stringWithFormat:@"%@",resourcesInfo[keyString]] isEqualToString:@" "]) {
            [xmlFile writeCharacters:@""];
        }else
            [xmlFile writeCharacters:[NSString stringWithFormat:@"%@",resourcesInfo[keyString]]];
        
        
        [xmlFile writeEndElement];
        
    }
    
    
    [xmlFile writeEndElement];
    
    
    [xmlFile writeStartElement:@"AttachList"];
    
    [xmlFile writeStartElement:@"Attach"];
    
    
    
    
    
    //-------------Attach
    [xmlFile writeStartElement:@"FileName"];
    
    if (fileNames.count>0) {
        [xmlFile writeCharacters:[fileNames componentsJoinedByString:@","]];
    }
    
    
    [xmlFile writeEndElement];
    
    
    [xmlFile writeStartElement:@"FileExtName"];
    
    if (fileExtNames.count>0) {
        [xmlFile writeCharacters:[fileExtNames componentsJoinedByString:@","]];
    }
    [xmlFile writeEndElement];
    
    
    [xmlFile writeStartElement:@"FileDesc"];
    if (fileDescs.count>0) {
        [xmlFile writeCharacters:[fileDescs componentsJoinedByString:@","]];
    }
    
    [xmlFile writeEndElement];
    
    
    
    [xmlFile writeStartElement:@"FileData"];
    if (fileDatas.count>0) {
        [xmlFile writeCharacters:[fileDatas componentsJoinedByString:@","]];
    }
    
    [xmlFile writeEndElement];
    
    
    
    [xmlFile writeEndElement];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //--------------Attach
    
    
    
    
    
    
    
    
    
    
    
    [xmlFile writeEndElement];
    
    
    
    
    
    
    
    
    
    
    
    [xmlFile writeEndElement];
    
    
    
    
    
    
//    [xmlFile writeEndElement];
    
    
    
    [xmlFile writeEndDocument];
    
    
    NSString *xmlFileString = [xmlFile toString];
//    xmlFileString = [xmlFileString htmlEntityEncode];
    
    
    //----------------------------------------
    XMLWriter *xmlWriter = [[XMLWriter alloc] init];
    
    NSString* xsispaceURI = @"http://www.w3.org/2001/XMLSchema-instance";
    NSString* xsdspaceURI = @"http://www.w3.org/2001/XMLSchema";
    NSString* soap12spaceURI = @"http://www.w3.org/2003/05/soap-envelope";
    
    
    [xmlWriter setPrefix:@"xsi" namespaceURI:xsispaceURI];
    [xmlWriter setPrefix:@"xsd" namespaceURI:xsdspaceURI];
    [xmlWriter setPrefix:@"soap12" namespaceURI:soap12spaceURI];
    
    
    
    [xmlWriter writeStartDocumentWithEncodingAndVersion:@"utf-8" version:@"1.0"];
    [xmlWriter writeStartElementWithNamespace:soap12spaceURI localName:@"Envelope"];
    [xmlWriter writeStartElementWithNamespace:soap12spaceURI localName:@"Body"];
    
    if (elementKey) {
        [xmlWriter writeStartElement:elementKey];
    }
    
    [xmlWriter writeAttribute:@"xmlns" value:host];
    
    for (NSString *keyString in keyAndValues) {
        [xmlWriter writeStartElement:keyString];
        
        if (keyAndValues[keyString]==[NSNull null]||keyAndValues[keyString]==nil||[[NSString stringWithFormat:@"%@",keyAndValues[keyString]] isEqualToString:@" "]) {
            [xmlWriter writeCharacters:@""];
        }else
            [xmlWriter writeCharacters:[NSString stringWithFormat:@"%@",keyAndValues[keyString]]];
        
        [xmlWriter writeEndElement];
        
    }
    
    if (hasxmlInfo) {
        [xmlWriter writeStartElement:@"xmlinfo"];
        
        
        [xmlWriter writeCharacters:xmlFileString];
        
        
        
        
        
        [xmlWriter writeEndElement];
    }
    
    
    
    
    
    [xmlWriter writeEndElement];
    [xmlWriter writeEndElement];
    [xmlWriter writeEndElement];
    [xmlWriter writeEndDocument];
    OPLog(@"99%@", [xmlWriter toString]);
    
    return [xmlWriter toString];

}
@end
