/********* OpenLink.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <UIKit/UIKit.h>

@interface OpenLink : CDVPlugin {
  // Member variables go here.
}

- (void)safari:(CDVInvokedUrlCommand*)command;
- (void)chrome:(CDVInvokedUrlCommand*)command;

@end

@implementation OpenLink

- (void)safari:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* url = [command.arguments objectAtIndex:0];
    NSURL* URL = [NSURL URLWithString:url];

    __block BOOL* retorno = false;

    __block UIApplication *application = [UIApplication sharedApplication];
    
    if([[UIDevice currentDevice].systemVersion floatValue] >= 10.0){
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        retorno = success;
    }];
    } else{
        retorno = [application canOpenURL:URL];
        if(retorno) {
            [application openURL:URL];        
        }   
    }
    if (retorno) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:URL];
    } else {
        NSString* msg = @"Não foi possível abrir no Safari, certifique que o mesmo esteja instalado e habilitado.";        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: msg];
    }


    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)chrome:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResultchrome = nil;
    NSString* urlchrome = [command.arguments objectAtIndex:0];
 
    urlchrome = [urlchrome stringByReplacingOccurrencesOfString:@"http://" withString:@"googlechrome://"];
    urlchrome = [urlchrome stringByReplacingOccurrencesOfString:@"https://" withString:@"googlechrome://"];

    NSURL* URLchrome = [NSURL URLWithString:urlchrome];
  

    __block BOOL* retornochrome = false;

    __block UIApplication *applicationchrome = [UIApplication sharedApplication];
    
    if([[UIDevice currentDevice].systemVersion floatValue] >= 10.0){
    [applicationchrome openURL:URLchrome options:@{} completionHandler:^(BOOL successchrome) {
        retornochrome = successchrome;
    }];
    } else{
        retornochrome = [applicationchrome canOpenURL:URLchrome];
        if(retornochrome) {
            [applicationchrome openURL:URLchrome];        
        }   
    }
    if (retornochrome) {
        pluginResultchrome = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:URLchrome];
    } else {
        NSString* msgchrome = @"Não foi possível abrir no chorme, certifique que o mesmo esteja instalado e habilitado.";        
        pluginResultchrome = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: msgchrome];
    }


    [self.commandDelegate sendPluginResult:pluginResultchrome callbackId:command.callbackId];
}

@end