//
//  ListViewController.m
//  Note2
//
//  Created by Gemma Ragozzine on 10/15/14.
//  Copyright (c) 2014 Gemma Ragozzine. All rights reserved.
//


#import "ListViewController.h"
#import "NoteDetailViewController.h"
#import "NoteInputViewController.h"
#import "Note.h"

static NSString *const kListViewTableViewCellReuseIdentifier = @"kListViewTableViewCellReuseIdentifier";

@interface ListViewController () <UITableViewDelegate, UITableViewDataSource, NoteInputViewControllerDelegate, NoteDetailViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    if(self.noteStrings == nil){
        self.noteStrings = [NSMutableArray array];
    }
    
  
}

- (NSInteger) tableView:(UITableView *)tableView
  numberOfRowsInSection:(NSInteger)section
{
    
    return self.noteStrings.count;
}

//Method to create a new cell 
-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:kListViewTableViewCellReuseIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kListViewTableViewCellReuseIdentifier];
    }
    
    NSInteger row = indexPath.row;
    Note *note = self.noteStrings[row];
    
    
    [self getCurrentDate];
    
    cell.textLabel.text = note.title;
    cell.detailTextLabel.text = note.date;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   
    
    return cell;
}


//Method to handle the action once a user selects a row
 -(void)tableView:(UITableView *)tableView
 didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 NSInteger index = indexPath.row;
 Note *note = self.noteStrings[index];
 NSString *title = note.title;
 NSString *content = note.content;
 NSString *date = note.date;
UIImage *image = note.image;


    //create a NoteDetailViewController
    NoteDetailViewController *noteDetailVC = [[NoteDetailViewController alloc]initWithIndex:index title:title content:content date: date image:image];
    noteDetailVC.delegate = self;
     
     [self.navigationController pushViewController:noteDetailVC animated:YES];
     
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
 }

//Method to create a new note with information obtained from NoteInputViewController view
-(void)noteInputViewController:(NoteInputViewController *)noteInVC didFinishWithTitle:(NSString *)title didFinishWithBody:(NSString *)content didFinishWithImage:(UIImage *)image
{
    Note* newNote =[[Note alloc] initWithTitle:title date:[self getCurrentDate] content:content image:image];
    
    [self.noteStrings addObject:newNote];
    [self.tableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//TO DO: Add cancel button to NoteInputViewController
- (void)noteInputViewControllerDidCancel:(NoteInputViewController *)noteInVc
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

//Method to prepare for storyboard segue going from ListViewController to NoteInputViewController to add a new note
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ListToAddNote"])
    {
        NoteInputViewController *noteInputVC = segue.destinationViewController;
        noteInputVC.delegate = self;
    }
}

//Method to get the current date and format it in the desired way
-(NSString *)getCurrentDate
{
    NSDateFormatter* formatter;
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy hh:mm"];
    [formatter setLocale:[NSLocale currentLocale]];
    
    NSDate *todaysDate =[NSDate date] ;
    
    NSString *date = [formatter stringFromDate:todaysDate];
    return date;
}

//Method to handle changes made while viewing note details in NoteDetailViewController view
-(void)noteDetailViewController:(NoteDetailViewController *)noteDetailVC didFinishWithTitle:(NSString *)title didFinishWithBody:(NSString *)content didFinishWithIndex:(NSInteger)index didFinishWithImage:(UIImage *)image
{
    Note *currentNote = [self.noteStrings objectAtIndex:index];
    currentNote.title = title;
    currentNote.content = content;
    currentNote.image = image;
    
    [self.noteStrings replaceObjectAtIndex:index withObject:currentNote];
    [self.tableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Add delete row functionality
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.noteStrings removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        NSLog(@"Unhandled editing style! %ld", editingStyle);
    }
}

//- (void)saveData {
//    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] initWithCapacity:3];
//   
//    
//    if (self.noteStrings != nil) {
//        [dataDict setObject:self.noteStrings forKey:@"notes"];  // save the games array
//    }
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
//    NSString *file = [documentsDirectoryPath stringByAppendingPathComponent:@"noteData"];
//    
//    [NSKeyedArchiver archiveRootObject:dataDict toFile:file];
//}



@end
