//
//  Book.h
//  BookManager
//
//  Created by   颜风 on 14-5-21.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  图书类
 */
@interface Book : NSObject

#pragma mark - 属性
@property (nonatomic, copy) NSString * name; //!< 书名.
@property (nonatomic, copy) NSString * author; //!< 作者.
@property (nonatomic, assign) float price; //!< 价格.
@property (nonatomic, copy) NSString * press; //!< 出版社.
@property (nonatomic, retain) NSMutableArray * bookLists; //!< 所处的书单.
#pragma mark - 便利构造器
/**
 *  便利构造器,快速创建对象,并进行适当地初始化.
 *
 *  @param name   书名
 *  @param author 作者
 *  @param price  价格
 *  @param press  出版社
 *
 *  @return 新创建的对象.
 */
+ (instancetype) bookWithName: (NSString *) name
                       author: (NSString *) author
                        price: (float) price
                        press: (NSString *) press;

#pragma mark - 便利初始化
/**
 *  便利初始化,快速初始化新创建的对象.
 *
 *  @param name   书名
 *  @param author 作者
 *  @param price  价格
 *  @param press  出版社
 *
 *  @return 初始化后的对象.
 */
- (instancetype) initWithName: (NSString *) name
                       author: (NSString *) author
                        price: (float) price
                        press: (NSString *) press;

#pragma - 实例方法
/**
 *  显示图书信息
 */
- (void) show;

/**
 *  手动释放实例变量的内存.
 */
-(void)dealloc;

@end
