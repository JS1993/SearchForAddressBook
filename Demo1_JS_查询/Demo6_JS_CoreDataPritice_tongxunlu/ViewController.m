//
//  ViewController.m
//  Demo6_JS_CoreDataPritice_tongxunlu
//
//  Created by  江苏 on 16/3/12.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Person+CoreDataProperties.h"
#import "AppDelegate.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nameTF;
@property (strong, nonatomic) IBOutlet UITextField *numTF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //判断一个界面同时可以做两件事，到底是那件事，可以通过一个判断来做
    if (self.editP) {
        self.nameTF.text=self.editP.name;
        self.numTF.text=self.editP.number;
        [self.muBtn setTitle:@"修改" forState:UIControlStateNormal];
    }else{
        [self.muBtn setTitle:@"保存" forState:UIControlStateNormal];
    }
}
- (IBAction)save:(UIButton *)sender {
     AppDelegate* app=[UIApplication sharedApplication].delegate;
    if (self.editP) {
        self.editP.name=self.nameTF.text;
        self.editP.number=self.numTF.text;
    [app saveContext];
    }else{
        Person* p=[NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:app.managedObjectContext];
        p.name=self.nameTF.text;
        p.number=self.numTF.text;
    }
    [app saveContext];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
