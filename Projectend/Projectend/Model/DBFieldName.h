//
//  DBFieldName.h
//  MedisafeRD
//
//  Created by Exlinct on 1/27/16.
//  Copyright © 2016 Ominext. All rights reserved.
//

#ifndef DBFieldName_h
#define DBFieldName_h

/**
 * MARK: field name
 */
static NSString *k_id                  = @"id";
static NSString *k_created             = @"created";
static NSString *k_modified            = @"modified";
static NSString *k_deleted             = @"deleted";

/**
 * MARK: field name of techer and student and ClassLish
 */
static NSString *const k_name          = @"name";
static NSString *const k_dateofbirth   = @"dateofbirth";
static NSString *const k_sex           = @"sex";
static NSString *const k_phone         = @"phone";
static NSString *const k_address       = @"address";
static NSString *const k_username      = @"username";
static NSString *const k_password      = @"password";
/*
 MARK: field name of score
 */
static NSString *const k_score          = @"score";
static NSString *const k_idsubject      = @"idsubject";
static NSString *const k_idstudent      = @"idstudent";

/** MARK: db constant
 */
/** Sqlite type const */
static NSString *const ksInteger       = @"INTEGER";
static NSString *const ksFloat         = @"FLOAT";
static NSString *const ksDefault       = @"DEFAULT";
static NSString *const ksPrimary       = @"PRIMARY";
static NSString *const ksKey           = @"KEY";
static NSString *const ksAutoInc       = @"AUTOINCREMENT";
static NSString *const ksVarchar       = @"VARCHAR";
static NSString *const ksText          = @"TEXT";
static NSString *const ksIntPrimaryInc = @"INTEGER PRIMARY KEY AUTOINCREMENT";

/**
 *  MARK: tb_Subject
 */
static NSString *const k_subject       = @"subject";
static NSString *const k_credits       = @"credits";
static NSString *const k_mail          = @"mail";
static NSString *const k_descriptions   = @"descriptions";
/**
 *  MARK: tb_student
 */
static NSString *const k_idclass       = @"idclass";


#endif /* DBFieldName_h */
