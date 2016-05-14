//
//  BaseModel.m
//  MedisafeRD
//
//  Created by Exlinct on 1/27/16.
//  Copyright © 2016 Ominext. All rights reserved.
//

#import "BaseModel.h"
#import "Lib.h"

@implementation BaseModel

+ (NSString*)tableName {
    NSString *className = NSStringFromClass([self class]);
    NSLog(@"className = %@", className);
    
    className = [className stringByReplacingOccurrencesOfString:@"Model" withString:@""];
    
    NSError *err;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"([A-Z])" options:0  error:&err];
    if (err) {
        NSLog(@"Error regular expression");
        return nil;
    }
    NSString *name = [regex stringByReplacingMatchesInString:className options:NSMatchingReportCompletion range:NSMakeRange(1, className.length-1) withTemplate:@"_$0"];
    name = [name lowercaseString];
    name = [K_TABLE_PREFIX stringByAppendingString:name];
    
    if ([[name substringFromIndex:name.length-1] isEqualToString:@"s"]) {
        name = [name stringByAppendingString:@"es"];
    }else{
        name = [name stringByAppendingString:@"s"];
    }
    
    NSLog(@"table name = %@", name);
    return name;
}

+ (NSArray*)getFieldsList {
    NSLog(@"Overite this method %s", __func__);
    return nil;
}

+ (NSArray*)getFieldOption {
    NSLog(@"Overite this method %s", __func__);
    return nil;
}

+ (NSArray*)uniqueFields {
    NSLog(@"Overite this method %s", __func__);
    return nil;
}

#pragma mark - db location
+ (NSString*)dbPath {
    return [DB dbPath];
}

#pragma mark - init - convert
-(id)initWithDic:(NSDictionary*)dic
{
    if (self = [super init]) {
        _deleted = @(0);
        _iId = @(0);
        [self setData:dic];
    }
    return self;
}
-(id)init{
    return [self initWithDic:nil];
}

/** MARK: set data from dictionary
 */
-(void)setData:(NSDictionary*)dic
{
    for (NSString *key in [dic allKeys]) {
        id obj = [dic objectForKey:key];
        [self setObject:obj byKey:key];
    }
}

-(NSMutableDictionary *)convertToDictionary
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSArray *allField = [[self class] getFieldsList];
    for (NSString *key in allField) {
        [self setObj:[self objectByKey:key] forKey:key dictionary:dic];
    }
    return dic;
}

-(NSString*)trueKeyFromKey:(NSString*)key
{
    return nil;
}
/** MARK: This function get value by key
 */
-(id)objectByKey:(NSString*)key
{
    if ([key isEqualToString:k_id]) {
        key = @"iId";
    }
    NSString *trueKey = [self trueKeyFromKey:key];
    if (trueKey) {
        key = trueKey;
    }
    if (!class_getProperty([self class], [key UTF8String])) {
        NSLog(@"No property %@ for class %@", key, [self class]);
        return nil;
    }
    return [self valueForKey:key];
}
-(void)setObject:(id)object byKey:(NSString*)key
{
    if ([key isEqualToString:k_id]) {
        key = @"iId";
    }
    NSString *trueKey = [self trueKeyFromKey:key];
    if (trueKey) {
        key = trueKey;
    }
    if ([object isKindOfClass:[NSNull class]]) {
        object = nil;
    }
    if (!class_getProperty([self class], [key UTF8String])) {
        NSLog(@"No property %@ for class %@", key, [self class]);
        return;
    }
    [self setValue:object?:@"" forKey:key];
}

#pragma mark - query
/**
 * This function build create table query
 */
