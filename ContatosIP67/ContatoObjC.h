//
//  ContatoObjC.h
//  ContatosIP67
//
//  Created by ios7245 on 25/09/17.
//  Copyright © 2017 fcrespo82. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MKAnnotation.h>
#import <CoreData/CoreData.h>

@interface ContatoObjC : NSManagedObject <MKAnnotation>

@property (strong) NSString* nome;
@property (strong) NSString* telefone;
@property (strong) NSString* endereco;
@property (strong) NSString* site;
@property (strong) UIImage* image;
@property (strong) NSNumber* latitude;
@property (strong) NSNumber* longitude;

- (instancetype)initWithName:(NSString *)nome;

@end
