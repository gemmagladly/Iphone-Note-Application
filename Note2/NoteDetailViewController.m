//
//  NoteDetailViewController.m
//  Note2
//
//  Created by Gemma Ragozzine on 10/15/14.
//  Copyright (c) 2014 Gemma Ragozzine. All rights reserved.
//
#import "NoteDetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface NoteDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleField;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) UIImagePickerController *pickerController;


@property (nonatomic) NSInteger index;
@property (nonatomic) NSString *noteTitle;
@property (nonatomic) NSString *content;
@property (nonatomic) NSString *date;
@property (nonatomic) UIImage *image;

@end

@implementation NoteDetailViewController

- (instancetype)initWithIndex:(NSInteger)index
                        title:(NSString *)title
                      content:(NSString *)content
                         date:(NSString *)date
                        image:(UIImage *)image{
    if (self = [super initWithNibName:@"NoteDetailViewController" bundle:nil]){
        self.index = index;
        self.noteTitle = title;
        self.content = content;
        self.date = date;
        self.image = image;
        
        self.pickerController = [[UIImagePickerController alloc] init];
        self.pickerController.allowsEditing = NO;
        self.pickerController.delegate = self;
        self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    return self;
}


-(void) viewDidLoad{
    [super viewDidLoad];
    self.title = self.date;
    self.titleField.text = self.noteTitle;
    self.imageView.image = self.image;
    self.textView.text = self.content;
    
    [[self.textView layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
     [[self.textView layer] setBorderWidth:.3];
     [[self.textView layer] setCornerRadius:15];
}

-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.
        [self.delegate noteDetailViewController:self
                             didFinishWithTitle:self.titleField.text
                              didFinishWithBody:self.textView.text
                             didFinishWithIndex:(self.index)
                             didFinishWithImage:self.image];
        
    }
    [super viewWillDisappear:animated];
}

-(IBAction)addPicturePressed:(id)sender{
    [self presentViewController:self.pickerController animated:YES completion:nil];
}
- (IBAction)deleteImagePressed:(id)sender
{
    self.image = nil;
    self.imageView.image = self.image;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    self.imageView.image = self.image;
}

- (IBAction)sendEmail:(id)sender
{
    //construct mail view controller; set subject and body
    self.mailComposer = nil;
    self.mailComposer = [[MFMailComposeViewController alloc] init];
    
    self.mailComposer.mailComposeDelegate = self;
    
    [self.mailComposer setSubject:self.noteTitle];
    [self.mailComposer setMessageBody:self.content isHTML:NO];
    
    NSData *imageData = UIImageJPEGRepresentation(self.image, 1);
    NSString *imageFileName= self.noteTitle;
    imageFileName = [imageFileName stringByAppendingString:@".jpg"];
    
    //attach note image
    [self.mailComposer addAttachmentData:imageData mimeType:@"image/jpeg" fileName:imageFileName];
    
    //view mail vc
    [self presentViewController:self.mailComposer animated:YES completion:nil];
    
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    // Dismiss mail vc
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end