+(NSString*)createTableQuery
{
    NSArray *fields = [self getFieldsList];
    NSArray *fieldOption = [self getFieldOption];
    NSString *tableName = [self tableName];
    NSArray *uniqueFields = [self uniqueFields];
    
    if (fields.count != fieldOption.count) {
        NSLog(@"Setting error for %@", tableName);
        return nil;
    }
    NSMutableString *query = [NSMutableString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@", tableName];
    [query appendString:@"("];
    
    for (int i=0; i<fields.count; i++) {
        NSString *field = [fields objectAtIndex:i];
        [query appendString:field];
        id type = [fieldOption objectAtIndex:i];
        [query appendString:@" "];
        if ([type isKindOfClass:[NSString class]]) {
            [query appendString:type];
        }else if ([type isKindOfClass:[NSArray class]]){
            NSString *option = [(NSArray*)type componentsJoinedByString:@" "];
            [query appendString:@" "];
            [query appendString:option];
        }else{
            NSLog(@"Error query");
            return nil;
        }
        if (i==fields.count-1) {
            //[query appendString:@")"];
        }else{
            [query appendString:@","];
        }
    }
    if (uniqueFields.count>0) {
        [query appendString:@", unique("];
        [query appendString:[uniqueFields componentsJoinedByString:@","]];
        [query appendString:@") on conflict REPLACE "];
    }
    [query appendString:@")"];
    NSLog(@"query = %@", query);
    return query;
}


/** This function select data from database
 */
+(NSMutableArray*)select:(NSArray *)projection from:(NSString *)from condition:(NSString *)condition param:(NSArray*)params db:(FMDatabase*)db
{
    NSString *query = [self selectQuery:projection from: from condition:condition];
    NSLog(@"Select query %@ param %@", query, params);
    BOOL isCreateDB = NO;
    if (!db) {
        db = [FMDatabase databaseWithPath:[self dbPath]];
        [db open];
        isCreateDB = YES;
    }
    
    FMResultSet *result = [db executeQuery:query withArgumentsInArray:params];
    
    NSMutableArray *arr = [NSMutableArray array];
    while ([result next]) {
        NSDictionary *dic = [result resultDictionary];
        if (dic) {
            [arr addObject:dic];
        }
    }
    //NSLog(@"Num obj = %lu from %@", (unsigned long)arr.count, [self tableName]);
    if (isCreateDB) {
        [db close];
    }
    return arr;
}
+(NSMutableArray*)select:(NSArray *)projection from:(NSString *)from where:(NSString*)where db:(FMDatabase*)db

{
    if (where) {
        return [self select:projection from:from condition:[NSString stringWithFormat:@" WHERE %@", where] param:nil db:db];
    }
    return [self select:projection from:from condition:nil param:nil db:db];
}

+(NSMutableArray*)selectWhere:(NSString *)where db:(FMDatabase *)db
{
    return [self select:nil from:nil where:where db:db];
}
+(NSMutableArray*)selectWhere:(NSString *)where
{
    FMDatabase *db = [DB db];
    [db open];
    NSMutableArray *arr = [self selectWhere:where db:db];
    [db close];
    return arr;
}
+(NSDictionary*)dicSelectOneWhere:(NSString*)where db:(FMDatabase*)db
{
    NSArray *objs = [self selectWhere:where db:db];
    if (objs.count <=0) {
        return nil;
    }
    return [objs objectAtIndex:0];
}
+(id)selectOneWhere:(NSString*)where db:(FMDatabase*)db
{
    NSArray *objs = [self selectWhere:where db:db];
    if (objs.count <=0) {
        return nil;
    }
    id obj = [[self alloc] initWithDic:[objs objectAtIndex:0]];
    return obj;
}

+(NSMutableArray*)selectObjWhere:(NSString*)where db:(FMDatabase*)db
{
    NSMutableArray *arr = [self select:nil from:nil where:where db:db];
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
        [result addObject:[[[self class] alloc] initWithDic:dic]];
    }
    return result;
}

#pragma mark - delete
+(BOOL)deleteWhere:(NSString *)where db:(FMDatabase*)db
{
    NSString *query = [NSString stringWithFormat:@"UPDATE %@ SET deleted ='1' WHERE %@", [self tableName], where];
    NSLog(@"Delete query = %@", query);
    return [db executeUpdate:query];
}

+(BOOL)deleteWhere:(NSString *)where {
    FMDatabase *db = [DB db];
    [db open];
    BOOL check = [self deleteWhere:where];
    [db close];
    
    return check;
}

-(BOOL)deleteObj:(FMDatabase*)db
{
    return [[self class] deleteWhere:[NSString stringWithFormat:@"%@=%@", k_id, _iId] db:db];
}

-(BOOL)deleteObj {
    FMDatabase *db = [DB db];
    [db open];
    BOOL check = [self deleteObj:db];
    [db close];
    
    return check;
}

+(BOOL)forceDeleteWhere:(NSString *)where db:(FMDatabase *)db
{
    NSString *query = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@", [self tableName], where];
    NSLog(@"Delete query = %@", query);
    return [db executeUpdate:query];
}

/** MARK: This function update or insert into db
 */
