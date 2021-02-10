//
//  NSDictionary+HTKeyValue.h
//  libcocos2d Mac
//
//  Created by 伟东 on 2020/7/21.
//

#import <Foundation/Foundation.h>

/*!
 *  字典类的扩展方法
 */
@interface NSDictionary (HTUtilities)

/*!
 *  将所对应的key和value添加到字典中，生成并返回一个NSDictionary对象
 *
 *  @param value 需要设置的对象
 *  @param key   需要设置的键值
 *
 *  @return 返回包含key和value的新字典
 */
- (NSDictionary *_Nullable)ht_dictionaryBySettingObject:(id)value forKey:(id<NSCopying>)key;

/*!
 *  生成并返回一个合并了当前字典和指定字典的key和value的NSDictionary对象
 *
 *  @param dictionary 需要合并的字典
 *
 *  @return 合并后的字典
 */
- (NSDictionary *)ht_dictionaryByAddingEntriesFromDictionary:(NSDictionary *)dictionary;

/**
 *  返回一个新的字典，根据当前字典生成，但移除了其中值为 NSNull 的键
 *
 *  @note 嵌套字典中的 NSNull 也会被移除，但嵌套数组中的暂时不会
 *
 *  @return 新的字典
 */
- (NSDictionary *)ht_dictionaryByRemovingNullValues;

@end

/*!
 *  主要功能是给当前字典对象添加新值并添加相应的判空处理.
 */
@interface NSMutableDictionary (YXTSetValue)

/**
 从当前字段中删除键值对

 @param aKey 需要删除的键值
 */
- (void)ht_removeObjectForKey:(nullable id)aKey;

/*!
 *  向当前字典中添加非空键值对
 *
 *  @param obj 需要设置的对象
 *  @param key 需要设置的键值
 */
- (void)ht_setSafeObject:(id _Nullable )obj forKey:(id<NSCopying>_Nullable)key;

/*!
 * 向当前字典中添加非空键值对
 * @param obj 需要设置的对象
 * @param key 需要设置的键值
 * @param defaultObj 需要设置的默认数据
 */
- (void)ht_setSafeObject:(id _Nullable )obj forKey:(id<NSCopying>_Nullable)key defaultObj:(id _Nullable )defaultObj;;

@end

/*!
 * 该类主要是用于当前字典对象与文件路径的相关操作.
 */
@interface NSDictionary (HTExtendedDictionary)

/*!
 *  判断字典数据写入指定路径文件是否成功
 *
 *  @param path 写入文件路径
 *
 *  @return YES，保存成功；NO，保存失败
 */
- (BOOL)ht_saveToDocumentsPathFile:(NSString *_Nullable)path;

/*!
 *  返回根据指定Documents路径的文件数据生成的NSDictionary对象
 *
 *  @param path 要读取数据的相对Documents路径下的相对路径
 *
 *  @return 读取的NSDictionary
 */
+ (NSDictionary *_Nullable)ht_loadDictioanryFromDocumentsPath:(NSString *_Nullable)path;

@end

