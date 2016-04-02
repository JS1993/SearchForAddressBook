//
//  TableViewController.m
//  Demo6_JS_CoreDataPritice_tongxunlu
//
//  Created by  江苏 on 16/3/12.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "Person+CoreDataProperties.h"
#import "Person.h"
#import "AppDelegate.h"
#import "ViewController.h"
@interface TableViewController ()
@property(strong,nonatomic)AppDelegate* app;
@property(nonatomic,strong)NSArray* persons;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.app=[UIApplication sharedApplication].delegate;
    self.navigationItem.rightBarButtonItem=self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    NSFetchRequest* fetR=[[NSFetchRequest alloc]initWithEntityName:@"Person"];
    //设置排序
    NSSortDescriptor* sort=[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [fetR setSortDescriptors:@[sort]];
    //设置查询条件 
//    [fetR setPredicate:[NSPredicate predicateWithFormat:@"name IN {'fff','t'}"]];
    self.persons=[self.app.managedObjectContext executeFetchRequest:fetR error:nil];
    return self.persons.count;
}
- (IBAction)cilcked:(UIButton*)sender {
    [self performSegueWithIdentifier:@"pvc" sender:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Person* person=self.persons[indexPath.row];
    cell.nameLabel.text=person.name;
    cell.numberLabel.text=person.number;    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        NSFetchRequest* fetR=[[NSFetchRequest alloc]initWithEntityName:@"Person"];
//        self.persons=[self.app.managedObjectContext executeFetchRequest:fetR error:nil];
        Person* p=self.persons[indexPath.row];
        [self.app.managedObjectContext deleteObject:p];
        [self.app saveContext];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Person *p = self.persons[indexPath.row];
    [self performSegueWithIdentifier:@"pvc" sender:p];
    
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    Person* p=self.persons[indexPath.row];
//    [self performSegueWithIdentifier:@"pvc" sender:p];
//}
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ViewController* vc=segue.destinationViewController;
    vc.editP=sender;
}

@end
