//
//  FFLoadView.m
//  Funmily
//
//  Created by Kuroky on 16/10/26.
//  Copyright © 2016年 HuuHoo. All rights reserved.
//

#import "FFLoadView.h"
#import "Masonry.h"

static CGFloat const loadViewWidth          =   320;
static CGFloat const loadViewHeight         =   140;

@interface FFLoadView ()

@property (nonatomic, strong) FFLoadModel *loadModel;
@property (weak, nonatomic) IBOutlet UIImageView *holdImageView;
@property (weak, nonatomic) IBOutlet UILabel *holdLabel;

@end

@implementation FFLoadView

+ (FFLoadView *)ff_loadStatusView:(FFLoadType)type {
    FFLoadView *view = [[[NSBundle mainBundle] loadNibNamed:@"FFLoadView" owner:self options:nil] firstObject];
    view.loadType = type;
    view.frame = CGRectMake(0, 0, loadViewWidth, loadViewHeight);
    return view;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)ff_reloadData {
    // 如果和上次一种类型,不在重置
    if (self.loadType == self.loadModel.loadType) {
        return;
    }
    _loadType = self.loadModel.loadType;
    self.loadModel.loadtext = self.labelText.length ? self.labelText : self.loadModel.loadtext;
    self.loadModel.loadImageName = self.imageName.length ? self.imageName : self.loadModel.loadImageName;
    self.holdLabel.text = self.loadModel.loadtext;
    self.holdImageView.image = [UIImage imageNamed:self.loadModel.loadImageName];
    
    UIView *superView = self.superview;
    if (!superView) {
        return;
    }
    
    CGFloat topLead = 0;
    if (self.topLeading > 0) {
        topLead = -(loadViewHeight + self.topLeading) * 0.5;
    }
    else {
        topLead = -loadViewHeight;
    }
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView.mas_centerX);
        make.centerY.equalTo(superView.mas_centerY).offset(topLead);
    }];
}

- (void)setLoadType:(FFLoadType)loadType {
    if (loadType == FFLoadShouldHide) {
        self.holdLabel.hidden = YES;
        self.holdImageView.hidden = YES;
        return;
    }
    if (!self.loadModel) {
        self.loadModel = [[FFLoadModel alloc] initWithType:loadType];
    }
    
    self.loadModel.loadType = loadType;
    self.holdLabel.hidden = NO;
    self.holdImageView.hidden = YES;
}

#pragma mark - 移除loading
- (void)ff_removeLoadingView {
    if (self.superview) {
        [self removeFromSuperview];
    }
}

@end

@interface FFLoadModel ()

@end

@implementation FFLoadModel

- (instancetype)initWithType:(FFLoadType)type {
    self = [super init];
    if (self) {
        self.loadType = type;
    }
    return self;
}

- (void)setLoadType:(FFLoadType)loadType {
    _loadType = loadType;
    if (loadType == FFLoadShouldHide) {
        self.loadtext = @"";
        self.loadImageName = @"loadingHolder";
    }
    else if (loadType == FFLoadNoData) {
        self.loadtext = @"对不起，居然真的没有数据";
        self.loadImageName = @"pic_sousuo_none";
    }
    else if (loadType == FFLoadNetWorkError) {
        self.loadtext = @"呀网络出问题了";
        self.loadImageName = @"pic_networkOutage";
    }
    else if (loadType == FFLoadIsLoaing) {
        self.loadtext = @"努力加载中...";
        self.loadImageName = @"loadingHolder";
    }
}

@end
