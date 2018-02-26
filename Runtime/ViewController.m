//
//  ViewController.m
//  Runtime
//
//  Created by 雨停 on 2017/9/18.
//  Copyright © 2017年 Video. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "UIGestureRecognizer+Block.h"
#import "Person+Addsex.h"
#import "Model.h"
#import "modelcode.h"
#import "actionAdd.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    //new分支 
    [super viewDidLoad];
    [self addGestureRecognizer];
    [self addshuxin];
    [self dicChangeToModel];
    }

//block直接调用手势的action
-(void)addGestureRecognizer{
    UIImageView * a   = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    a.userInteractionEnabled = YES;
    [self.view addSubview:a];
    a.backgroundColor = [UIColor redColor];
    [a addGestureRecognizer:[UITapGestureRecognizer getureRecognizerWithActionBlock:^(id gestureRecognizer) {
        NSLog(@"12321321321");
    }]];
    
    UIView *viewM = [[UIView alloc]initWithFrame:CGRectMake(60, 60, 60, 60)];
    viewM.backgroundColor = [UIColor grayColor];
    [self.view addSubview:viewM];
    [viewM addGestureRecognizer:[UITapGestureRecognizer getureRecognizerWithActionBlock:^(id gestureRecognizer) {
        NSLog(@"viewM点击事件-------");
        
    }]];

    
}

//分类添加属性
-(void)addshuxin{
    Person * p = [[Person alloc]init];
    p.name =@"name";
    p.age =10;
    p.sex =@"man";
    p.soccer =100;
    NSLog(@"name==%@\nage===%d\nsex====%@\nsoccer====%d",p.name,p.age,p.sex,p.soccer);
}
//方法实现的交换
-(void)exchangeAction{
    UIImageView *subview = [[UIImageView alloc] initWithFrame:
                            CGRectMake(160.0f, 160.0f, 60.0, 60.0f)];
    //实际图片的名字变化
    [subview setImage:[UIImage imageNamed:@"img"]];
    [self.view addSubview:subview];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//字典转模型

-(void)dicChangeToModel{
    NSDictionary *dic = @{@"name":@"我是名字",
                          @"sex":@"男",
                          @"age":@25
                          };
    Model *model = [Model modelWithDic:dic];
    NSLog(@"name:%@\n  sex:%@\n age:%@,",model.name,model.sex,model.age);

}

// 获取所有的属性(包括私有的)
-(void)getAllIval{
    unsigned int count =0;
    //Ivar：定义对象的实例变量，包括类型和名字。
    //获取所有的属性(包括私有的)
    Ivar  * ivars = class_copyIvarList([UIViewController class], &count);
    for (int i = 0; i<count; i++) {
        Ivar ivar = ivars[i];
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        NSLog(@"属性 --> %@ 和 %@",name,type);
 
    }
}

//获取所有的方法(包括私有的)
-(void)getAllMethod{
    unsigned    int count  =0;
     //获取所有的方法(包括私有的)
    Method *memberFuncs = class_copyMethodList([UIViewController class], &count);
    for (int i=0 ; i<count ;i++){
        SEL address = method_getName(memberFuncs[i]);
        NSString *methodName = [NSString stringWithCString:sel_getName(address) encoding:NSUTF8StringEncoding];
        
        NSLog(@"方法 : %@",methodName);
        
    }
}
//对私有变量的更改
- (void)changePrivate {
    Person *onePerson = [[Person alloc] init];
    NSLog(@"Person属性 == %@",[onePerson description]);
    
    unsigned  int count = 0;
    Ivar *members = class_copyIvarList([Person class], &count);
    
    for (int i = 0; i < count; i++){
        Ivar var = members[i];
        const char *memberAddress = ivar_getName(var);
        const char *memberType = ivar_getTypeEncoding(var);
        NSLog(@"获取所有属性 = %s ; type = %s",memberAddress,memberType);
    }
    //对私有变量的更改
    Ivar m_address = members[1];
    object_setIvar(onePerson, m_address, @"上海");
    NSLog(@"对私有变量的(地址)进行更改 : %@",[onePerson description]);
    
}
//归档解档
-(void)coder{
    modelcode *model = [[modelcode alloc] init];
    model.age = 12;
    model.name1 = @"123";
    model.name2 = @"123";
    model.name3 = @"123";
    
    //创建路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)lastObject];
    NSLog(@"documents路径：%@",documentPath);
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"MMModel.data"];
    
    //存储用户信息,归档
    
    BOOL result = [NSKeyedArchiver archiveRootObject:model toFile:filePath];
    
    if (result) {
        NSLog(@"归档成功:%@",filePath);
    }else{
        NSLog(@"归档失败");
    }
    
    modelcode *mm = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"%ld",(long)mm.age);
    NSLog(@"%@",mm.name1);
    NSLog(@"%@",mm.name2);
    

}
// 动态添加方法

-(void)addAction{
    actionAdd *add = [[actionAdd alloc] init];
    
    // 默认dog，没有实现eat方法，可以通过performSelector调用，但是会报错。
    // 动态添加方法就不会报错
    [add  performSelector:@selector(eat)];

}
@end
