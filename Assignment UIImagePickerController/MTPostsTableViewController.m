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
    post1.content = @"Lorem ipsum dolor sit amet, conse adipiscing elit. Duis mollis erat ut nunc ultrices dictum. Sed mauris qui augue scelerisque pharetra. Nullam arcu ante, aliquam luctus.";
    post1.timeStamp = [NSDate date];
    
    MTPost *post2 = [[MTPost alloc] init];
    post2.userName = @"Mike Tirenin";
    post2.title = @"Title of Second Post";
    post2.content = @"Lorem ipsum elit. Fusce vitae digni ossim nisi, nec fermentum nunc. Nunc a hendrerit magna. Suspen dis se dui neque, posuere ut porta phar tra, varius ac urna. :)";
    post2.timeStamp = [NSDate date];
    
    MTPost *post3 = [[MTPost alloc] init];
    post3.userName = @"Mike Tirenin";
    post3.title = @"Title of Third Post";
    post3.content = @"Lorem ipsum dolor sit amet, adip soit elit. Proin vitae rhoncus mase. Int tu aliquet nec ligula id euismod. Viva mus nisl massa, luctus at urna vitae corfus.";
    post3.timeStamp = [NSDate date];
    
    MTPost *post4 = [[MTPost alloc] init];
    post4.userName = @"Mike Tirenin";
    post4.title = @"Title of Fourth Post";
    post4.content = @"Lorem ipsum dolor sit amet, con sec tetur adipiscing elit. Donec ligula quam, pharetra id fringilla non, elementum in augue. In non mi vel quam facilisis. Ha, ha!";
    post4.timeStamp = [NSDate date];
    
    MTPost *post5 = [[MTPost alloc] init];
    post5.userName = @"Mike Tirenin";
    post5.title = @"Title of Fifth Post";
    post5.content = @"Lorem ipsum dolor velit vitae luct us. Proin elit. Vivamus et sem mase. Fusce non sodales dolor. Sed elemen tum gravida sem, ac blandit massa bibendum.";
    post5.timeStamp = [NSDate date];
    
    MTPost *post6 = [[MTPost alloc] init];
    post6.userName = @"Mike Tirenin";
    post6.title = @"Title of Sixth Post";
    post6.content = @"orem ipsum dolor sit amet, consect et ur adipiscing elit. Fusce sed sagittis orci. Morbi congue sodales eleifend. Lorem ipsum dolor sit amet, con sec tetur adipiscing elit.";
    post6.timeStamp = [NSDate date];
    
    MTPost *post7 = [[MTPost alloc] init];
    post7.userName = @"Mike Tirenin";
    post7.title = @"Title of Seventh Post";
    post7.content = @"Lorem ipsum dolor sit amet, tu sec consectetur adipiscing elit. Duis fermentum pulvinar velit, ut ele ifend orci vehicula vitae. Sed molert mollis tortor. Later.";
    post7.timeStamp = [NSDate date];
    
    MTPost *post8 = [[MTPost alloc] init];
    post8.userName = @"Mike Tirenin";
    post8.title = @"Title of Eighth Post";
    post8.content = @"Lorem ipsum dolor sit amet, aliqu am viverra mattis velit vitae luctus. Proin.consectetur adipiscing elit. Nulla tincidunt tincidunt nisl, nec lacinia dolor eleifend id. Etiam ernt.";
    post8.timeStamp = [NSDate date];
    
    MTPost *post9 = [[MTPost alloc] init];
    post9.userName = @"Mike Tirenin";
    post9.title = @"Title of Ninth Post";
    post9.content = @"Lorem ipsum dolor sit amet, consect etur adipiscing elit. Nullam in leo tortor. Interdum et malesuada fam ac ante ipsum primis in faucibus. Duis cursus. #lovingreekedtext";
    post9.timeStamp = [NSDate date];
    
    MTPost *post10 = [[MTPost alloc] init];
    post10.userName = @"Mike Tirenin";
    post10.title = @"Title of Tenth Post";
    post10.content = @"Lorem ipsum dolor sit amet, piscin tu elit. Aliquam sagittis quam sapie, ut vehicula augue euismod vel. Phat metus dui, iaculis eu cursus sit amet elementum vitae.";
    post10.timeStamp = [NSDate date];
    
    _posts = [NSMutableArray arrayWithObjects:post1, post2, post3, post4, post5, post6, post7, post8, post9, post10, nil];

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
    
    MTPost *post = [self.posts objectAtIndex:indexPath.row];
    [postCell setPost:post];

    // random color implemented
    int i = 0;
    while (i < 10) {
        postCell.contentView.backgroundColor = [UIColor randomColor];
        i++;
    }

    return postCell;
}

//// ligthen color example
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
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = cell.contentView.backgroundColor;
}

@end
