//
//  MUKitDemoMVVMColloectionController.m
//  MUKit
//
//  Created by Jekity on 2017/8/22.
//  Copyright © 2017年 Jeykit. All rights reserved.
//

#import "MUKitDemoMVVMColloectionController.h"
#import "MUTableViewSectionModel.h"
#import <MUCollectionViewManager.h>
#import "MUKitDemoCollectionViewCell.h"
#import "MUTempModel.h"
#import "MUKitDemoMVVMCollectionViewCell.h"
#import <MUWaterfallFlowLayout.h>
#import "MUKitDemoCollectionViewSignalCell.h"
#import "MUView.h"
#import <UIViewController+MUPopup.h>
//#import <MUPopupController.h>
#import "MUNavigation.h"
#import <UIImage+MUColor.h>

@interface MUKitDemoMVVMColloectionController ()
@property(nonatomic, strong)MUCollectionViewManager *manager;
@property(nonatomic, strong)UICollectionView *collectionView;
@end


static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseHeaderIdentifier = @"header";
static NSString * const reuseFooterIdentifier = @"footer";
@implementation MUKitDemoMVVMColloectionController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"MVVMCollectionView";
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    flowLayout.estimatedItemSize = CGSizeMake(80., 80.);
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 1;
    
    
//    MUWaterfallFlowLayout *flowLayout = [[MUWaterfallFlowLayout alloc]init];
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    //    flowLayout.estimatedItemSize = CGSizeMake(80., 80.);
//    flowLayout.minimumLineSpacing = 1;
//    flowLayout.minimumInteritemSpacing = 1;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - self.navigationBarAndStatusBarHeight) collectionViewLayout:flowLayout];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor lightTextColor];
    self.collectionView.alwaysBounceVertical = YES;
 
//    self.manager = [[MUCollectionViewManager alloc]initWithCollectionView:self.collectionView flowLayout:flowLayout subKeyPath:@"cellModelArray"];

//    self.manager = [[MUCollectionViewManager alloc]initWithCollectionView:self.collectionView flowLayout:flowLayout registerCellClass:NSStringFromClass([MUKitDemoMVVMCollectionViewCell class]) itemCountForRow:3 subKeyPath:nil];;
    self.manager = [[MUCollectionViewManager alloc]initWithCollectionView:self.collectionView  registerNib:NSStringFromClass([MUKitDemoCollectionViewSignalCell class]) itemCountForRow:1 subKeyPath:nil];
    
//    flowLayout.delegate = self.manager;
//    [self.manager registerNib:NSStringFromClass([MUKitDemoCollectionViewCell class]) cellReuseIdentifier:reuseIdentifier];
    
    [self.manager registerFooterViewClass:NSStringFromClass([UICollectionReusableView class]) withReuseIdentifier:reuseFooterIdentifier];
    [self.manager registerHeaderViewClass:NSStringFromClass([UICollectionReusableView class]) withReuseIdentifier:reuseHeaderIdentifier];
    

    [self configuredCell];
