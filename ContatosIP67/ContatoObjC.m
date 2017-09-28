//
//  ContatoObjC.m
//  ContatosIP67
//
//  Created by ios7245 on 25/09/17.
//  Copyright © 2017 fcrespo82. All rights reserved.
//

#import "ContatoObjC.h"

@implementation ContatoObjC

@dynamic nome, endereco, telefone, site, latitude, longitude, image;

- (NSString*) description {
    return [NSString stringWithFormat:@"Contato(nome=%@, telefone=%@, endereco=%@, site=%@)", self.nome, self.telefone, self.endereco, self.site];
}

- (instancetype)initWithName:(NSString *)nome
{
    self = [super init];
    if (self) {
        self.nome = nome;
    }
    return self;
}

- (CLLocationCoordinate2D) coordinate {
    return CLLocationCoordinate2DMake(self.latitude.doubleValue, self.longitude.doubleValue);
}

- (NSString *) title {
    return self.nome;
}

- (NSString *) subtitle {
    return self.endereco;
}

@end
