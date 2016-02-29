
#import <Foundation/Foundation.h>

@interface DES : NSObject

//加密
-(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key;

//解密
-(NSString*) decryptUseDES:(NSString*)cipherText key:(NSString*)key ;

@end
