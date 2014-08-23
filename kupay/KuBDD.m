//
//  KuBDD.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 09/11/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import "KuBDD.h"


@implementation KuBDD


-(id)init{
    
    self = [super init];
    if (self){
        

        }
  	return self;
}



-(BOOL)abrirBDDenPath:(NSString*)path{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path_ = [docsPath stringByAppendingPathComponent:path];
    self.db = [FMDatabase databaseWithPath:path_];
    [self.db open];
    return YES;
}
-(BOOL)cerrarBdd{
    [self.db close];
    return YES;
}

-(NSString*)obtenerDatoConKey:(NSString *)key deLaTabla:(NSString *)tabla{
    NSString *result = nil;
    
     FMResultSet *res = [self.db executeQuery:[NSString stringWithFormat:@"SELECT %@ FROM %@",key,tabla]];
    while ([res next]) {
        result = [res stringForColumn:key];
    }
    return result;
}

-(void)actualizarCampo:(NSString*)campo conDato:(NSString*)dato deLaTabla:(NSString*)tabla{
    [self.db executeUpdate:[NSString stringWithFormat: @"UPDATE %@ SET %@='%@'",tabla,campo,dato]];
}

@end
