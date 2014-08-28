//
//  KuBDD.h
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 09/11/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@interface KuBDD : NSObject
@property (nonatomic, retain) FMDatabase *db;

-(BOOL)abrirBDDenPath:(NSString*)path;
-(BOOL)cerrarBdd;
-(NSString*)obtenerDatoConKey:(NSString *)key deLaTabla:(NSString*)tabla;
-(void)actualizarCampo:(NSString*)campo conDato:(NSString*)dato deLaTabla:(NSString*)tabla;
-(void)actualizarCampo:(NSString*)campo conDato:(NSString*)dato enLaPocicion:(NSString *)posicion deLaTabla:(NSString*)tabla;
-(BOOL)abrirKuBDD;
-(BOOL)Update:(NSString *)query;
-(NSMutableArray*)obtenerColumna:(NSString *)key deLaTabla:(NSString *)tabla;
-(NSInteger)cantidadDeEntradasEnTabla:(NSString *)tabla;
-(NSString*)obtenerDatoConKey:(NSString *)key deLaTabla:(NSString *)tabla enLaPocicion:(int)posicion;
@end
