//
//  ApplicationDataGeneralViewController.m
//  AppManager
//
//  Created by userMacBookPro on 8/3/17.
//  Copyright © 2017 Sergio. All rights reserved.
//

#import "ApplicationDataGeneralViewController.h"
#import "ParameterCell.h"
#import "ApplicationData.h"
#import "BundleData.h"
#import "LSApplicationProxy.h"
#import "DataParameter.h"
#import "FileData.h"
#import "Device.h"

static NSString * const kParameterCell = @"ParameterCell";

@interface ApplicationDataGeneralViewController ()

// XIB
//@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
//@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
//@property (weak, nonatomic) IBOutlet UILabel *pathLabel;
//@property (weak, nonatomic) IBOutlet UILabel *vendorLabel;
//@property (weak, nonatomic) IBOutlet UILabel *identifierLabel;
//@property (weak, nonatomic) IBOutlet UILabel *permisionsLabel;

// Internal
@property (nonatomic, strong) NSMutableArray<DataParameter *> *parameters;
@property (nonatomic, strong) FileData *fileData;

@end

@implementation ApplicationDataGeneralViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *parametersCellNib = [UINib nibWithNibName:kParameterCell bundle:nil];
    [self.tableView registerNib:parametersCellNib forCellReuseIdentifier:kParameterCell];
    
    self.tableView.estimatedRowHeight = 400.;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self setupData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setter

- (void)setObject:(ApplicationData *)object {
    _object = object;
    [self setupData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1/*2*/;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return /*section == 0 ? */self.parameters.count/* : self.fileData.content.count*/;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ParameterCell *cell = [tableView dequeueReusableCellWithIdentifier:kParameterCell];
    if (cell == nil) {
        cell = [[ParameterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kParameterCell];
    }
    
//    cell.isEvenCell = indexPath.row % 2 == 0;
    
    DataParameter *parameter;
//    if (indexPath.section == 0) {
        cell.verticalPadding = kCellVerticalPaddingDefault;
        cell.nameLabelIsBold = YES;
        parameter = [self.parameters objectAtIndex:indexPath.row];
//    } else {
//        cell.verticalPadding = kCellVerticalPaddingThin;
//        FileData *fileData = [self.fileData.content objectAtIndex:indexPath.row];
//        cell.nameLabelIsBold = [fileData isNameTheSameAsFolder];
//        parameter =
//        [[DataParameter alloc] initWithName:fileData.fullName.lastPathComponent value:[fileData permissionsShortDescUI]];
//    }
//    if ([cell conformsToProtocol:@protocol(ControlWithObjectDelegate)]) {
//        UITableViewCell<ControlWithObjectDelegate> *paramCell = (UITableViewCell<ControlWithObjectDelegate> *)cell;
    cell/*paramCell*/.object = parameter;
//    }
    
    return cell;
}

#pragma mark - Table view delegate methods

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return section == 0 ? @"" : [NSString stringWithFormat:@"Content (%zd)", self.fileData.content.count];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return section == 0 ? 0 : 64;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 100;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    CGFloat height = 0;
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    if (cell) {
//        CGSize size = [cell systemLayoutSizeFittingSize:CGSizeMake(tableView.bounds.size.width, 1) withHorizontalFittingPriority:1000 verticalFittingPriority:1];
////        CGSize cellSize = [cell systemLayoutSizeFittingSize:CGSizeMake(tableView.bounds.size.width, 1)];
//        height = size.height;
//    } else {
//        height = [super tableView:tableView heightForRowAtIndexPath:indexPath];
//    }
//    return height;
    return /*indexPath.section == 0 ? */UITableViewAutomaticDimension/* : 30.*/;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
        DataParameter *parameter = [self.parameters objectAtIndex:indexPath.row];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Private methods

- (void)setupData {
    if (!self.parameters) {
        self.parameters = [NSMutableArray new];
    } else {
        [self.parameters removeAllObjects];
    }
    
    if (self.object) {
//        [self addParameterWithName:@"Name"       value:self.object.name      ];
        [self addParameterWithName:@"Item Name"  value:self.object.proxy.itemName                ];
        [self addParameterWithName:@"Version"    value:self.object.proxy.shortVersionString      ];
        [self addParameterWithName:@"Type"       value:self.object.proxy.applicationType         ];
        [self addParameterWithName:@"Path"       value:[self.object.bundleData containerPath:YES]];
        [self addParameterWithName:@"File"       value:[self.object.bundleData fileName]         ];
        [self addParameterWithName:@"Vendor"     value:self.object.proxy.vendorName              ];
        [self addParameterWithName:@"Identifier" value:self.object.proxy.applicationIdentifier   ];
    
//        self.itemNameLabel.text   = self.object.itemName;
//        self.versionLabel.text    = self.object.version;
//        self.typeLabel.text       = self.object.type;
//        self.pathLabel.text       = self.object.path;
//        self.vendorLabel.text     = self.object.vendor;
//        self.identifierLabel.text = self.object.identifier;
    
        self.fileData = [FileData fileDataWithFullName:[self.object.bundleData path:YES]];
        [self addParameterWithName:@"Permissions" value:[self.fileData permissionsShortDescUI]];
//    self.permisionsLabel.text = [self.fileData permissionsShortDescUI];
    }
}

- (void)addParameterWithName:(NSString *)name value:(id)value {
    DataParameter *parameter = [[DataParameter alloc] initWithName:name value:value ?: @""];
    if (parameter) {
        [self.parameters addObject:parameter];
    }
}

@end
