//
//  HTTTypeCastUtil.h
//  cocos2d_libs
//
//  Created by 伟东 on 2020/7/6.
//

#import <CoreGraphics/CGGeometry.h>
#import <UIKit/UIKit.h>
//#endif


#import <UIKit/UIGeometry.h>
/*!
 *  CGPoint结构值装换为NSString值
 */
#define HTPointFromString CGPointFromString
/*!
 *  CGRect结构值装换为NSString值
 */
#define HTRectFromString CGRectFromString
/*!
 *  CGSize结构值装换为NSString值
 */
#define HTSizeFromString CGSizeFromString
/*!
 *  返回CGPointMake(0, 0)
 */
#define HTZeroPoint CGPointZero
/*!
 *  CGSizeMake(0, 0)
 */
#define HTZeroSize CGSizeZero
/*!
 *  CGRectMake(0, 0, 0, 0)
 */
#define HTZeroRect CGRectZero


/*!
 *  从 value 中递归移除 null
 *
 *  @param value  输入的原始 value
 *
 *  @return 清除完 null 之后的 value（如果 value 自身为 null，则返回 nil）
 */
id ht_nonnullValue(id value);


/*!
 *  返回当前value的NSNumber的值，不是则返回defaultValue
 *
 *  @param value 需要判断的对象
 *  @param defaultValue 一个默认的NSNumber类型值当需要判断的对象value不是NSNumber类型时则返回该默认值，没有则为Nil
 *
 *  @return 是NSNumber类型返回value，不是则返回defaultValue
 */
NSNumber *ht_numberOfValue(id value, NSNumber *defaultValue);

/*!
 *  返回当前value的NSString的值，不是string则返回defaultValue
 *
 *  @param value 需要判断的对象
 *  @param defaultValue 一个默认的NSString类型值当需要判断的对象value不是NSString类型时则返回该默认值，没有则为Nil
 *
 *  @return 是NSString类型返回value，不是string则返回defaultValue
 */
NSString *ht_stringOfValue(id value, NSString *defaultValue);

/*!
 *  当数组成员全是NSString类型时返回该数组，不是string则返回defaultValue
 *
 *  @param value 需要判断的对象
 *  @param defaultValue 一个默认的NSString数组当需要判断的对象value不是NSString数组时则返回该默认值，没有则为Nil
 *
 *  @return 是NSString类型数组返回value，不是string则返回defaultValue
 */
NSArray *ht_stringArrayOfValue(id value, NSArray *defaultValue);

/*!
 *  返回当前value的NSDictionary值，不是则返回defaultValue
 *
 *  @param value 需要判断的对象
 *  @param defaultValue 一个默认的NSDictionary类型值当需要判断的对象value不是NSDictionary类型时则返回该默认值，没有则为Nil
 *
 *  @return 是NSDictionary类型返回value，不是则返回defaultValue
 */
NSDictionary *ht_dictOfValue(id value, NSDictionary *defaultValue);

/*!
 *  返回当前value的NSArray值，不是则返回defaultValue
 *
 *  @param value 需要判断的对象
 *  @param defaultValue 一个默认的NSArray类型值当需要判断的对象value不是NSArray类型时则返回该默认值，没有则为Nil
 *
 *  @return 是NSArray类型返回value，不是则返回defaultValue
 */
NSArray *ht_arrayOfValue(id value ,NSArray *defaultValue);

/*!
 *  返回当前value的float值，不是则返回defaultValue
 *
 *  @param value 需要判断的对象
 *  @param defaultValue 一个默认的float类型值当需要判断的对象value不是float类型时则返回该默认值，没有则为Nil
 *
 *  @return 是float类型返回value，不是则返回defaultValue
 */
float ht_floatOfValue(id value, float defaultValue);

/*!
 *  返回当前value的double值，不是则返回defaultValue
 *
 *  @param value 需要判断的对象
 *  @param defaultValue 一个默认的double类型值当需要判断的对象value不是double类型时则返回该默认值，没有则为Nil
 *
 *  @return 是double类型返回value，不是则返回defaultValue
 */
double ht_doubleOfValue(id value, double defaultValue);

/*!
 *  返回当前value的CGPoint值，不是则返回defaultValue
 *
 *  @param value 需要判断的对象
 *  @param defaultValue 一个默认的CGPoint类型值当需要判断的对象value不是CGPoint类型时则返回该默认值，没有则为Nil
 *
 *  @return 是CGPoint类型返回value，不是则返回defaultValue
 */
CGPoint ht_pointOfValue(id value, CGPoint defaultValue);

/*!
 *  返回当前value的CGSize值，不是则返回defaultValue
 *
 *  @param value 需要判断的对象
 *  @param defaultValue 一个默认的CGSize类型值当需要判断的对象value不是CGSize类型时则返回该默认值，没有则为Nil
 *
 *  @return 是CGSize类型返回value，不是则返回defaultValue
 */
CGSize ht_sizeOfValue(id value, CGSize defaultValue);


/*!
 *  返回当前value的CGRect值，不是则返回defaultValue
 *
 *  @param value 需要判断的对象
 *  @param defaultValue 一个默认的CGRect类型值当需要判断的对象value不是CGRect类型时则返回该默认值，没有则为Nil
 *
 *  @return 是CGRect类型返回value，不是则返回defaultValue
 */
