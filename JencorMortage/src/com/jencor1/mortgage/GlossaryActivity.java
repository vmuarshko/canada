package com.jencor1.mortgage;

import android.os.Bundle;
import android.webkit.WebView;
import android.webkit.WebViewClient;

public class GlossaryActivity extends BaseActivity
{
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.glossary);
     
        initDefaultControls();
        
		WebView wv = (WebView) findViewById(R.id.webView);
		if (wv != null)
		{
			wv.setWebViewClient(new WebViewClient()
			{
				@Override
				public boolean shouldOverrideUrlLoading(WebView view, String url)
				{
					view.loadUrl(url);
					return true;
				}
			});
			wv.loadUrl("file:///android_asset/data/Glossary.html");
		}        
    }
}
