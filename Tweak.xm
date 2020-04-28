//
//  Tweak.xm
//  NoScreenshots
//
//  Created by Tanner Bennett on 2020-04-27
//  Copyright © 2020 Tanner Bennett. All rights reserved.
//

#import "Interfaces.h"

#define PHAssetCollectionSubtypeAllPhotosTab 1000000205
#define PHAssetMediaSubtypeVideoScreenRecording 0x80000

/// Hide bars in theater on appear ///

%hook PUOneUpViewController
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    [self._barsController _handleTapGestureRecognizer:nil];
}
%end

/// Hide screenshots and screen recordings ///

#define PHCollectionShouldFilter(collection) ( \
    collection.assetCollectionSubtype == PHAssetCollectionSubtypeAllPhotosTab \
)

void PHHookFetch(SEL _cmd, PHAssetCollection *assetCollection, PHFetchOptions *options) {
    if (PHCollectionShouldFilter(assetCollection)) {
        // Build predicate to exclude screenshots and screen recordings
        NSPredicate *filterSmartTypes = [NSPredicate predicateWithFormat:
            @"(NOT ((mediaSubtypes & %d) != 0)) AND (NOT ((mediaSubtypes & %d) != 0))",
            PHAssetMediaSubtypePhotoScreenshot, PHAssetMediaSubtypeVideoScreenRecording
        ];

        options.predicate = filterSmartTypes;

        // AND our predicate with any existing predicate
        // options.predicate = !options.predicate ? filterSmartTypes : [NSCompoundPredicate
        //     andPredicateWithSubpredicates:@[options.predicate, filterSmartTypes]
        // ];
    }
}

%hook PHAsset
+ (PHFetchResult<PHAsset *> *)fetchAssetsInAssetCollection:(PHAssetCollection *)assetCollection
                                                   options:(PHFetchOptions *)options {
    PHHookFetch(_cmd, assetCollection, options);
    return %orig;
}

+ (PHFetchResult<PHAsset *> *)fetchKeyAssetsInAssetCollection:(PHAssetCollection *)assetCollection
                                                      options:(PHFetchOptions *)options {
    PHHookFetch(_cmd, assetCollection, options);
    return %orig;
}
%end

/// Make album grids 4 wide ///

%hook PUSectionedGridLayout
- (NSInteger)columnsPerRow {
    return 4;
}

- (NSInteger)numberOfColumnsForWidth:(CGFloat)width {
    return %orig + 1;
}
%end

%hook PXLayoutMetricInterpolator
+ (CGSize)bestItemSizeForAvailableWidth:(CGFloat)width screenScale:(CGFloat)scale
columns:(NSUInteger)numColumns bestSpacing:(CGFloat *)spacing bestInset:(CGFloat *)inset {
    numColumns++;
    return %orig;
}
%end
