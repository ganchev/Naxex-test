//
//  ViewController.m
//  Naxex test
//
//  Created by Miroslav Ganchev on 6/15/16.
//  Copyright © 2016 Miroslav Ganchev. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(getQuotes)
                                   userInfo:nil
                                    repeats:YES];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        NSLog(@"JSON: %@", jsonString);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Няма връзка с мрежата!"
                                                        message:error.localizedDescription
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        NSLog(@"Error: %@", error);
    }];
}

@end