//    self.manager.modelArray  = [self CustomerSigleModelArray];
//    self.manager.modelArray  = [self modelData];
    

}
-(void)configuredCell{
    

    __weak typeof(self)weakSelef = self;
     weakSelef.manager.modelArray = [weakSelef modelData];
//    [self.manager addHeaderRefreshing:^(MURefreshHeaderComponent *refresh) {
//        
//        [refresh endRefreshing];
//         weakSelef.manager.modelArray = [weakSelef modelData];
//    }];
//
//    [self.manager addFooterRefreshing:^(MURefreshFooterComponent *refresh) {
//         weakSelef.manager.modelArray = [weakSelef modelData];
//        [refresh endRefreshing];
//    }];
    self.manager.renderBlock = ^UICollectionViewCell *(UICollectionViewCell *cell, NSIndexPath *indexPath, id model, CGFloat *height,UIEdgeInsets *sectionInsets) {
        
//        MUKitDemoMVVMCollectionViewCell *tempCell = (MUKitDemoMVVMCollectionViewCell *)cell;
//        tempCell.model = model;
//        *sectionInsets = UIEdgeInsetsMake(0, 10, 0, 10);
//        if (indexPath.row == 0) {
//             *height = 88.;
//        }
//        *height = 212;
        return cell;
    };
    
//    self.manager.headerViewBlock = ^UICollectionReusableView *(UICollectionReusableView *headerView, NSString *__autoreleasing *title, NSIndexPath *indexPath, id model, CGFloat *height) {
//        
//        *title = @"test";
//        return headerView;
//    };
// 
//    self.manager.footerViewBlock = ^UICollectionReusableView *(UICollectionReusableView *footerView, NSString *__autoreleasing *title, NSIndexPath *indexPath, id model, CGFloat *height) {
//        
//        *title = @"test";
//        return footerView;
//    };
//    
    weakify(self)
   self.manager.selectedItemBlock = ^(UICollectionView *collectionView, NSIndexPath *indexPath, id model, CGFloat *height) {
       normalize(self)
       NSLog(@"您点击了第%ld个section--------第%ld行,高度=%f",(long)indexPath.section,(long)indexPath.row,*height);
   };
    
    [self.manager addFooterRefreshing:^(MURefreshComponent *refresh) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//单层模型
-(NSMutableArray *)CustomerSigleModelArray{
    NSMutableArray *array = [NSMutableArray array];
    MUTableViewSectionModel *section1 = [[MUTableViewSectionModel alloc]init];
    section1.title       = @"Store Info";
    //    section1.cellModelArray       = [@[@"MacBook Online"] mutableCopy];
    //    if (self.type == MemberTypeManager) {
    section1.cellModelArray       = [@[@"MacBook Online",@"View all products",@"MacBooks Online"] mutableCopy];
    //    }
    [array addObject:section1];
    
    //    if (self.type == MemberTypeManager) {
    MUTableViewSectionModel *section2 = [[MUTableViewSectionModel alloc]init];
    section2.title = @"Advanced Settings";
    section2.cellModelArray       = [@[@"Store Decoration",@"Store Location",@"Open Time"] mutableCopy];
    [array addObject:section2];
    
    //    }
    
    
    
    MUTableViewSectionModel *section3 = [[MUTableViewSectionModel alloc]init];
    section3.title         = @"Income Info";
    //    if (self.type == MemberTypeManager) {
    section3.cellModelArray       = [@[@"Withdraw",@"Orders",@"Income"] mutableCopy];
    //    }
//    section3.cellModelArray       = [@[@"Orders",@"Income"] mutableCopy];
    [array addObject:section3];
    
    MUTableViewSectionModel *section4 = [[MUTableViewSectionModel alloc]init];
    section4.title         = @"Orther";
    section4.cellModelArray       = [@[@"About",@"About",@"About"] mutableCopy];
    [array addObject:section4];
    return  array;
}

-(NSMutableArray *)modelData{
    NSMutableArray *modelArray = [NSMutableArray array];
    
    MUTempModel *model1 = [[MUTempModel alloc]initWithString:@"动态高度测试，随便写写"];
    MUTempModel *model2 = [[MUTempModel alloc]initWithString:@"动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写"];
    MUTempModel *model3 = [[MUTempModel alloc]initWithString:@"动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写"];
    MUTempModel *model4 = [[MUTempModel alloc]initWithString:@"动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试"];
    MUTempModel *model5 = [[MUTempModel alloc]initWithString:@"动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试"];
    
    MUTempModel *model6 = [[MUTempModel alloc]initWithString:@"动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试"];
    MUTempModel *model7 = [[MUTempModel alloc]initWithString:@"动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试"];
    MUTempModel *model8 = [[MUTempModel alloc]initWithString:@"动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写"];
    MUTempModel *model9 = [[MUTempModel alloc]initWithString:@"动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写"];
    MUTempModel *model0 = [[MUTempModel alloc]initWithString:@"动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写,动态高度测试，随便写写"];
    
    modelArray = [@[model1,model2,model3,model4,model5,model6,model7,model8,model9,model0] mutableCopy];
    
//      modelArray = [@[model1,model2,model3,model4] mutableCopy];
    
    return modelArray;
}
Click_MUSignal(label){
    
    UILabel *view = (UILabel *)object;
    NSIndexPath *indexPath = view.indexPath;
    NSLog(@"我是cell上子控件的信号------%@---------%@-------",NSStringFromClass([object class]),indexPath);
}

Click_MUSignal(button){
    UIButton *view = (UIButton *)object;
    NSIndexPath *indexPath = view.indexPath;
    NSLog(@"我是cell上子控件的信号-----%@---------%@-------",NSStringFromClass([object class]),indexPath);
}

Click_MUSignal(segmentedController){
    UISegmentedControl *view = (UISegmentedControl *)object;
    NSIndexPath *indexPath = view.indexPath;
    NSLog(@"我是cell上子控件的信号------%@---------%@-------",NSStringFromClass([object class]),indexPath);
}

Click_MUSignal(textFile){
    UITextField *view = (UITextField *)object;
    NSIndexPath *indexPath = view.indexPath;
    NSLog(@"我是cell上子控件的信号%@---------%@-------%@",NSStringFromClass([object class]),indexPath,view.text);
}

Click_MUSignal(slider){
    UISlider *view = (UISlider *)object;
    NSIndexPath *indexPath = view.indexPath;
    NSLog(@"我是cell上子控件的信号%@---------%@-------%@",NSStringFromClass([object class]),indexPath,NSStringFromClass([view.viewController class]));
}

Click_MUSignal(muswitch){
    UISwitch *view = (UISwitch *)object;
    NSIndexPath *indexPath = view.indexPath;
    NSLog(@"我是cell上子控件的信号-----%@---------%@-------",NSStringFromClass([object class]),indexPath);
}

Click_MUSignal(greenView){
    MUView *view = (MUView *)object;
    NSIndexPath *indexPath = view.indexPath;
    NSLog(@"我是cell上子控件的信号------%@---------%@-------",NSStringFromClass([object class]),indexPath);
}

Click_MUSignal(blueView){
    UIView *view = (UIView *)object;
    NSIndexPath *indexPath = view.indexPath;
    NSLog(@"我是cell上子控件的信号%@---------%@-------",NSStringFromClass([object class]),indexPath);
}

Click_MUSignal(mmimageView){
    UIImageView *view = (UIImageView *)object;
    NSIndexPath *indexPath = view.indexPath;
    NSLog(@"我是cell上子控件的信号%@---------%@------",NSStringFromClass([object class]),indexPath);
}

Click_MUSignal(stepper){
    UIStepper *view = (UIStepper *)object;
    NSIndexPath *indexPath = view.indexPath;
    NSLog(@"我是cell上子控件的信号%@---------%@------",NSStringFromClass([object class]),indexPath);
}
@end
