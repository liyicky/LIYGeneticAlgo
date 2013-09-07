//
//  ViewController.h
//  LIYGeneticAlgo
//
//  Created by Jason Cheladyn on 7/7/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (unsafe_unretained) IBOutlet UITextView *textView;
@property (unsafe_unretained) IBOutlet UITableView *tableView;
@property (weak) IBOutlet UITextField *textField;
- (IBAction)handleRunAlgoBtn:(id)sender;
@end
