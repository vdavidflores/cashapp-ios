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

-(BOOL)abrirKuBDD{
    NSString *path = @"database.kupay";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path_ = [docsPath stringByAppendingPathComponent:path];
    self.db = [FMDatabase databaseWithPath:path_];
    [self.db open];
    return YES;
}

-(BOOL)Update:(NSString *)query{
    return [self.db executeUpdate:query];
}

-(BOOL)cerrarBdd{
    [self.db close];
    return YES;
}

-(NSInteger)cantidadDeEntradasEnTabla:(NSString *)tabla{
    
    FMResultSet *res = [self.db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@",tabla]];
    NSInteger n = 0;
    while ([res next]) {
        n++;
    }
    return n;
}

-(NSMutableArray*)obtenerColumna:(NSString *)key deLaTabla:(NSString *)tabla{
     NSLog(@"------|_____|------");
    FMResultSet *res = [self.db executeQuery:[NSString stringWithFormat:@"SELECT %@ FROM %@",key,tabla]];
    NSMutableArray * aray = [[NSMutableArray alloc] init];
    while ([res next]) {
        [aray addObject:[res stringForColumn:key]];
        NSLog(@"------||||------");
    }
    return aray;
}

-(NSString*)obtenerDatoConKey:(NSString *)key deLaTabla:(NSString *)tabla enLaPocicion:(int)posicion{
    NSString *result = nil;
    
    FMResultSet *res = [self.db executeQuery:[NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE id = %d",key,tabla,posicion]];
    while ([res next]) {
        result = [res stringForColumn:key];
    }
    return result;
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

-(void)actualizarCampo:(NSString *)campo conDato:(NSString *)dato enLaPocicion:(NSString *)posicion deLaTabla:(NSString *)tabla{
     [self.db executeUpdate:[NSString stringWithFormat: @"UPDATE %@ SET %@='%@' WHERE id='%@'",tabla,campo,dato,posicion]];
}

@end
