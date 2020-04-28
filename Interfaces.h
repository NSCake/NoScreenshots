//
//  Interfaces.h
//  FixPhotos
//
//  Created by Tanner Bennett on 2020-04-27
//  Copyright © 2020 Tanner Bennett. All rights reserved.
//

#pragma mark Imports

#import <Photos/Photos.h>
#import "../includes/FLEX.h"

#pragma mark Interfaces

@interface PUOneUpBarsController : NSObject
- (void)_handleTapGestureRecognizer:(id)gesture;
@end

@interface PUOneUpViewController : UIViewController
@property (readonly) PUOneUpBarsController *_barsController;
- (id)_currentAssetViewModel;
@end

@interface PXSelectionSnapshot : NSObject
- (NSArray<PHAsset *> *)fetchSelectedObjects;
@end

@interface PSSectionedSelectionManager : NSObject
@property (readonly) PXSelectionSnapshot *selectionSnapshot;
@end

@interface PXCuratedLibraryViewModel : NSObject
@property (readonly) PSSectionedSelectionManager *selectionManager;
@end

@interface PXCuratedLibraryViewProvider : NSObject
@property (readonly) PXCuratedLibraryViewModel *viewModel;
@end

// Asset hiding
@interface PUAssetHidingHelper : NSObject
@property (readonly) NSArray *assets;
- (void)applyHiddenState:(BOOL)hide completionHandler:(id)completion;
@end

// To get selected assets:
// [self.viewProvider.viewModel.selectionManager.selectionSnapshot fetchSelectedObjects]
@interface PXCuratedLibraryUIViewController : UIViewController
@property (readonly) PXCuratedLibraryViewProvider *viewProvider;
@end

#pragma mark Macros



#define Alert(TITLE,MSG) [[[UIAlertView alloc] initWithTitle:(TITLE) \
message:(MSG) \
delegate:nil \
cancelButtonTitle:@"OK" \
otherButtonTitles:nil] show];

#define UIAlertController(title, msg) [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:1]
#define UIAlertControllerAddAction(alert, title, stl, code...) [alert addAction:[UIAlertAction actionWithTitle:title style:stl handler:^(id action) code]];
#define UIAlertControllerAddCancel(alert) [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]
#define ShowAlertController(alert, from) [from presentViewController:alert animated:YES completion:nil];
