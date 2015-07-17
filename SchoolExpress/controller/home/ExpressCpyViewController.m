//
//  ExpressCpyViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-3-30.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "ExpressCpyViewController.h"
#import "SelectSchCell.h"
#import "SelectSchViewController.h"
#define kTmpSearchBarFrame CGRectMake(0, 20, 320, 44)
#define kOriginSearchBarFrame CGRectMake(0, 64, 320, 44)
#define kTmpTableViewFrame CGRectMake(0, 64, 320, 504)
#define kOriginTableViewFrame CGRectMake(0, 108, 320, 470)

@interface ExpressCpyViewController ()
{
    int keyboardHeight;
    UISearchBar *SearchBar;
    UIButton *maskView;

}
@end

@implementation ExpressCpyViewController

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
    
    
    [self getCityData];
    [self setTotalCellHeight];
    
    [self addNavBar];
    [self addSearchBar];
    _tableView = [[UITableView alloc] initWithFrame:kOriginTableViewFrame style:UITableViewStylePlain];
    _tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
    //_tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.delaysContentTouches = NO;
    _tableView.userInteractionEnabled = YES;
    self.searchController =[[UISearchDisplayController alloc] initWithSearchBar:SearchBar contentsController:self];
    
    self.searchController.searchResultsDelegate= self;
    
    self.searchController.searchResultsDataSource = self;
    
    self.searchController.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)addNavBar
{
	// Do any additional setup after loading the view.
    UIView *navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    navBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navBar];
    UIButton  *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(10, 30, 30, 20);
    [back setBackgroundImage:[UIImage imageNamed:@"navigationbar_back.png"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(Pop) forControlEvents:UIControlEventTouchUpInside];
    [navBar addSubview:back];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 25, 160, 34)];
    titleLabel.text = @"哪家快递";
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment =UIControlContentHorizontalAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    //titleLabel.backgroundColor = [UIColor lightGrayColor];
    [navBar addSubview:titleLabel];
}
-(void)Pop
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 获取快递公司数据
-(void)getCityData
{
    self.arrayCommonExpress = [NSMutableArray arrayWithObjects:@"顺丰",@"EMS",@"圆通",@"申通",@"中通",@"汇通",@"韵达",@"京东",@"唯品会", nil];
    self.keys = [NSMutableArray array];
    //self.arrayExpresses = [NSMutableArray array];
    self.arrayCellHeight = [NSMutableArray array];
    //self.arrayLocationCity = [NSMutableArray arrayWithObjects:@"西安",nil];
    //self.arrayRecentlyCity = [NSMutableArray arrayWithObjects:@"西安",@"北京", nil];
    NSString *path=[[NSBundle mainBundle] pathForResource:@"快递公司"
                                                   ofType:@"plist"];
    self.expresses = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    self.allItems = [[NSMutableArray alloc]init];
    [self.keys addObjectsFromArray:[[self.expresses allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    for (id key in self.keys) {
        
        [_allItems addObjectsFromArray:[self.expresses objectForKey:key]];
    }
    //添加热门城市
    NSString *strHot = @"常";
    //NSString *strLocation =@"#";
   // NSString *strRecently = @"$";
    
    //[self.keys insertObject:strLocation atIndex:0];
    //[self.keys insertObject:strRecently   atIndex:1];
    [self.keys insertObject:strHot atIndex:0];
    
}
#pragma mark - searchBar的相关设置
- (void)addSearchBar
{
    SearchBar = [[UISearchBar alloc]initWithFrame:kOriginSearchBarFrame];
    SearchBar.delegate = self;
    
    
    SearchBar.placeholder = @"输入快递公司名称或拼音";
    
    [self.view addSubview:SearchBar];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    
    searchBar.text = @"";
    //    maskView = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, 320, 504-keyboardHeight)];
    //    maskView.alpha = 0.2;
    //    maskView.backgroundColor = [UIColor blackColor];
    //
    //    [maskView addTarget:self action:@selector(resign) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:maskView];
    [UIView animateWithDuration:0.2 animations:^{
        
        searchBar.showsCancelButton = YES;
        CGRect tmpFrame1 = SearchBar.frame;
        tmpFrame1 = kTmpSearchBarFrame;
        SearchBar.frame = tmpFrame1;
        CGRect tmpFrame2 = _tableView.frame;
        tmpFrame2 = kTmpTableViewFrame;
        _tableView.frame = tmpFrame2;
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    return YES;
    
}
- (void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
    [UIView animateWithDuration:0.2 animations:^{
        [SearchBar resignFirstResponder];
        SearchBar.showsCancelButton = NO;
        SearchBar.text = @"输入城市名称或拼音";
        
        CGRect tmpFrame1 = SearchBar.frame;
        tmpFrame1 = kOriginSearchBarFrame;
        SearchBar.frame = tmpFrame1;
        CGRect tmpFrame2 = _tableView.frame;
        tmpFrame2 = kOriginTableViewFrame;
        _tableView.frame = tmpFrame2;
    } completion:^(BOOL finished) {
    }];
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    //[self resign];
    [UIView animateWithDuration:0.2 animations:^{
        [SearchBar resignFirstResponder];
        SearchBar.showsCancelButton = NO;
        SearchBar.text = @"输入城市名称或拼音";
        //[maskView removeFromSuperview];
        CGRect tmpFrame1 = SearchBar.frame;
        tmpFrame1 = kOriginSearchBarFrame;
        SearchBar.frame = tmpFrame1;
        CGRect tmpFrame2 = _tableView.frame;
        tmpFrame2 = kOriginTableViewFrame;
        _tableView.frame = tmpFrame2;
    } completion:^(BOOL finished) {
    }];
    
}

#pragma mark - tableView
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (![tableView isEqual:self.searchController.searchResultsTableView]){
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        bgView.backgroundColor = [UIColor lightGrayColor];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 250, 20)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:12];
        
        NSString *key = [_keys objectAtIndex:section];
        if ([key rangeOfString:@"常"].location != NSNotFound) {
            titleLabel.text = @"常用快递";
        }else{
            titleLabel.text = key;
            
        }
        
        [bgView addSubview:titleLabel];
        
        return bgView;
    }else{
        return nil;
    }
    //return nil;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (![tableView isEqual:self.searchController.searchResultsTableView]){
        return _keys;
    }else{
        return nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (![tableView isEqual:self.searchController.searchResultsTableView]){
        return [_keys count];
    }else{
        return self.searchResults.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (![tableView isEqual:self.searchController.searchResultsTableView]){
        if (section == 0) {
            return 1;
        }else{
            NSString *key = [_keys objectAtIndex:section];
            NSArray *citySection = [_expresses objectForKey:key];
            return [citySection count];
        }
    }else{
        return 1;
    }
}
-(void)setCellHeight:(NSMutableArray *)array
{
    SelectSchCell *tmpCell = [[SelectSchCell alloc]init];
    tmpCell.btnArray = array;
    NSString *tmpStr = [NSString stringWithFormat:@"%f",tmpCell.cellHeight];
    [self.arrayCellHeight addObject:tmpStr];
    
}
- (void)setTotalCellHeight
{
    //[self setCellHeight:self.arrayLocationCity];
    //[self setCellHeight:self.arrayRecentlyCity];
    [self setCellHeight:self.arrayCommonExpress];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (![tableView isEqual:self.searchController.searchResultsTableView]){
        if (indexPath.section == 0) {
            
            
            return [self.arrayCellHeight[indexPath.section] floatValue];
            
            
            
        }else{
            return 40;
        }
    }else{
        return 40;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![tableView isEqual:self.searchController.searchResultsTableView]){
        
        if (indexPath.section == 0) {
            static NSString *cellIdentifierid1 = @"locationCell";//这两个标识不能一样，因为这个标识是循环用的，所以最好用类名来进行区别
            SelectSchCell *companyCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierid1];
            if (companyCell ==nil) {
                companyCell = [[SelectSchCell alloc]initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:cellIdentifierid1];
                
            }
            companyCell.selectionStyle = UITableViewCellSelectionStyleNone;//取消这个cell的选中样式
            companyCell.btnArray = self.arrayCommonExpress;
            //定义cell的block，以在点击时调用，因为是在3个视图中传递参数，所以用了两个block
            //cell中btnblock调用，传递btn的title给changecityviewcontroller，然后调用它的changevityblock传递给selectschviewcontroll
            companyCell.selectCityBlock = ^(int selectSch,NSString *display){
            
                if (_selectCmpyBlock) {
                    _selectCmpyBlock(selectSch,display);
                }

                [self dismissViewControllerAnimated:YES completion:nil];
            };
            // _cellHeight = locationCell.cellHeight;
            
            return companyCell;
            
        
        }else{
            static NSString *CellIdentifier4 = @"plainCell";
            
            NSString *key = [_keys objectAtIndex:indexPath.section];
            
            UITableViewCell *plainCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
            if (plainCell == nil) {
                plainCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier4] ;
                plainCell.backgroundColor = [UIColor clearColor];
                //plainCell.contentView.backgroundColor = [UIColor clearColor];
                plainCell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                [plainCell.textLabel setTextColor:[UIColor blackColor]];
                plainCell.textLabel.font = [UIFont systemFontOfSize:18];
            }
            plainCell.textLabel.text = [[_expresses objectForKey:key] objectAtIndex:indexPath.row];
            return plainCell;
        }
    }else{
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier] ;
            
        }
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![tableView isEqual:self.searchController.searchResultsTableView]){
        NSString *key = [_keys objectAtIndex:indexPath.section];
        if (indexPath.section>=1) {
            if (_selectCmpyBlock) {
        
                    _selectCmpyBlock(0,[[_expresses objectForKey:key] objectAtIndex:indexPath.row]);
                
                
                }
        }
        
    }else{
        if (_selectCmpyBlock) {
            //_changeCityBlock(0,[self.searchResults objectAtIndex:indexPath.row]);
       
                _selectCmpyBlock(0,[self.searchResults objectAtIndex:indexPath.row]);
            
            
         }
    }
    
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)filterContentForSearchText:(NSString*)searchText                               scope:(NSString*)scope {
    
    NSPredicate *resultPredicate = [NSPredicate                                      predicateWithFormat:@"SELF contains[cd] %@",                                     searchText];
    
    self.searchResults = [self.allItems filteredArrayUsingPredicate:resultPredicate];
    
}

//接下来是UIsearchController的委托方法，负责响应搜索事件：



#pragma mark - UIsearchController delegate methods


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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
