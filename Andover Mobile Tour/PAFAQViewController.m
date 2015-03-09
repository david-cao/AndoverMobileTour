//
//  PAFAQViewController.m
//  MobileTourModel
//
//  Created by David Cao on 6/1/14.
//  Copyright (c) 2014 Phillips Academy Andover. All rights reserved.
//

#import "PAFAQViewController.h"
#import "PAFAQTableViewCell.h"
#import "PAFAQAnswerViewController.h"

@interface PAFAQViewController ()

@end

@implementation PAFAQViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        //Get Questions and Answers
        NSError *err = nil;
        NSString *questions = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"faqQuestions" ofType:@"txt"] encoding:NSUTF8StringEncoding error:&err];
        NSString *answers =[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"faqAnswers" ofType:@"txt"] encoding:NSUTF8StringEncoding error:&err];
        if (err) {
            NSLog(@"Error with description text: %@", [err localizedDescription]);
        }
        
        [self setAnswers:[answers componentsSeparatedByString:@"\n"]];
        [self setQuestions:[questions componentsSeparatedByString:@"\n"]];
        
        NSLog(@"Answers: %@", [self answers]);
        NSLog(@"Questions: %@", [self questions]);
        
        [[self navigationItem] setTitle:@"F.A.Q."];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self answers] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PAFAQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FAQCell"];
    
    // Configure the cell...
    if(!cell) {
        cell = [[PAFAQTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FAQCell"];
    }
    
    [[cell textLabel] setText:[[self questions] objectAtIndex:[indexPath row]]];
    [[cell textLabel] setNumberOfLines:2];
    NSLog(@"%@", [[self answers] objectAtIndex:[indexPath row]]);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PAFAQAnswerViewController *answerController = [[PAFAQAnswerViewController alloc] initWithQuestion:[[self questions] objectAtIndex:[indexPath row]] answer:[[self answers] objectAtIndex:[indexPath row]]];
    
    [[self navigationController] pushViewController:answerController animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
