//
//  ChangeCityViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-3-15.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "ChangeCityViewController.h"
#import "SelectSchCell.h"
#import "SelectSchViewController.h"
#define kTmpSearchBarFrame CGRectMake(0, 20, 320, 44)
#define kOriginSearchBarFrame CGRectMake(0, 64, 320, 44)
#define kTmpTableViewFrame CGRectMake(0, 64, 320, 504)
#define kOriginTableViewFrame CGRectMake(0, 108, 320, 470)
@interface ChangeCityViewController ()
{
    int keyboardHeight;
    UISearchBar *SearchBar;
    UIButton *maskView;
    
}
@end

@implementation ChangeCityViewController

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
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 25, 160, 34)];
    titleLabel.text = _navBarTitle;
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
#pragma mark - 获取城市数据
-(void)getCityData
{
    self.arrayHotCity = [NSMutableArray arrayWithObjects:@"广州",@"北京",@"上海",@"西安",@"重庆",@"武汉",@"长沙",@"深圳",@"天津",@"成都", nil];
    self.keys = [NSMutableArray array];
    self.arrayCitys = [NSMutableArray array];
    self.arrayCellHeight = [NSMutableArray array];
    self.arrayLocationCity = [NSMutableArray arrayWithObjects:@"西安",nil];
    self.arrayRecentlyCity = [NSMutableArray arrayWithObjects:@"西安",@"北京", nil];
    NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict"
                                                   ofType:@"plist"];
    self.cities = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    self.allItems = [[NSMutableArray alloc]init];
    [self.keys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    for (id key in self.keys) {
       
        [_allItems addObjectsFromArray:[self.cities objectForKey:key]];
    }
    //添加热门城市
    NSString *strHot = @"热";
    NSString *strLocation =@"#";
    NSString *strRecently = @"$";
    
    [self.keys insertObject:strLocation atIndex:0];
    [self.keys insertObject:strRecently   atIndex:1];
    [self.keys insertObject:strHot atIndex:2];
  
}
#pragma mark - searchBar的相关设置
- (void)addSearchBar
{
    SearchBar = [[UISearchBar alloc]initWithFrame:kOriginSearchBarFrame];
    SearchBar.delegate = self;
    
    
    SearchBar.placeholder = @"输入城市名称或拼音";
    
    [self.view addSubview:SearchBar];
}
//- (void)keyboardWillShow:(NSNotification *)aNotification
//{
//    //获取键盘的高度
//    NSDictionary *userInfo = [aNotification userInfo];
//    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGRect keyboardRect = [aValue CGRectValue];
//    keyboardHeight = keyboardRect.size.height;
//}
//-(void)resign
//{
//    [UIView animateWithDuration:0.2 animations:^{
//        [SearchBar resignFirstResponder];
//        SearchBar.showsCancelButton = NO;
//        SearchBar.text = @"输入城市名称或拼音";
//        [maskView removeFromSuperview];
//        CGRect tmpFrame1 = SearchBar.frame;
//        tmpFrame1 = kOriginSearchBarFrame;
//        SearchBar.frame = tmpFrame1;
//        CGRect tmpFrame2 = _tableView.frame;
//        tmpFrame2 = kOriginTableViewFrame;
//        _tableView.frame = tmpFrame2;
//    } completion:^(BOOL finished) {
//    }];
//
//    
//}
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
    if ([key rangeOfString:@"热"].location != NSNotFound) {
        titleLabel.text = @"热门城市";
    }
    else if ([key rangeOfString:@"#"].location != NSNotFound){
        titleLabel.text = @"定为城市";
    }else if ([key rangeOfString:@"$"].location != NSNotFound){
        titleLabel.text = @"最近访问城市";
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
    if (section<=2) {
        return 1;
    }else{
    NSString *key = [_keys objectAtIndex:section];
    NSArray *citySection = [_cities objectForKey:key];
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
    [self setCellHeight:self.arrayLocationCity];
    [self setCellHeight:self.arrayRecentlyCity];
    [self setCellHeight:self.arrayHotCity];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (![tableView isEqual:self.searchController.searchResultsTableView]){
    if (indexPath.section <=2) {
        
       
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
        SelectSchCell *locationCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierid1];
        if (locationCell ==nil) {
            locationCell = [[SelectSchCell alloc]initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:cellIdentifierid1];
            
        }
        locationCell.selectionStyle = UITableViewCellSelectionStyleNone;//取消这个cell的选中样式
        locationCell.btnArray = self.arrayLocationCity;
        //定义cell的block，以在点击时调用，因为是在3个视图中传递参数，所以用了两个block
        //cell中btnblock调用，传递btn的title给changecityviewcontroller，然后调用它的changevityblock传递给selectschviewcontroll
        locationCell.selectCityBlock = ^(int selectSch,NSString *display){
            if (_changeCityBlock) {
                if (![_navBarTitle isEqualToString:[NSString stringWithFormat:@"当前城市：%@",display]]) {
                    _changeCityBlock(selectSch,display);
                    [self dismissViewControllerAnimated:NO completion:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"SwicthToChangeVC" object:nil];
                }else{
                    _changeCityBlock(selectSch,display);
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }
        
        };
       // _cellHeight = locationCell.cellHeight;
        
        return locationCell;

    }else if (indexPath.section == 1) {
        static NSString *cellIdentifierid2 = @"locationCell";//这两个标识不能一样，因为这个标识是循环用的，所以最好用类名来进行区别
        SelectSchCell *recentlyCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierid2];
        if (recentlyCell ==nil) {
            recentlyCell = [[SelectSchCell alloc]initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:cellIdentifierid2];
            
        }
        recentlyCell.selectionStyle = UITableViewCellSelectionStyleNone;//取消这个cell的选中样式
        recentlyCell.btnArray = self.arrayRecentlyCity;
       // _cellHeight = recentlyCell.cellHeight;
        recentlyCell.selectCityBlock = ^(int selectSch,NSString *display){
            if (_changeCityBlock) {
                if (![_navBarTitle isEqualToString:[NSString stringWithFormat:@"当前城市：%@",display]]) {
                    _changeCityBlock(selectSch,display);
                    [self dismissViewControllerAnimated:NO completion:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"SwicthToChangeVC" object:nil];
                }else{
                    _changeCityBlock(selectSch,display);
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }

        };

        return recentlyCell;
    }else if (indexPath.section == 2) {
        static NSString *cellIdentifierid3 = @"hotCell";//这两个标识不能一样，因为这个标识是循环用的，所以最好用类名来进行区别
        SelectSchCell *hotCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierid3];
        if (hotCell ==nil) {
            hotCell = [[SelectSchCell alloc]initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:cellIdentifierid3];
            
        }
        hotCell.selectionStyle = UITableViewCellSelectionStyleNone;//取消这个cell的选中样式
        hotCell.btnArray = self.arrayHotCity;
        //_cellHeight = hotCell.cellHeight;
       // NSLog(@"jklsdfhl%f",_cellHeight);
        hotCell.selectCityBlock = ^(int selectSch,NSString *display){
            if (_changeCityBlock) {
                if (![_navBarTitle isEqualToString:[NSString stringWithFormat:@"当前城市：%@",display]]) {
                    _changeCityBlock(selectSch,display);
                    [self dismissViewControllerAnimated:NO completion:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"SwicthToChangeVC" object:nil];
                }else{
                    _changeCityBlock(selectSch,display);
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }

            
                
         
        };

        return hotCell;
    }else
    {
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
    plainCell.textLabel.text = [[_cities objectForKey:key] objectAtIndex:indexPath.row];
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
    if (indexPath.section>=2) {
        if (_changeCityBlock) {
            //_changeCityBlock(0,[[_cities objectForKey:key] objectAtIndex:indexPath.row]);
            
            if (![_navBarTitle isEqualToString:[NSString stringWithFormat:@"当前城市：%@",[[_cities objectForKey:key] objectAtIndex:indexPath.row]]]) {
                _changeCityBlock(0,[[_cities objectForKey:key] objectAtIndex:indexPath.row]);
                [self dismissViewControllerAnimated:NO completion:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SwicthToChangeVC" object:nil];
            }else{
                _changeCityBlock(0,[[_cities objectForKey:key] objectAtIndex:indexPath.row]);
                [self dismissViewControllerAnimated:YES completion:nil];
            }

        }
        
        
    }
    }else{
        if (_changeCityBlock) {
            //_changeCityBlock(0,[self.searchResults objectAtIndex:indexPath.row]);
            if (![_navBarTitle isEqualToString:[NSString stringWithFormat:@"当前城市：%@",[self.searchResults objectAtIndex:indexPath.row]]]) {
                _changeCityBlock(0,[self.searchResults objectAtIndex:indexPath.row]);
                [self dismissViewControllerAnimated:NO completion:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SwicthToChangeVC" object:nil];
            }else{
                _changeCityBlock(0,[self.searchResults objectAtIndex:indexPath.row]);
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            

        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
