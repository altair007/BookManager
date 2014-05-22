//
//  BookList.h
//  BookManager
//
//  Created by   颜风 on 14-5-21.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Book;

/**
 *  书单类
 */
@interface BookList : NSObject

#pragma mark - 属性
@property (nonatomic, copy) NSString * name; //<! 书单名
@property (nonatomic, retain) NSMutableArray * books; //!< 书籍

#pragma mark - 便利构造器
/**
 *  便利构造器,根据书单名,快速创建书单.
 *
 *  @param name 书单名
 *
 *  @return 新创建的书单对象.
 */
+ (instancetype) listWithName: (NSString *) name;

#pragma mark - 便利初始化
/**
 *  便利初始化,根据书单名,对书单进行适当地初始化设置.
 *
 *  @param name 书单名.
 *
 *  @return 初始化后的对象.
 */
- (instancetype) initWithName: (NSString *) name;

#pragma make - 方法
/**
 *  添加图书,如果图书的名字,作者名为空,添加失败.
 *
 *  添加图书时,要同步更新图书本身的书单信息.
 *
 *  @param aBook 要添加的图书.
 *
 *  @return YES,添加成功;NO,添加失败.
 */
- (BOOL) addBook: (Book *) aBook;

/**
 *  删除图书,同步更新图书的书单信息.
 *
 *  @param aBook 要删除的图书.
 */
- (void) removeBook: (Book *) aBook;

/**
 *  删除书单中的所有图书.
 */
- (void) removeAllBooks;

/**
 *  根据书名获取某本图书.
 *
 *  @param aName 书名.
 *
 *  @return 书名对应的书.
 */
- (Book *) bookByName: (NSString *) aName;

/**
 *  手动销毁实例变量.
 */
-(void)dealloc;
@end