CGRect ht_rectOfValue(id value, CGRect defaultValue);

/*!
 *  返回当前value的BOOL值，不是则返回defaultValue
 *
 *  @param value 需要判断的对象
 *  @param defaultValue 一个默认的BOOL类型值当需要判断的对象value不是BOOL类型时则返回该默认值，没有则为Nil
 *
 *  @return 是BOOL类型返回value，不是则返回defaultValue
 */
BOOL ht_boolOfValue(id value, BOOL defaultValue);

/*!
 *  返回当前value的int值，不是则返回defaultValue
 *
 *  @param value 需要判断的对象
 *  @param defaultValue 一个默认的int类型值当需要判断的对象value不是int类型时则返回该默认值，没有则为Nil
 *
 *  @return 是int类型返回value，不是则返回defaultValue
 */
int ht_intOfValue(id value, int defaultValue);

/*!
 *  返回当前value的unsigned int值，不是则返回defaultValue
 *
 *  @param value 需要判断的对象
 *  @param defaultValue 一个默认的unsigned int类型值当需要判断的对象value不是unsigned int类型时则返回该默认值，没有则为Nil
 *
 *  @return 是unsigned int类型返回value，不是则返回defaultValue
 */
unsigned int ht_unsignedIntOfValue(id value, unsigned int defaultValue);

/*!
 *  返回当前value的long long int值，不是则返回defaultValue
 *
 *  @param value 需要判断的对象
 *  @param defaultValue 一个默认的long long int类型值当需要判断的对象value不是long long int类型时则返回该默认值，没有则为Nil
 *
 *  @return 是long long int类型返回value，不是则返回defaultValue
 */
long long int ht_longLongOfValue(id value, long long int defaultValue);

/*!
 *  返回当前value的unsigned long long int值，不是则返回defaultValue
 *
 *  @param value 需要判断的对象
 *  @param defaultValue defaultValue 一个默认的unsigned long long int类型值当需要判断的对象value不是unsigned long long int类型时则返回该默认值，没有则为Nil
 *
 *  @return 是unsigned long long int类型返回value，不是则返回defaultValue
 */
unsigned long long int ht_unsignedLongLongOfValue(id value, unsigned long long int defaultValue);

/*!
 *  返回当前value的NSInteger值，不是则返回defaultValue
 *
 *  @param value 一个默认的NSInteger类型值当需要判断的对象value不是NSInteger类型时则返回该默认值，没有则为Nil
 *  @param defaultValue 需要返回的默认值，没有则为Nil
 *
 *  @return 是NSInteger类型返回value，不是则返回defaultValue
 */
NSInteger ht_integerOfValue(id value, NSInteger defaultValue);

/*!
 *  返回当前value的NSUInteger值，不是则返回defaultValue
 *
 *  @param value 需要判断的对象
 *  @param defaultValue 一个默认的NSUInteger类型值当需要判断的对象value不是NSUInteger类型时则返回该默认值，没有则为Nil
 *
 *  @return 是NSUInteger类型返回value，不是则返回defaultValue
 */
NSUInteger ht_unsignedIntegerOfValue(id value, NSUInteger defaultValue);

/*!
 *  返回当前value的UIImage值，不是则返回defaultValue
 *
 *  @param value 需要判断的对象
 *  @param defaultValue 一个默认的UIImage类型值当需要判断的对象value不是UIImage类型时则返回该默认值，没有则为Nil
 *
 *  @return 是UIImage类型返回value，不是则返回defaultValue
 */
UIImage *ht_imageOfValue(id value, UIImage *defaultValue);

/*!
 *  返回当前value的UIColor值，不是则返回defaultValue
 *
 *  @param value 需要判断的对象
 *  @param defaultValue 一个默认的UIColor类型值当需要判断的对象value不是UIColor类型时则返回该默认值，没有则为Nil
 *
 *  @return 是UIColor类型返回value，不是则返回defaultValue
 */
UIColor *ht_colorOfValue(id value, UIColor *defaultValue);

/*!
 *  返回当前value的UIColor值，不是则返回defaultValue
 *
 *  @param value 需要判断的对象
 *  @param defaultValue 一个默认的time_t类型值当需要判断的对象value不是time_t类型时则返回该默认值，没有则为Nil
 *
 *  @return 是time_t类型返回value，不是则返回defaultValue
 */
time_t ht_timeOfValue(id value, time_t defaultValue);

/*!
 *  将NSNumber类型的值或者是NSString类型转换为NSDate类型值返回
 *
 *  @param value 需要判断的对象
 *
 *  @return 是NSDate类型返回value
 */
NSDate *ht_dateOfValue(id value);

/*!
 *  返回当前value的NSURL值，不是则返回defaultValue
 *
 *  @param value 需要判断的对象
 *  @param defaultValue 一个默认的NSURL类型值当需要判断的对象value不是NSURL类型时则返回该默认值，没有则为Nil
 *
 *  @return 是NSURL类型返回value，不是则返回defaultValue
 */
NSURL *ht_urlOfValue(id value, NSURL *defaultValue);
