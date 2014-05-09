//
//  ViewController.m
//  UIDrawerViewDemo
//
//  Created by 杨锐 on 13-3-31.
//  Copyright (c) 2013年 yangrui. All rights reserved.
//

#import "ViewController.h"
#define CENTER 160.0

@interface ViewController ()
{
    BOOL isAppear;
    CGPoint startPoint;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
   	[self configDrawerView];
    [self configListView];
}

- (void)configDrawerView
{
    self.navBar.topItem.title = @"新鲜事";
    self.navBar.tintColor = [UIColor colorWithRed:24/255.0 green:116/255.0 blue:205/255.0 alpha:1.0];//24 116 205
    self.list = @[@"新鲜事",@"消息",@"聊天",@"好友",@"找人",@"附近",@"公共主页",@"热门分享"];
   
    self.drawerView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.drawerView.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    self.drawerView.layer.shadowOpacity = 1.0;
    self.drawerView.layer.shadowRadius = 15.0;
    self.drawerView.backgroundColor = [UIColor whiteColor];
  
}
- (void)configListView
{
    self.listView.backgroundColor = [UIColor colorWithRed:110/255.0 green:123/255.0 blue:139/255.0 alpha:1.0];
    self.listView.separatorColor = [UIColor grayColor];
}

- (IBAction)buttonCLicked:(id)sender
{
    if (isAppear)
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            [self.drawerView setFrame:CGRectMake(200, 0, 320, 460)];
        }];
        isAppear = NO;
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            [self.drawerView setFrame:CGRectMake(0, 0, 320, 460)];
        }];
        isAppear = YES;
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    startPoint = [touch locationInView:self.drawerView];
    NSLog(@"start x = %f",startPoint.x);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.drawerView];
    CGFloat dx = point.x - startPoint.x;
  
    CGPoint currentCenter = CGPointMake(self.drawerView.center.x+dx,self.drawerView.center.y);
    if (currentCenter.x > CENTER)
    {
        [self.drawerView setCenter:currentCenter]; 
    }
    
    NSLog(@"center x = %f",currentCenter.x);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.tapCount !=0)
    {
        return;
    }
    else
    {
        if (isAppear)
        {
            [UIView animateWithDuration:0.5 animations:^{
                
                [self.drawerView setFrame:CGRectMake(200, 0, 320, 460)];
            }];
            isAppear = NO;
        }
        else
        {
            [UIView animateWithDuration:0.5 animations:^{
                
                [self.drawerView setFrame:CGRectMake(0, 0, 320, 460)];
            }];
            isAppear = YES;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark- UITableView delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    UIView *selectedView = [[UIView alloc] init];
    selectedView.backgroundColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0];
    cell.selectedBackgroundView = selectedView;
    [selectedView release];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = [NSString stringWithFormat:@"• %@",[self.list objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.navBar.topItem.title = [self.list objectAtIndex:indexPath.row];
    [UIView animateWithDuration:0.5 animations:^{
        
        [self.drawerView setFrame:CGRectMake(320, 0, 320, 460)];
        [self performSelector:@selector(drawerViewAppear) withObject:nil afterDelay:0.5];
    }];
}

- (void)drawerViewAppear
{
    [UIView animateWithDuration:0.5 animations:^{
    [self.drawerView setFrame:CGRectMake(0, 0, 320, 460)];
    }];
    isAppear = YES;
}
@end
