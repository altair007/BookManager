//
//  BookList.m
//  BookManager
//
//  Created by   颜风 on 14-5-21.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "BookList.h"
#import "Book.h"

@implementation BookList

#pragma mark - 便利构造器
+ (instancetype) listWithName: (NSString *) name
{
    BookList * bookList;
    bookList = [[[[self class] alloc]initWithName: name]autorelease];
    
    return bookList;
}


#pragma mark - 便利初始化
- (instancetype) initWithName: (NSString *) name
{
    if (self = [super init])
    {
        self.name = name;
        self.books = [NSMutableArray arrayWithCapacity:42];
    }
    
    return self;
}

#pragma make - 方法
- (BOOL) addBook: (Book *) aBook
{
    // 图书名或者作者名是否为空?
    if (nil == aBook.name || nil == aBook.author)
    {
        return NO;
    }
    
    // 图书是否已经存在?
    __block BOOL isExist = NO;
    
    [self.books enumerateObjectsUsingBlock:^(Book * obj, NSUInteger idx, BOOL *stop)
    {
        if ([obj.name isEqualToString: aBook.name])
        {
            isExist = YES;
            * stop = YES;
        }
    }];
    
    // 图书已经存在,直接返回NO.
    if (isExist)
    {
        return  NO;
    }
    
    // 添加图书
    [self.books addObject: aBook];
    
    // 更改图书的书单信息
    [aBook.bookLists addObject:self];
    
    return YES;
}

- (void) removeBook: (Book *) aBook
{
    // 删除图书.
    [self.books removeObject: aBook];
    
    // 更改被删除的图书的书单信息.
    [aBook.bookLists removeObject:self];
}

- (void) removeAllBooks
{
    // 修改书单中图书的书单信息
    [self.books enumerateObjectsUsingBlock:^(Book * obj, NSUInteger idx, BOOL *stop)
    {
        [obj.bookLists removeObject:self];
    }];
    
    // 删除所有图书.
    [self.books removeAllObjects];
}

- (Book *) bookByName: (NSString *) aName
{
    __block Book * book;
    
    [self.books enumerateObjectsUsingBlock:^(Book * obj, NSUInteger idx, BOOL *stop)
     {
         if ([obj.name isEqualToString: aName])
         {
             book = obj;
             * stop = YES;
         }
     }];
    
    return book;
}

-(void)dealloc
{
    self.name = nil;
    self.books = nil;
    
    [super dealloc];
}
@end
