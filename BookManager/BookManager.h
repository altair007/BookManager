//
//  BookManager.h
//  BookManager
//
//  Created by   颜风 on 14-5-21.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Book;
@class BookList;

/**
 *  图书管理器类
 */
@interface BookManager : NSObject

#pragma mark - 属性
@property (nonatomic, copy) NSString * name; //!< 名字
@property (nonatomic, retain) BookList * primaryBookList; //!< 主书单
@property (nonatomic, retain) NSMutableDictionary * bookLists; //!< 书单.书单名作键,书单对象做值.

#pragma mark - 便利构造器
/**
 *  根据图书管理器名字,快速创建并初始化图书管理器对象.
 *
 *  @param name 图书管理器的名字.
 *
 *  @return 新创建的图书管理器对象.
 */
+ (instancetype) managerWithName: (NSString *) name;

#pragma mark - 便利初始化
/**
 *  根据图书管理器名字,快速初始化图书管理器对象.
 *
 *  @param name 图书管理器的名字.
 *
 *  @return 初始化后图书管理器的对象.
 */
- (instancetype) initWithName: (NSString *) name;

#pragma mark - 实例方法
/**
 *  添加书单,如果书单名为空,书单名重复或者书单恰好为主书单，则添加失败.
 *
 *  添加书单的同时,也会把书单中的书添加到主书单.
 *
 *  @param aBookList 要添加的书单.
 *
 *  @return YES,添加成功;NO,添加失败.
 */
- (BOOL) addBookList: (BookList *) aBookList;

/**
 *  删除书单,如果要删除的书单不存在，返回失败
 *
 *  默认执行的是先删除书单中的书,再删除书单.因为图书再被删除时可能会做一些额外的工作.
 *
 *  @param aBookListName 要删除的书单的名字.
 *
 *  @return YES,删除成功;NO,删除失败.
 */
- (BOOL) removeBookList: (NSString *) aBookListName;

/**
 *  展示某个书单中所有图书的信息.
 *
 *  @param aBookListName 要展示信息的书单的名字.
 */
- (void) showBooksOfBookList: (NSString *) aBookListName;

/**
 *  添加图书到指定书单.
 *
 *  主书单是管理所有书籍的，书籍被添加到某个书单中时，也要被添加到主书单中
 *
 *  @param aBook     要添加的图书.
 *  @param aBookListName 指定的用于添加的书单的名字.
 *
 *  @return YES,添加成功;NO,添加失败.
 */
- (BOOL) addBook: (Book *) aBook
      ToBookList: (NSString *) aBookListName;
/**
 *  根据书名删除图书.
 *
 *  管理图书的书单可能不止一个，要从所有管理这本书籍的书单中删除
 *
 *  @param aBookName 要删除的图书的名字.
 */
- (void) removeBookByName: (NSString *) aBookName;

/**
 *  释放实例变量
 */
- (void)dealloc;

@end