-(BOOL)update:(FMDatabase*)db
{
    NSMutableDictionary *dic = [self convertToDictionary];
    NSString *current = [Lib currentDate];
    dic[k_modified]= current;
    self.modified = current;
    
    if ([_iId intValue]>0) {
        return [[self class] update:dic where:[NSString stringWithFormat:@"%@=?",k_id] params:@[_iId] db:db];
    }else{
        dic[k_created] = current;
        self.created = current;
        
        [dic removeObjectForKey:k_id];
        sqlite_int64 row = [[self class] insert:dic where:nil];
        if (row>0) {
            self.iId = @(row);
            return YES;
        }else if (row<0){
            NSLog(@"Insert error %@", dic);
            return NO;
        }
        return YES;
    }
}
-(BOOL)update
{
    FMDatabase *db = [DB db];
    [db open];
    BOOL value = [self update:db];
    [db close];
    return value;
}

#pragma mark - update and insert function
+(BOOL)update:(NSDictionary *)dic where:(NSString *)where params:(NSArray *)params db:(FMDatabase *)db
{
    NSMutableArray *listField =[NSMutableArray arrayWithCapacity:dic.count];
    NSMutableArray *listValue = [NSMutableArray arrayWithCapacity:dic.count];
    NSArray *fields = [[self class] getFieldsList];
    NSString *tableName = [self tableName];
    for (NSString *key in fields) {
        id value = dic[key];
        if (value) {
            [listField addObject:key];
            [listValue addObject:value];
        }
    }
    if (listField.count<=0) {
        return NO;
    }
    
    //update table_name
    NSMutableString *query = [NSMutableString stringWithString:@"UPDATE "];
    [query appendString:tableName];
    
    //  set a=?,b=?
    [query appendString:@" SET "];
    for (int i=0; i<listField.count-1; i++) {
        [query appendFormat:@"`%@`=?,", listField[i]];
    }
    [query appendFormat:@"`%@`=? ", [listField lastObject]];
    
    // WHERE a=? AND b=?
    if (where) {
        [query appendString:@" WHERE "];
        [query appendString:where];
        [listValue addObjectsFromArray:params];
    }
    
    NSLog(@"Query update %@, value %@", query, listValue);
    return [db executeUpdate:query withArgumentsInArray:listValue];
}
+(sqlite_int64)insert:(NSDictionary *)dic where:(NSString *)where
{
    NSMutableArray *listField =[NSMutableArray arrayWithCapacity:dic.count];
    NSMutableArray *listValue = [NSMutableArray arrayWithCapacity:dic.count];
    NSArray *fields = [[self class] getFieldsList];
    NSString *tableName = [self tableName];
    
    for (NSString *key in fields) {
        id value = dic[key];
        if (value) {
            [listField addObject:key];
            [listValue addObject:value];
        }
    }
    if (listField.count<=0) {
        return -1;
    }
    FMDatabase *db = [FMDatabase databaseWithPath:[DB dbPath]];
    [db open];
    
    NSMutableString *query = [NSMutableString stringWithString:@"INSERT INTO "];
    [query appendString:tableName];
    [query appendString:@"("];
    NSString *set = [listField componentsJoinedByString:@","];
    [query appendString:set];
    [query appendString:@") VALUES("];
    
    for (int i=0; i<listField.count-1; i++) {
        [query appendString:@"?,"];
    }
    [query appendString:@"?)"];
    BOOL success = [db executeUpdate:query withArgumentsInArray:listValue];
    if (success) {
        return [db lastInsertRowId];
    }else{
        return -1;
    }
}

#pragma mark - create table
+(BOOL)createTable:(FMDatabase*)db
{
    NSString *createquery = [self createTableQuery];
    return [db executeUpdate:createquery];
}

#pragma mark - helper function
+(NSString*)selectQuery:(NSArray*)projection from:(NSString*)from condition:(NSString*)condition
{
    NSString *tableName = [self tableName];
    
    NSMutableString *query;
    if (projection.count<=0) {
        query = [NSMutableString stringWithString:@"SELECT * "];
    }else{
        query = [NSMutableString stringWithString:@"SELECT "];
        NSString *set = [projection componentsJoinedByString:@","];
        [query appendString:set];
        [query appendString:@" "];
    }
    [query appendString:@"FROM"];
    if (from) {
        [query appendString:@" "];
        [query appendString:from];
    }else{
        [query appendString:@" "];
        [query appendString:tableName];
    }
    if (condition) {
        [query appendString:@" "];
        [query appendString:condition];
    }
        NSLog(@"Select Query= %@", query);
    return query;
}

/** This function set object for key to a dictionary
 */
-(void)setObj:(id)obj forKey:(NSString*)key dictionary:(NSMutableDictionary*)dic
{
    if (obj) {
        [dic setObject:obj forKey:key];
    }else{
        [dic setObject:[NSNull null] forKey:key];
    }
}

@end
