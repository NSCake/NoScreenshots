//
//  FLEX.xm
//  FixPhotos
//  
//  Created by Tanner Bennett on 2020-04-29
//  Copyright © 2020 Tanner Bennett. All rights reserved.
//

#import "Interfaces.h"

%hook PUOneUpViewController
%property (nonatomic, strong, readonly) PHAsset *asset;

- (PHAsset *)asset {
    return (id)[[self _currentAssetViewModel] asset];
}

%end

%ctor {
    dispatch_async(dispatch_get_main_queue(), ^{
        [%c(FLEXShortcutsFactory)prepend].properties(@[@"asset"]).forClass(%c(PUOneUpViewController));
        [%c(FLEXShortcutsFactory)prepend].properties(@[@"mediaType", @"mediaSubtypes"]).forClass(%c(PHAsset));
    });
}
