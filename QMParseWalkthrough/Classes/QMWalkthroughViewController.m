//
//  QMWalkthroughViewController.m
//  truebucha
//
//  Created by Bucha Kanstantsin on 8/9/18.
//  Copyright © 2018 truebucha. All rights reserved.
//

#import "QMWalkthroughViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <MYBlurIntroductionView/MYBlurIntroductionView.h>
#import <Parse/Parse.h>



@interface QMWalkthroughViewController ()
<
MYIntroductionDelegate
>

@property (copy, nonatomic) CDBErrorCompletion completion;
@property (copy, nonatomic) NSString * parseClass;

@end


@implementation QMWalkthroughViewController

//MARK: - property -

- (BOOL) shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations {
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskPortrait;
    }
    
    return UIInterfaceOrientationMaskAll;
}

//MARK: - life cycle -

+ (instancetype _Nonnull) controllerWithSourceParseClass: (NSString * _Nonnull) parseClass
                                              completion: (CDBErrorCompletion) completion {
    
    QMWalkthroughViewController * result = [QMWalkthroughViewController new];
    result.parseClass = parseClass;
    result.completion = completion;
    
    return result;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (self.parseClass == nil) {
        
        NSError * error = [self parseClassError];
        [self finishWithError: error];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo: self.view
                         animated: YES];
    
    [self showWalkthroughtInView: self.view];
}

- (void) finishWithError: (NSError *) error {

    self.completion(error);
}

//MARK: - protocols -

#pragma mark MYIntroductionDelegate

- (void) introduction: (MYBlurIntroductionView *) introductionView
     didChangeToPanel: (MYIntroductionPanel *) panel
            withIndex: (NSInteger) panelIndex {
    
    NSLog(@"Introduction did change to panel %ld", (long)panelIndex);
}

- (void)introduction: (MYBlurIntroductionView *) introductionView
   didFinishWithType: (MYFinishType)finishType {
       
    NSLog(@"Introduction did finish");
    [self finishWithError: nil];
}


//MARK: - logic -

- (void) showWalkthroughtInView: (UIView *) containerView {
    
    PFQuery * query = [PFQuery queryWithClassName: self.parseClass];
    [query orderByAscending: ascendingIndexKey];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        if (objects == nil
            || objects.count == 0) {
         
            return;
        }
        
        MYBlurIntroductionView * introView = [self buildViewUsingParseSlides: objects
                                                              containerFrame: containerView.bounds];
        
        [MBProgressHUD hideHUDForView: self.view
                             animated: YES];
        
        if (introView == nil) {
            
            NSError * error = [self introViewError];
            [self finishWithError: error];
            return;
        }
        
        introView.delegate = self;
        [containerView addSubview: introView];
    }];
}
     
- (MYBlurIntroductionView *) buildViewUsingParseSlides: (NSArray *) slides
                                        containerFrame: (CGRect) frame {
    
     if (slides == nil
         || slides.count == 0) {
         
         return nil;
     }
    
     NSMutableArray * panels = [NSMutableArray arrayWithCapacity: slides.count];
    
     for (PFObject * slide in slides) {

         PFFile * file = slide[ imageFileKey ];
         
         MYIntroductionPanel * panel = [self panelUsing: file
                                         containerFrame: frame];
         
         [panels addObject: panel];
     }
    
     MYBlurIntroductionView * result =
         [[MYBlurIntroductionView alloc] initWithFrame: frame];
      [result buildIntroductionWithPanels: panels];
    
     return result;
}
     
- (MYIntroductionPanel *) panelUsing: (PFFile *) parseFile
                      containerFrame: (CGRect) frame {

    NSData * data = [parseFile getData];
    UIImage * image = [UIImage imageWithData: data];
    
    MYIntroductionPanel * result =
        [[MYIntroductionPanel alloc] initWithFrame: frame
                                             title: nil
                                       description: nil
                                             image: image];
    
    result.PanelImageView.contentMode = UIViewContentModeScaleToFill;
    
    return result;
}

//MARK: - errors -

- (NSError *) parseClassError {
    
    NSString * describe = @"Failed to obtain corresponded parse class name to use walkthrough";
    NSError * result = [NSError errorWithDomain: @"walktrhough"
                                           code: 1
                                       userInfo: @{ NSLocalizedDescriptionKey: describe}];
    return result;
}

- (NSError *) introViewError {
    
    NSString * describe = @"Failed to create intro view using parse slides";
    NSError * result = [NSError errorWithDomain: @"walktrhough"
                                           code: 2
                                       userInfo: @{ NSLocalizedDescriptionKey: describe}];
    return result;
}

@end
