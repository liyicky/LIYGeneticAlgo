//
//  ViewController.m
//  LIYGeneticAlgo
//
//  Created by Jason Cheladyn on 7/7/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import "ViewController.h"
#import "JASGeneticAlgo.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) NSMutableArray * chromoGene;
@property (nonatomic,strong) NSMutableArray * chromoFitness;
@end

@implementation ViewController
@synthesize textView = _textView;
@synthesize textField = _textField;
@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.textField setDelegate:self];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleRunAlgoBtn:(id)sender
{
    NSString *processing = (@"Processing the Algo..");
    [self.textView setText:processing];
    [self performSelector:@selector(runAlgorithm)
               withObject:nil afterDelay:0.1];
    [self.textField resignFirstResponder];
}

- (void)runAlgorithm
{
    NSString *targetString = [self.textField text];
    if ([targetString length] > 30)
    {
        [self.textView setText:@"Enter a smaller string please"];
    }
    else
    {
        NSDate *start = [NSDate date];
        JASGeneticAlgo *algo = [[JASGeneticAlgo alloc] initWithTargetSequence:targetString];
        [algo execute];
        NSTimeInterval runtime = [start timeIntervalSinceNow] * -1;
        NSString *msg = [NSString stringWithFormat:@"Output Sequence: %@\nElapsed Generations: %d\nDuration: %.2f seconds", algo.result, algo.generations, runtime];
        self.chromoGene = algo.chromos;
        //self.chromoFitness = chromosome.chromoFitness;
        [self.textView setText:msg];
        [self.tableView reloadData];

    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.chromoGene.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSArray * entry = [self.chromoGene objectAtIndex:indexPath.row];
    [cell.textLabel setText: [NSString stringWithFormat:@"%@",[entry objectAtIndex:0]]];
    
    NSLog(@"type: %@", [[entry objectAtIndex:1] class]);
    if ([[[entry objectAtIndex:1]stringValue] isEqualToString:@"0"])
    {
        NSLog(@"Gene IntXXXXXX: %@", [entry objectAtIndex:1]);
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"Perfect Gene: %@",[entry objectAtIndex:1]]];
    }else{
        NSLog(@"Gene Int: %@", [entry objectAtIndex:1]);
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"Gene Fitness: %@",[entry objectAtIndex:1]]];
    }

    return cell;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.textField resignFirstResponder];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];
    [self handleRunAlgoBtn:nil];
    return NO;
}



@end
