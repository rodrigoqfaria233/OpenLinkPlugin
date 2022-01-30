package cordova.plugin.openlink;

import android.content.Context;
import android.content.Intent;
import android.content.ActivityNotFoundException;
import android.net.Uri;


import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.CordovaInterface;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * This class echoes a string called from JavaScript.
 */
public class OpenLink extends CordovaPlugin {


  public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
    }


    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("chrome")) {
            String url = args.getString(0);
            this.chrome(url, callbackContext);
            return true;
        }
        return false;
    }

    private void chrome(String url, CallbackContext callbackContext) {
        String appPackageName = "com.android.chrome";
        try {
            Intent i = new Intent();
            i.setPackage(appPackageName);
            i.setAction(Intent.ACTION_VIEW);
            i.setData(Uri.parse(url));
            this.cordova.getActivity().startActivity(i);
            callbackContext.success("OK");      
        }
        catch(ActivityNotFoundException exx){
               this.cordova.getActivity().startActivity(new Intent(Intent.ACTION_VIEW, Uri.parse("https://play.google.com/store/apps/details?id=" + appPackageName)));
        }
        catch(Exception ex){
             callbackContext.error(ex.toString());
        }  
    }





}
