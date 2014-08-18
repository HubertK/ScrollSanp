//
//  ViewController.m
//  ScrollTo
//
//  Created by Hubert Kunnemeyer on 8/16/14.
//  Copyright (c) 2014 Hubert Kunnemeyer. All rights reserved.
//

#import "ViewController.h"
#import "SimpleCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIView *nextView;
@property (nonatomic) BOOL loaded;
@property (nonatomic) BOOL snapped;
@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Pull to view";
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.collectionView registerClass:[SimpleCell class] forCellWithReuseIdentifier:@"Cell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(5, 0, 20, 0);
    [self.view addSubview:self.collectionView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"%f",self.collectionView.contentSize.height);
    self.nextView = [[UIView alloc]initWithFrame:CGRectMake(0, self.collectionView.contentSize.height+30, CGRectGetWidth(self.view.bounds), 30)];
    self.nextView.backgroundColor = [UIColor colorWithRed:0.27 green:0.33 blue:0.43 alpha:1];
    self.nextView.alpha = 0.0;
    CGRect labelFrame = CGRectMake(10,10,300,40);
    UILabel *aLabel = [[UILabel alloc] initWithFrame:labelFrame];
    aLabel.backgroundColor = [UIColor clearColor];
    aLabel.textColor = [UIColor darkTextColor];
    aLabel.textAlignment = NSTextAlignmentCenter;
    aLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
    aLabel.text = @"Next: Business of Medicine";
    [self.nextView addSubview:aLabel];
    [self.collectionView addSubview:self.nextView];
    _loaded = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SimpleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *cellTitle = [NSString stringWithFormat:@"Cell %ld",(long)indexPath.item];
    cell.label.text = cellTitle;

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CGRectGetWidth(self.view.bounds)-20, 60);
}



#pragma mark- ScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat stretch = -130;
    
    CGFloat statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat inset = self.navigationController.navigationBar.frame.size.height + statusHeight + 5;
    CGFloat height = scrollView.contentSize.height - CGRectGetHeight(self.view.bounds) + inset + 20;
    CGFloat offset = scrollView.contentOffset.y+inset;
    
    CGFloat diff = height - offset;
    NSLog(@"scroll offset Y :%f",offset);
    NSLog(@"CollectionView height: %f",height);
    NSLog(@"diff: %f",diff);
    CGFloat percent = diff/stretch;
     NSLog(@"Percent:%f",percent);
    self.nextView.alpha = 1;

    if (diff <= stretch && _loaded) {
         NSLog(@"SNAP!");
        UIEdgeInsets insets = self.collectionView.contentInset;
        insets.bottom = 120 + 10;
        self.collectionView.contentInset = insets;

        if (!_snapped) {
            _snapped = YES;
            CGRect nextFrame = self.nextView.frame;
            nextFrame.origin.y -=20;
            nextFrame.size.height = 100;
            [UIView animateWithDuration:1.0
                                  delay:0.0
                 usingSpringWithDamping:0.5
                  initialSpringVelocity:0.7
                                options:0
                             animations:^{
                                 self.nextView.frame = nextFrame;
                             } completion:^(BOOL finished) {
                                 
                             }];
        }
    }else{
        if (!_snapped && diff < 0) {
            CGRect nextViewFrame = self.nextView.frame;
            nextViewFrame.size.height = abs(diff);
//            CGFloat newY = nextViewFrame.origin.y + abs(percent);
//            nextViewFrame.origin.y = newY;
            self.nextView.frame = nextViewFrame;
        }
        
    }
}

















@end
