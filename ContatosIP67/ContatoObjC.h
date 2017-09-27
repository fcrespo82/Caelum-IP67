//
//  ContatoObjC.h
//  ContatosIP67
//
//  Created by ios7245 on 25/09/17.
//  Copyright © 2017 fcrespo82. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ContatoObjC : NSObject

@property (strong) NSString* nome;
@property (strong) NSString* telefone;
@property (strong) NSString* endereco;
@property (strong) NSString* site;
@property (strong) UIImage* image;

- (instancetype)initWithName:(NSString *)nome;

@end
