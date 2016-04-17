#import <Foundation/Foundation.h>

/**
 * 随机色
 */
#define YYRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

// 设置颜色
#define YYColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define YYAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
//通知中心
#define YYNotificationCenter [NSNotificationCenter defaultCenter]
//通知字典键
extern NSString *const YYDictName;
extern NSString *const YYDict;

//特价
extern NSString *const YYSpecialSaleName;
extern NSString *const YYSpecialSaleDict;
/** 汽车数据源*/
/** 0.0 获取新闻列表 */
#define YYGetCarNewsURL @"http://a.xcar.com.cn/interface/6.0/getNewsList.php"
/** 0.1 刷新的新闻数量 （必须是整10的数，比如10，20，30等等，不然不会返回数据）*/
#define LIMIT @"limit"
/** 0.2 刷新状态 0 为刷新最新的新闻 10 为刷新之前的新闻 每加10则加载更久之前的新闻 */
#define OFFSET @"offset"
/** 0.3 新闻的类型 1为最新新闻（大杂烩） 2（国内外新车） 3（评测） 4（导购） 5（行情）*/
#define TYPE @"type"
/** 0.4 version? 传不传没影响 */
#define VER @"ver"

/** 1.获取视频新闻 */
/** type = 144998 (视频) */
#define YYGetVideoCarNewsURL @"http://mi.xcar.com.cn/interface/xcarapp/getdingyue.php"

/** 2.获取所有车品牌 */
#define YYGetAllXCarBrandsURL @"http://mi.xcar.com.cn/interface/xcarapp/getBrands.php"

/** 3.获取所有车品牌 */
// 参数：brandId 1 = Audi 56 = Aston Martin （id号不是按字母来的）
#define BRANDID @"brandId"
#define YYGetCarSubBrandsURL @"http://mi.xcar.com.cn/interface/xcarapp/getSeriesByBrandId.php"
/** 4. 车型新闻 */
// 参数：seriesId (2365) / uid
#define SERIESID @"seriesId"
#define YYGetSeriesInfoNewsURL @"http://mi.xcar.com.cn/interface/xcarapp/getSeriesInfoNew.php"
/** 5. 特价汽车 */
// 参数：action=1， cityId=475， dataType=4，deviceId=668B4D65-724E-461E-A389-905F158A0871
// seriesId=2365， uid
#define YYGetSpecialSaleURL @"http://mi.xcar.com.cn/interface/xcarapp/getSpecialSale.php"
#define cityIds @"cityId"

//二.美女图片API
/**  1.0分类列表*/
#define YYGetCategoryURL @"http://www.tngou.net/tnfs/api/classify"
/**  2.0图片列表*/
#define PicId @"id"
#define Rowse @"rows"
#define Pagin @"page"
#define YYGetGirlsURL @"http://www.tngou.net/tnfs/api/list"




