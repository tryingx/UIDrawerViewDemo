//
//  ViewController.h
//  UIDrawerViewDemo
//
//  Created by 杨锐 on 13-3-31.
//  Copyright (c) 2013年 yangrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (retain ,nonatomic) IBOutlet UITableView *listView;
@property (retain ,nonatomic) IBOutlet UIView *drawerView;
@property (retain ,nonatomic) IBOutlet UINavigationBar *navBar;
@property (retain ,nonatomic) NSArray *list;

- (IBAction)buttonCLicked:(id)sender;
@end
