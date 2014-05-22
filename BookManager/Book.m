//
//  Book.m
//  BookManager
//
//  Created by   颜风 on 14-5-21.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "Book.h"

@implementation Book
#pragma mark - 便利构造器
+ (instancetype) bookWithName: (NSString *) name
                       author: (NSString *) author
                        price: (float) price
                        press: (NSString *) press
{
    Book * book;
    book = [[[[self class] alloc]initWithName: name author:author price:price press:press] autorelease];
    
    return book;
}

#pragma mark - 便利初始化
- (instancetype) initWithName: (NSString *) name
                       author: (NSString *) author
                        price: (float) price
                        press: (NSString *) press
{
    if (self = [super init])
    {
        self.name = name;
        self.author = author;
        self.price = price;
        self.press = press;
        
        // 对书单属性进行适当地初始化;否则,可能无法正常使用此属性.
        self.bookLists = [NSMutableArray arrayWithCapacity:42];
    }
    
    return self;
}

#pragma - 实例方法

- (void) show
{
    NSString * info;
    info = [NSString stringWithFormat:@"书名: %@ \n作者:%@ \n价格:%g \n出版社:%@", self.name, self.author, self.price, self.press];
    
    NSLog(@"%@", info);
}

-(void)dealloc
{
    self.name = nil;
    self.author = nil;
    self.press = nil;
    [self.bookLists release];
    
    [super dealloc];
}

@end
