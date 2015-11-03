package ca1.canadaguaranty.common;

import android.webkit.WebView;
import android.webkit.WebViewClient;

public class LinkedWebViewClient extends WebViewClient
{
    public LinkedWebViewClient()
    {
        // do nothing
    }

    @Override
    public boolean shouldOverrideUrlLoading(WebView view, String url)
    {
        view.loadUrl(url);
        return true;
    }

    @Override
    public void onPageFinished(WebView view, String url)
    {
        // TODO Auto-generated method stub
        super.onPageFinished(view, url);
    }
}