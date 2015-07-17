//
//  ChangeSchViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-3-15.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "ChangeSchViewController.h"
#define kTmpSearchBarFrame CGRectMake(0, 20, 320, 44)
#define kOriginSearchBarFrame CGRectMake(0, 64, 320, 44)
#define kTmpTableViewFrame CGRectMake(0, 64, 320, 504)
#define kOriginTableViewFrame CGRectMake(0, 108, 320, 470)
@interface ChangeSchViewController ()

@end

@implementation ChangeSchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - 初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addNavBar];

    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.scrollEnabled = YES;
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, 320, 44)];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 108, 320, 460)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    [self.searchBar setPlaceholder:@"请输入学校名称"];
    
    self.searchController =[[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    
    self.searchController.searchResultsDelegate= self;
    
    self.searchController.searchResultsDataSource = self;
    
    self.searchController.delegate = self;
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];

    NSArray *items = [[NSArray alloc] initWithObjects:@"长安大学", @"西安交通大学'", @"西北大学", @"西北工业大学", @"西安音乐学院", nil];
    
    self.allItems = items;

    [self.tableView reloadData];
  
}
-(void)Pop
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)addNavBar
{
    // Do any additional setup after loading the view.
    UIView *navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    navBar.backgroundColor = [UIColor whiteColor];
    UIButton  *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(10, 30, 30, 20);
    [back setBackgroundImage:[UIImage imageNamed:@"navigationbar_back.png"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(Pop) forControlEvents:UIControlEventTouchUpInside];
    [navBar addSubview:back];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 25, 160, 34)];
    titleLabel.text = _navBarTitle;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment =UIControlContentHorizontalAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    [navBar addSubview:titleLabel];
    [self.view addSubview:navBar];
}

#pragma mark - UISearbar的相关设置
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    
    self.searchBar.text = @"";

    [UIView animateWithDuration:0.2 animations:^{
        
        self.searchBar.showsCancelButton = YES;
        CGRect tmpFrame1 = self.searchBar.frame;
        tmpFrame1 = kTmpSearchBarFrame;
        self.searchBar.frame = tmpFrame1;
        CGRect tmpFrame2 = _tableView.frame;
        tmpFrame2 = kTmpTableViewFrame;
        _tableView.frame = tmpFrame2;
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    return YES;
    
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [UIView animateWithDuration:0.2 animations:^{
        //[self.searchBar resignFirstResponder];
        self.searchBar.showsCancelButton = NO;
        self.searchBar.text = @"输入城市名称或拼音";
        CGRect tmpFrame1 = self.searchBar.frame;
        tmpFrame1 = kOriginSearchBarFrame;
        self.searchBar.frame = tmpFrame1;
        CGRect tmpFrame2 = _tableView.frame;
        tmpFrame2 = kOriginTableViewFrame;
        _tableView.frame = tmpFrame2;
    } completion:^(BOOL finished) {
    }];

}

- (void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
    [UIView animateWithDuration:0.2 animations:^{
        [self.searchBar resignFirstResponder];
        self.searchBar.showsCancelButton = NO;
        self.searchBar.text = @"输入城市名称或拼音";
        
        CGRect tmpFrame1 = self.searchBar.frame;
        tmpFrame1 = kOriginSearchBarFrame;
        self.searchBar.frame = tmpFrame1;
        CGRect tmpFrame2 = _tableView.frame;
        tmpFrame2 = kOriginTableViewFrame;
        _tableView.frame = tmpFrame2;
    } completion:^(BOOL finished) {
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate的实现
- (NSInteger)tableView:(UITableView *)tableView   numberOfRowsInSection:(NSInteger)section {
    
    NSInteger rows = 0;
    
    if ([tableView isEqual:self.searchController.searchResultsTableView]){
        
        rows = [self.searchResults count];
        
    }else{
        
        rows = [self.allItems count];
        
    }
    
    return rows;
    
}

//在tableView:cellForRowAtIndexPath:方法里，我们需要做同样的事：



// Customize the appearance of table view cells.

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier] ;
        
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    /* Configure the cell. */
    
    if ([tableView isEqual:self.searchController.searchResultsTableView]){
        
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
        
    }else{
        
        cell.textLabel.text = [self.allItems objectAtIndex:indexPath.row];
        
    }
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.searchController.searchResultsTableView]){
        
      
        if (_changeCollegeBlock) {
            _changeCollegeBlock(0,[self.searchResults objectAtIndex:indexPath.row]);
            
        }
    }else{
        
        
        if (_changeCollegeBlock) {
            _changeCollegeBlock(0,[self.allItems objectAtIndex:indexPath.row]);
            
        }
    }

    
    [self dismissViewControllerAnimated:YES completion:nil];

}
#pragma mark - UIsearchController delegate methods
//现在来实现当搜索文本改变时的回调函数。这个方法使用谓词进行比较，并讲匹配结果赋给searchResults数组:


- (void)filterContentForSearchText:(NSString*)searchText                               scope:(NSString*)scope {
    
    NSPredicate *resultPredicate = [NSPredicate                                      predicateWithFormat:@"SELF contains[cd] %@",                                     searchText];
    
    self.searchResults = [self.allItems filteredArrayUsingPredicate:resultPredicate];
    
}

//接下来是UIsearchController的委托方法，负责响应搜索事件：


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    
    [self filterContentForSearchText:searchString                                 scope:[[self.searchController.searchBar scopeButtonTitles]                                       objectAtIndex:[self.searchController.searchBar                                                      selectedScopeButtonIndex]]];
    if ([self.searchResults count] == 0) {
        UITableView *tableView1 = self.searchDisplayController.searchResultsTableView;
        for( UIView *subview in tableView1.subviews ) {
            if( [subview class] == [UILabel class] ) {
                UILabel *lbl = (UILabel*)subview; // sv changed to subview.
                lbl.text = @"没有结果";
            }
        }
    }
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller  shouldReloadTableForSearchScope:(NSInteger)searchOption {
    
    [self filterContentForSearchText:[self.searchController.searchBar text]                                 scope:[[self.searchController.searchBar scopeButtonTitles]                                       objectAtIndex:searchOption]];
    
    return YES;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
