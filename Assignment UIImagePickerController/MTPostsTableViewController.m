//
//  MTPostsTableViewController.m
//  Assignment UIImagePickerController
//
//  Created by Michael Tirenin on 5/18/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

#import "MTPostsTableViewController.h"
#import "MTPostTableViewCell.h"
#import "MTPost.h"
#import "MTCreatePostViewController.h"
#import "MTEditPostViewController.h"
#import "UIColor+Manage.h"

@interface MTPostsTableViewController () <UITableViewDataSource, UITableViewDelegate, MTCreatePostViewControllerDelegate, MTEditPostViewControllerDelegate>

@end

@implementation MTPostsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _posts = [[NSMutableArray alloc] init];

    MTPost *post1 = [[MTPost alloc] init];
    post1.userName = @"Mike Tirenin";
    post1.title = @"Title of First Post";
    post1.content = @"Lorem ipsum dolor sit amet, conse adipiscing elit. Duis mollis erat ut nunc ultrices.";
    post1.timeStamp = [NSDate date];
    post1.picture = [UIImage imageNamed:@"dougherty1.png"];
    
    MTPost *post2 = [[MTPost alloc] init];
    post2.userName = @"Mike Tirenin";
    post2.title = @"Title of Second Post";
    post2.content = @"Lorem ipsum elit. Fusce vitae digni ossim nisi, nec fermen tum ... Tunc a hendrerit. :)";
    post2.timeStamp = [NSDate date];
    post2.picture = [UIImage imageNamed:@"dougherty2.png"];
    
    MTPost *post3 = [[MTPost alloc] init];
    post3.userName = @"Mike Tirenin";
    post3.title = @"Title of Third Post";
    post3.content = @"Lorem ipsum dolor sit amet, adip soit elit. Ligula id euis mod.";
    post3.timeStamp = [NSDate date];
    post3.picture = [UIImage imageNamed:@"dougherty3.png"];

    MTPost *post4 = [[MTPost alloc] init];
    post4.userName = @"Mike Tirenin";
    post4.title = @"Title of Fourth Post";
    post4.content = @"Lorem ipsum dolor sit amet, con sec tetur adipiscing elit. Donec ligula quam. Ha, ha!";
    post4.timeStamp = [NSDate date];
    post4.picture = [UIImage imageNamed:@"dougherty4.png"];
    
    MTPost *post5 = [[MTPost alloc] init];
    post5.userName = @"Mike Tirenin";
    post5.title = @"Title of Fifth Post";
    post5.content = @"Lorem ipsum dolor velit vitae luct us.";
    post5.timeStamp = [NSDate date];
    post5.picture = [UIImage imageNamed:@"dougherty5.png"];
    
    MTPost *post6 = [[MTPost alloc] init];
    post6.userName = @"Mike Tirenin";
    post6.title = @"Title of Sixth Post";
    post6.content = @"Lorem ipsum dolor sit amet, consect et ur adipiscing elit. Fusce sed sagittis orci. Morbi congue sodales eleifend.";
    post6.timeStamp = [NSDate date];
    post6.picture = [UIImage imageNamed:@"dougherty6.png"];
    
    MTPost *post7 = [[MTPost alloc] init];
    post7.userName = @"Mike Tirenin";
    post7.title = @"Title of Seventh Post";
    post7.content = @"Lorem ipsum dolor sit amet, tu sec consectetur adipiscing elit. Later.";
    post7.timeStamp = [NSDate date];
    post7.picture = [UIImage imageNamed:@"dougherty7.png"];
    
    MTPost *post8 = [[MTPost alloc] init];
    post8.userName = @"Mike Tirenin";
    post8.title = @"Title of Eighth Post";
    post8.content = @"Lorem ipsum dolor sit amet ... etiam ernt?";
    post8.timeStamp = [NSDate date];
    post8.picture = [UIImage imageNamed:@"dougherty8.png"];
    
    MTPost *post9 = [[MTPost alloc] init];
    post9.userName = @"Mike Tirenin";
    post9.title = @"Title of Ninth Post";
    post9.content = @"Lorem ipsum dolor sit amet, consect etur adipiscing elit. Duis cursus. #lovingreekedtext";
    post9.timeStamp = [NSDate date];
    post9.picture = [UIImage imageNamed:@"dougherty9.png"];
    
    MTPost *post10 = [[MTPost alloc] init];
    post10.userName = @"Mike Tirenin";
    post10.title = @"Title of Tenth Post";
    post10.content = @"Lorem ipsum dolor sit amet. Cursus sit amet elementum vitae!!!";
    post10.timeStamp = [NSDate date];
    post10.picture = [UIImage imageNamed:@"dougherty10.png"];
    
    _posts = [NSMutableArray arrayWithObjects:post1, post2, post3, post4, post5, post6, post7, post8, post9, post10, nil];
    
//    _posts = [NSMutableArray arrayWithObjects:post1, nil];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTPostTableViewCell *postCell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    
//    if (postCell == nil) {
//        postCell = [[MTPostTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PostCell"];
//        postCell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
    
    MTPost *post = [self.posts objectAtIndex:indexPath.row];
    [postCell setPost:post];

    // random color implemented
    int i = 0;
    while (i <= self.posts.count) {
        postCell.contentView.backgroundColor = [UIColor randomColor];
        i++;
    }
    
    return postCell;
}

//// ligthen color example - KEEP THIS EXAMPLE
//    UIColor *someColor = [UIColor colorWithHue:0.5 saturation:0.5 brightness:0.5 alpha:1.0];
//    NSLog(@"%@", someColor);
//    postCell.contentView.backgroundColor = [UIColor lightenColor:someColor byAmount:1.5];
//    //postCell.contentView.backgroundColor = someColor;
//    return postCell;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_posts removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"PublishSegue"]) {
        MTCreatePostViewController *createPostVC = segue.destinationViewController;
        createPostVC.createPostDelegate = self;
        
    }
    if ([segue.identifier isEqualToString:@"EditSegue"]) {
        MTEditPostViewController *editPostVC = segue.destinationViewController;
        editPostVC.editPostDelegate = self;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        MTPost *post = [self.posts objectAtIndex:indexPath.row];
        editPostVC.post = post;
    }
}

- (void)addObject:(MTPost *)post
{
    [_posts addObject:post];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)updateTable
{
    [self.tableView reloadData];
}

// to add background color to disclosure access. in cells
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = cell.contentView.backgroundColor;
}

@end
