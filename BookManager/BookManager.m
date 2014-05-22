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
        
        // 把主书单添加到书单数组中.
        [self.bookLists setObject:self.primaryBookList forKey: self.primaryBookList.name];
    }
    
    return self;
}

#pragma mark - 实例方法
- (BOOL) addBookList: (BookList *) aBookList
{
    // 同名书单是否已经存在?
    if (nil != [self.bookLists objectForKey:aBookList.name])
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
    // 不允许删除主书单.
    if ([self.primaryBookList.name isEqualToString: aBookListName])
    {
        return  NO;
    }
    
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
    // 不允许直接添加到主书单中.
    if ([self.primaryBookList.name isEqualToString:aBookListName])
    {
        return NO;
    }
    
    // 获取对应的书单对象.
    BookList * aBookList = [self.bookLists objectForKey:aBookListName];
    
    // 此书单是否存在?
    if (nil == aBookList)
    {
        // 不存在,则添加书单.
        aBookList = [BookList listWithName: aBookListName];
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
    // 通过主书单,看这本书是否存在
    Book * book = [self.primaryBookList bookByName:aBookName];
    
    if (nil == book)
    {
        // 不存在,直接返回.
        return;
    }
    
    // 通过书籍本身的书单名数组属性,找到存储此书的所有书单
    NSMutableArray * lists = [NSMutableArray arrayWithCapacity:42];
    [book.bookListNames enumerateObjectsUsingBlock:^(NSString * lisetName, NSUInteger idx, BOOL *stop)
    {
        BookList * temp = [self.bookLists objectForKey:lisetName];
        if (nil != temp)
        {
            [lists addObject:temp];
        }
    }];
    
    // 从书单中删除此书.
    [lists enumerateObjectsUsingBlock:^(BookList * list, NSUInteger idx, BOOL *stop)
    {
        [list removeBook: book];
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
