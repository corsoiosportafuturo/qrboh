/*
 * QRCodeReaderViewController
 *
 * Copyright 2014-present Yannick Loriot.
 * http://yannickloriot.com
 *
  *
 */

#import "ViewController.h"
#import "QRCodeReaderViewController.h"
#import "QRCodeReader.h"
#import <UIKit/UIKit.h>
#import "RisultatoCercaViewController.h"
#import <UIKit/UIKit.h>
#import "codici.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)scanAction:(id)sender
{
  if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]]) {
    static QRCodeReaderViewController *vc = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
      QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
      vc                   = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
      vc.modalPresentationStyle = UIModalPresentationFormSheet;
    });
    vc.delegate = self;

    [vc setCompletionWithBlock:^(NSString *resultAsString) {
      NSLog(@"Completion with result: %@", resultAsString);
    }];

    [self presentViewController:vc animated:YES completion:NULL];
  }
  else {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Reader not supported by the current device" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];

    [alert show];
  }
}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result

{
    NSLog(@"%@", result);
    RisultatoCercaViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"RisultatoCercaViewController"];
    vc.codice=result;
    
     [self.navigationController showViewController:vc sender:self];
    
  [reader stopScanning];

  [self dismissViewControllerAnimated:YES completion:^{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QRCodeReader" message:result delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
      
    [alert show];
  }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
  [self dismissViewControllerAnimated:YES completion:NULL];
    
    
}

@end
