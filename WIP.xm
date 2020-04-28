//
//  WIP.xm
//  FixPhotos
//  
//  Created by Tanner Bennett on 2020-05-02
//  Copyright © 2020 Tanner Bennett. All rights reserved.
//

/// Add buttons to the selection toolbar / remove action confirmations ///

// %hook PUPhotoKitDestructiveActionsPerformer
// - (BOOL)shouldConfirmDestructiveAction {
//     return NO;
// }
// %end

%hook PXPhotoKitAssetActionPerformer
- (BOOL)shouldSkipUserConfirmation {
    return YES;
}
%end

// %hook PUAssetHidingHelper
// - (id)alertControllerForTogglingAssetsVisibilityWithCompletionHandler:(void(^)(BOOL hidden))handler {
//     [self applyHiddenState:YES completionHandler:^(NSInteger a, NSInteger b) {
//         handler(YES);
//     }];

//     return nil;
// }
// %end

// %hook PUPXPhotoKitDeleteAssetActionPerformer
// + (UIBarButtonItem *)createBarButtonItemWithTarget:(id)target action:(SEL)action {

// }
// %end

// // Add: PXAssetActionTypeHide PXAssetActionTypeDelete
// %hook PXPhotoKitAssetActionManager
// - (UIBarButtonItem *)barButtonItemForActionType:(NSString *)type
// - (void)_handleBarButtonItem:(UIBarButtonItem *)item {

// }

// - (void)executeActionForActionType:(NSString *)type withCompletionHandler:(id)completion {

// }
// %end
