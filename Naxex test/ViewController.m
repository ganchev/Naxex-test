//
//  ViewController.m
//  Naxex test
//
//  Created by Miroslav Ganchev on 6/15/16.
//  Copyright © 2016 Miroslav Ganchev. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "QuotesTableViewController.h"
#import "QuotesCollectionViewController.h"

@interface ViewController ()
@property (nonatomic) QuotesTableViewController *quotesTableView;
@property (nonatomic) QuotesCollectionViewController *quotesCollectionView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(getQuotes)
                                   userInfo:nil
                                    repeats:YES];
    
    self.quotesTableView =[self.storyboard instantiateViewControllerWithIdentifier:@"QuotesTableViewController"];
    self.quotesTableView.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addChildViewController:self.quotesTableView];
    self.quotesCollectionView =[self.storyboard instantiateViewControllerWithIdentifier:@"QuotesCollectionViewController"];
    self.quotesCollectionView.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addChildViewController:self.quotesCollectionView];
    [self addSubview:self.quotesTableView.view toView:self.containerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showComponent:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 1) {
        [self cycleFromViewController:self.quotesTableView toViewController:self.quotesCollectionView];
    } else {
        [self cycleFromViewController:self.quotesCollectionView toViewController:self.quotesTableView];
    }
}

- (void)cycleFromViewController:(UIViewController*) oldViewController
               toViewController:(UIViewController*) newViewController {
    [oldViewController willMoveToParentViewController:nil];
    [self addChildViewController:newViewController];
    [self addSubview:newViewController.view toView:self.containerView];
    newViewController.view.alpha = 0;
    [newViewController.view layoutIfNeeded];
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         newViewController.view.alpha = 1;
                         oldViewController.view.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [oldViewController.view removeFromSuperview];
                         [oldViewController removeFromParentViewController];
                         [newViewController didMoveToParentViewController:self];
                     }];
}

- (void)addSubview:(UIView *)subView toView:(UIView*)parentView {
    [parentView addSubview:subView];
    
    NSDictionary * views = @{@"subView" : subView,};
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subView]|"
                                                                   options:0
                                                                   metrics:0
                                                                     views:views];
    [parentView addConstraints:constraints];
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subView]|"
                                                          options:0
                                                          metrics:0
                                                            views:views];
    [parentView addConstraints:constraints];
}


- (void) getQuotes{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    [manager POST:@"http://eu.tradenetworks.com/QuotesBox/quotes/GetQuotesBySymbols?languageCode=en-US&symbols=EURUSD,GBPUSD,USDCHF,USDJPY,AUDUSD,USDCAD,GBPJPY,EURGBP,EURJPY,AUDCAD" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSString* jsonString = [NSString stringWithUTF8String:[responseObject bytes]];
        if (jsonString !=nil) {
            jsonString = [jsonString substringWithRange:NSMakeRange(1, jsonString.length-2)];
        }else{
            
        }
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError* jsonError = nil;
        NSArray* jsonArray = nil; // your data will come out as a NSDictionry from the parser
        jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments  error:&jsonError];
        if (jsonArray) {
            dispatch_async(dispatch_get_main_queue(),^{
                self.quotesList = jsonArray;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"getQuotes" object:jsonArray];
            });
        }else{
            
        }
        NSLog(@"JSON: %@", jsonString);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Няма връзка с мрежата!"
//                                                        message:error.localizedDescription
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
        NSLog(@"Error: %@", error);
    }];
}

@end
