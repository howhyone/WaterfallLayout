//
//  ViewController.m
//  WaterfallLayout
//
//  Created by mob on 2018/8/8.
//  Copyright © 2018年 mob. All rights reserved.
//

#import "ViewController.h"
#import "WaterfallCollectionViewCell.h"
#import "ZXWaterfallLayout.h"
#import "ShopModel.h"

#import "LMHWaterFallLayout.h"
//#import "LMHWaterFallLayout.h"

@interface ViewController ()<UICollectionViewDataSource,ZXWaterfallLayoutDelegate,LMHWaterFallLayoutDeleaget>

@property(nonatomic, strong)NSMutableArray *shops;
@property(nonatomic, weak)UICollectionView *collectionView;
@property(nonatomic, assign) NSUInteger columnCount;

@end

@implementation ViewController

#pragma mark ---- 懒加载

-(NSMutableArray *)shops
{
    if (!_shops) {
        _shops = [NSMutableArray arrayWithCapacity:1];
    }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialize];
    [self setupLayoutAndCollectionView];
    [self setupRefresh];
}

#pragma mark ----- 初始化
-(void)initialize
{
    self.title = @"瀑布流";
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

//创建布局和collectionView
-(void)setupLayoutAndCollectionView
{
    ZXWaterfallLayout *waterFallLayout = [[ZXWaterfallLayout alloc] init];

        waterFallLayout.delegate = self;
//     创建collectionview
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:waterFallLayout];
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
//    注册
    [collectionView registerClass:[WaterfallCollectionViewCell class] forCellWithReuseIdentifier:@"WaterfallCollectionViewCell"];
    self.collectionView = collectionView;
    NSLog(@"sdf");
}

-(void)setupRefresh
{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    self.collectionView.mj_header.backgroundColor = [UIColor yellowColor];
    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMorShops)];
    self.collectionView.mj_footer.backgroundColor = [UIColor yellowColor];
    self.collectionView.mj_footer.hidden = YES;
}

-(void)loadNewShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shops = [ShopModel mj_objectArrayWithFilename:@"shop.plist"];
        [self.shops removeAllObjects];
        [self.shops addObjectsFromArray:shops];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    });
}

-(void)loadMorShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shops = [ShopModel mj_objectArrayWithFilename:@"shop.plist"];
        [self.shops removeAllObjects];
        [self.shops addObjectsFromArray:shops];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    });
}

- (void)segmentClick: (UISegmentedControl *)segment{
    
    NSInteger index = segment.selectedSegmentIndex;
    
    switch (index) {
        case 0:
            self.columnCount = 2;
            
            break;
            
        case 1:
            self.columnCount = 3;
            break;
        default:
            break;
    }
}

#pragma mark ------ 代理
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    self.collectionView.mj_footer.hidden = self.shops.count == 0;
    return self.shops.count;
//    return 10;
}
- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterfallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WaterfallCollectionViewCell" forIndexPath:indexPath];
    cell.shopModel = self.shops[indexPath.row];
    return cell;
}

#pragma mark -------- ZXWaterfallLayoutDelegate
-(CGFloat)waterFallLayout:(ZXWaterfallLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth
{
    ShopModel *shop = self.shops[indexPath];
    return itemWidth * shop.h / shop.w;
}
-(CGFloat)rowMerginInWaterFallLayout:(ZXWaterfallLayout *)waterFallLayout
{
    return 20;
}
-(NSUInteger)columnCountInWaterFallLayout:(ZXWaterfallLayout *)waterFallLayout
{
    return 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
