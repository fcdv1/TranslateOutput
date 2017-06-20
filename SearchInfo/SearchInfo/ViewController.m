//
//  ViewController.m
//  SearchInfo
//
//  Created by CIA on 2017/6/20.
//  Copyright © 2017年 CIA. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSMutableArray *allMessages = [NSMutableArray new];
    NSString *homePath = @"/Users/CIA/Desktop/来啊重构/未命名文件夹/LivallRiding/LivallRiding";
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:homePath];
    NSString *path;
    while ((path = [dirEnum nextObject]) != nil)
    {
        if ([path containsString:@".m"] || [path containsString:@".h"]) {
            //获取文件内容
            NSString *filePath = [NSString stringWithFormat:@"/Users/CIA/Desktop/来啊重构/未命名文件夹/LivallRiding/LivallRiding/%@",path];
            NSString *text = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
            //检索里面的内容
            NSArray *messages = [text componentsSeparatedByString:@"LRLocalizedString"];
            for (NSString *info in messages) {
                if ([info hasPrefix:@"(@\""] && info.length > 3) {
                    NSRange range = [info rangeOfString:@"\","];
                    if (range.location != NSNotFound) {
                        NSString *subInfo = [info substringWithRange:NSMakeRange(3, range.location -3)];
                        if (![allMessages containsObject:subInfo]) {
                            [allMessages addObject:subInfo];
                        }
                    }
                }
            }
        }
    }
    
    //写成Txt
    NSString *filePath = @"/Users/CIA/Desktop/translate.txt";
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    NSFileHandle *handdle = [NSFileHandle fileHandleForWritingAtPath:@"/Users/CIA/Desktop/translate.txt"];
    for (NSString *info in allMessages) {
        NSString *text = [info stringByAppendingString:@"\n"];
        [handdle writeData:[text dataUsingEncoding:NSUTF8StringEncoding]];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
