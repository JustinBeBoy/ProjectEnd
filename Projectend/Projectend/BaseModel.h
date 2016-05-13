//
//  BaseModel.h
//  MedisafeRD
//
//  Created by Exlinct on 1/27/16.
//  Copyright © 2016 Ominext. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DB.h"
#import "DBFieldName.h"
#import "FMDatabase.h"
#import <objc/message.h>

#define K_TABLE_PREFIX @"tb_"

@interface BaseModel : NSObject

#pragma mark - property
@property(strong)NSNumber *iId;
@property(strong)NSString *created;
@property(strong)NSString *modified;
@property(strong)NSNumber *deleted;

#pragma mark - setting db config
/** This function auto create table name by format: <prefix><table_name><s/es>
 *  Ex: PatientModel --> tb_patients
 OperatorInputModel --> tb_operator_inputs
 */
+(NSString*)tableName;

/**
 * This function get fields list
 */
+(NSArray*)getFieldsList;
+(NSArray*)getFieldOption;
+(NSArray*)uniqueFields;

#pragma mark - db location
+(NSString*)dbPath;

#pragma mark - init - convert
-(id)initWithDic:(NSDictionary*)dic;

/** MARK: set data from dictionary
 */
-(void)setData:(NSDictionary*)dic;
-(NSMutableDictionary *)convertToDictionary;

/** MARK: This function get/set value by key
 */
-(id)objectByKey:(NSString*)key;
-(void)setObject:(id)object byKey:(NSString*)key;

/** MARK: rename key
 * change this method if fields in db is different from property in model
 */
-(NSString*)trueKeyFromKey:(NSString*)key;

#pragma mark - query
/** This function select data from database
 */
+(NSMutableArray*)select:(NSArray *)projection from:(NSString *)from condition:(NSString *)condition param:(NSArray*)params db:(FMDatabase*)db;
+(NSMutableArray*)select:(NSArray *)projection from:(NSString *)from where:(NSString*)where db:(FMDatabase*)db;
/** select * from table where <where condition>
 @author ductc
 */
+(NSMutableArray*)selectWhere:(NSString*)where db:(FMDatabase*)db;
+(NSMutableArray*)selectWhere:(NSString*)where;
+(NSDictionary*)dicSelectOneWhere:(NSString*)where db:(FMDatabase*)db;

+(id)selectOneWhere:(NSString*)where db:(FMDatabase*)db;
+(NSMutableArray*)selectObjWhere:(NSString*)where db:(FMDatabase*)db;


/** MARK: Delete
 */

+(BOOL)deleteWhere:(NSString *)where;
+(BOOL)forceDeleteWhere:(NSString *)where db:(FMDatabase*)db;
-(BOOL)deleteObj;
/** MARK: This function update or insert into db
 */
-(BOOL)update:(FMDatabase*)db;
-(BOOL)update;



#pragma mark - create
/**
 * This function build create table query
 */
+(NSString*)createTableQuery;
/*
 * This function create table
 */
+(BOOL)createTable:(FMDatabase*)db;

#pragma mark - helper function
+(NSString*)selectQuery:(NSArray*)projection from:(NSString*)from condition:(NSString*)condition;


+(sqlite_int64)insert:(NSDictionary *)dic where:(NSString *)where;


@end
