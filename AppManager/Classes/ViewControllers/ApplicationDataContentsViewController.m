//
//  ApplicationDataContentsViewController.m
//  AppManager
//
//  Created by userMacBookPro on 8/11/17.
//  Copyright © 2017 Sergio. All rights reserved.
//

#import "ApplicationDataContentsViewController.h"
#import "ItemsCountViewProto.h"
#import "ParameterCell.h"
#import "BundleData.h"
#import "FileData.h"
#import "DataParameter.h"

static NSString * const kParameterCell = @"ParameterCell";

@interface ApplicationDataContentsViewController () <UITableViewDelegate, UITableViewDataSource>

// XIB
@property (weak, nonatomic) IBOutlet ItemsCountViewProto   *itemsCountViewProto;
@property (weak, nonatomic) IBOutlet UITableView           *tableView;

// Internal
@property (nonatomic, strong) NSMutableArray<DataParameter *> *parameters;
@property (nonatomic, strong) FileData *fileData;

@end

@implementation ApplicationDataContentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINib *parametersCellNib = [UINib nibWithNibName:kParameterCell bundle:nil];
    [self.tableView registerNib:parametersCellNib forCellReuseIdentifier:kParameterCell];
    
    self.tableView.estimatedRowHeight = 400.;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    [self setupData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setter

- (void)setObject:(BundleData *)object {
    _object = object;
    [self setupData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1/*2*/;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fileData.content.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ParameterCell *cell = [tableView dequeueReusableCellWithIdentifier:kParameterCell];
    if (cell == nil) {
        cell = [[ParameterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kParameterCell];
    }
    
    cell.isEvenCell = indexPath.row % 2 == 0;
    cell.isSeparatorShown = NO;
    
    DataParameter *parameter;
//    if (indexPath.section == 0) {
//        cell.verticalPadding = kCellVerticalPaddingDefault;
//        cell.nameLabelIsBold = YES;
//        parameter = [self.parameters objectAtIndex:indexPath.row];
//    } else {
        cell.verticalPadding = kCellVerticalPaddingThin;
        FileData *fileData = [self.fileData.content objectAtIndex:indexPath.row];
        cell.nameLabelIsBold = [fileData isNameTheSameAsFolder];
        parameter =
            [[DataParameter alloc] initWithName:fileData.fullName.lastPathComponent value:[fileData permissionsShortDescUI]];
//    }
//    if ([cell conformsToProtocol:@protocol(ControlWithObjectDelegate)]) {
//        UITableViewCell<ControlWithObjectDelegate> *paramCell = (UITableViewCell<ControlWithObjectDelegate> *)cell;
        cell/*paramCell*/.object = parameter;
//    }
    
    return cell;
}

#pragma mark - Table view delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
        FileData *fileData = [self.fileData.content objectAtIndex:indexPath.row];
        DataParameter *parameter =
            [[DataParameter alloc] initWithName:fileData.fullName.lastPathComponent
                                          value:[fileData permissionsShortDesc]];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:parameter.name
                                                                       message:parameter.value
                                                                preferredStyle:UIAlertControllerStyleActionSheet
                                    ];
        [alert addAction:[UIAlertAction actionWithTitle:@"Copy to Pasteboard"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action)
                          {
                              [UIPasteboard generalPasteboard].string =
                                  [NSString stringWithFormat:@"%@: %@", parameter.name, parameter.value];
                          }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                  style:UIAlertActionStyleCancel
                                                handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - Private methods

- (void)setupData {
    if (_object) {
        self.fileData = [FileData fileDataWithFullName:[_object path:YES]];
        [self.fileData scanContentIfDirectory:NO];
        
        [self.tableView reloadData];
        self.itemsCountViewProto.itemsCount = self.fileData.content.count;
    }
}

@end
