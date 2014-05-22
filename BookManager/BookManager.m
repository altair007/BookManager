//
//  BookManager.m
//  BookManager
//
//  Created by   颜风 on 14-5-21.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "BookManager.h"
#import "BookList.h"
#import "Book.h"

@implementation BookManager

#pragma mark - 便利构造器
+ (instancetype) managerWithName: (NSString *) name
{
    BookManager * manager;
    manager = [[[[self class] alloc] initWithName: name] autorelease];
    
    return manager;
}

#pragma mark - 便利初始化
- (instancetype) initWithName: (NSString *) name
{
    if (self = [super init])
    {
        self.name = name;
        self.primaryBookList = [BookList listWithName:@"所有书籍"];
        self.bookLists = [NSMutableDictionary dictionaryWithCapacity:42];
    }
    
    return self;
}

#pragma mark - 实例方法
- (BOOL) addBookList: (BookList *) aBookList
{
    // 要添加的书单,刚好是主书单吗?
    if (aBookList == self.primaryBookList)
    {
        return NO;
    }
    
    // 书单名为空吗?
    if (nil == aBookList.name)
    {
        return NO;
    }

    // 书单名重复吗?
    __block BOOL isExist = NO;
    
    [self.bookLists enumerateKeysAndObjectsUsingBlock:^(NSString * key, id obj, BOOL *stop)
    {
        if ([key isEqualToString:aBookList.name])
        {
            isExist = YES;
            * stop = YES;
        }
    }];
    
    // 书单名重复,直接返回
    if (isExist)
    {
        return NO;
    }
    
    // 添加书单:以书单名为键,以书单对象本身作值.
    [self.bookLists setObject:aBookList forKey:aBookList.name];
    
    // 把书单中的书添加到主书单.
    [aBookList.books enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        [self.primaryBookList addBook:obj];
    }];
    
    return YES;
}

- (BOOL) removeBookList: (NSString *) aBookListName
{
    // 此书单真的存在吗?
    BookList * aBookList = [self.bookLists objectForKey:aBookListName];
    if (nil == aBookList)
    {
        return NO;
    }
    
    // 删除书单中的所有图书.
    [aBookList removeAllBooks];
    
    // 删除书单.
    [self.bookLists removeObjectForKey:aBookList.name];
    
    return YES;
}

- (void) showBooksOfBookList: (NSString *) aBookListName
{
    BookList * aBookList = [self.bookLists objectForKey:aBookListName];
    
    [aBookList.books enumerateObjectsUsingBlock:^(Book * obj, NSUInteger idx, BOOL *stop)
    {
        [obj show];
    }];
}

- (BOOL) addBook: (Book *) aBook
      ToBookList: (NSString *) aBookListName
{
    BookList * aBookList = [self.bookLists objectForKey:aBookListName];
    // 此书单是否存在?
    if (nil == aBookList)
    {
        return NO;
    }
    
    // 添加图书到指定书单
    // 因为,主书单是可以存在要添加的书籍的.所以仅以是否成功添加到指定书单作为是否添加成功的依据.
    BOOL result;
    result = [aBookList addBook:aBook];
    
    // 添加图书到主书单
    if (result)
    {
        [self.primaryBookList addBook:aBook];
    }
    
    return result;
}

- (void) removeBookByName: (NSString *) aBookName
{
    // 图书名为空,直接返回.
    if (nil == aBookName)
    {
        return;
    }
    
    // 在所有副书单中删除这本书
    [self.bookLists enumerateKeysAndObjectsUsingBlock:^(id key, BookList * list, BOOL *stop)
    {
        [list.books enumerateObjectsUsingBlock:^(Book * book, NSUInteger idx, BOOL *stop)
        {
            if ([book.name isEqualToString: aBookName])
            {
                [list removeBook:book];
                * stop = YES;
            }
        }];
    }];
    
    // 删除主书单中的这本书
    [self.primaryBookList.books enumerateObjectsUsingBlock:^(Book * book, NSUInteger idx, BOOL *stop)
     {
         if ([book.name isEqualToString: aBookName])
         {
             [self.primaryBookList removeBook:book];
             * stop = YES;
         }
     }];
    
}

- (void)dealloc
{
    self.name = nil;
    self.primaryBookList = nil;
    self.bookLists = nil;
    
    [super dealloc];
}

@end
