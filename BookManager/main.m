//
//  main.m
//  BookManager
//
//  Created by   颜风 on 14-5-21.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"
#import "BookList.h"
#import "BookManager.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool
    {
        // （1）创建一个图书管理器对象(默认有一个主书单，名字为：所有书籍)
        BookManager * manager = [BookManager managerWithName:@"我的个人书库"];
        
        // （2）创建3个书单，名字分别为：iOS开发、游戏攻略、最爱，添加到图书管理器中，返回成功或失败。
        BookList * list1 = [BookList listWithName:@"IOS开发"];
        BookList * list2 = [BookList listWithName:@"游戏攻略"];
        BookList * list3 = [BookList listWithName:@"最爱"];
        BOOL result;
        result = [manager addBookList:list1];
        result = [manager addBookList:list2];
        result = [manager addBookList:list3];
        
        // （3）添加图书到某个书单，添加的书籍中，有一本图书同时被添加到iOS开发和最爱两个书单中，需要返回结果：成功或者失败
    
        Book * book1 = [Book bookWithName:@"谁动了我的奶酪" author:@"约翰逊" price:20.6 press:@"中信出版社"];
        Book * book2 = [Book bookWithName:@"纯真博物馆" author:@"奥尔罕・帕慕克" price:20.6 press:@"上海人民出版社"];
        Book * book3 = [Book bookWithName:@"iOS 5基础教程" author:@"Dave Mark　Jack Nutting　Jeff LaMarche" price:20.6 press:@"人民邮电出版社"];
        
        result = [manager addBook:book1 ToBookList:@"IOS开发"];
        result = [manager addBook:book2 ToBookList:@"游戏攻略"];
        result = [manager addBook:book3 ToBookList:@"最爱"];
        result = [manager addBook:book3 ToBookList:@"IOS开发"];
        
		//（4）删除图书，根据书籍的名字删除图书，注意：需要将书籍从所有管理它的书单中清除
        [manager removeBookByName:@"iOS 5基础教程"];
        
		//（5）展示某个书单中所有图书信息。
        [manager showBooksOfBookList:@"游戏攻略"];
        
		//（6）删除某个书单。
        result = [manager removeBookList:@"最爱"];
    }
    return 0;
}

