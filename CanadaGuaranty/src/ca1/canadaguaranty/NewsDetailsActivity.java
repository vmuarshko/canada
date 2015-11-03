package ca1.canadaguaranty;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.text.Html;
import android.view.View;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.ScrollView;
import android.widget.TextView;
import ca1.canadaguaranty.R;

public class NewsDetailsActivity extends BaseActivity
{
	public static final String TITLE = "TITLE";
	public static final String CONTENT = "CONTENT";
	public static final String POSTED = "POSTED";
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.news_details);
     
        initDefaultControls();
        
        setPageTitle(getIntent().getStringExtra(TITLE));
    	TextView textViewTitle = (TextView) findViewById(R.id.textViewTitle);
    	if (textViewTitle != null)
    		textViewTitle.setTextColor(getResources().getColor(R.color.highlight_color));

        TextView textPosted = (TextView) findViewById(R.id.textPosted);
        if (textPosted != null)
        	textPosted.setText(getIntent().getStringExtra(POSTED));

        String content = getIntent().getStringExtra(CONTENT);
        /*TextView textValue = (TextView) findViewById(R.id.textValue);
        if (textValue != null)
        	textValue.setText(Html.fromHtml(content));*/
        
		WebView wv = (WebView) findViewById(R.id.webView);
		wv.setWebViewClient(new WebViewClient()
		{
			@Override
			public void onReceivedError(WebView view, int errorCode,
							String description, String failingUrl)
			{
				view.setVisibility(View.GONE);
		        String content = getIntent().getStringExtra(CONTENT);
		        TextView textValue = (TextView) findViewById(R.id.textValue);
		        if (textValue != null)
		        	textValue.setText(Html.fromHtml(content));
		        ScrollView layoutContent = (ScrollView) findViewById(R.id.layoutContent);
		        layoutContent.setVisibility(View.VISIBLE);
			}

		    @Override
		    public boolean shouldOverrideUrlLoading(WebView view, String url)
		    {
		    	try
		    	{
			    	if (!url.startsWith("http://") && !url.startsWith("https://")) url = "http://" + url;
			    	Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
			    	startActivity(browserIntent);
		    	}
		    	catch (Exception ex) {}		    	
		        return true;
		    }
			
			@Override
			public void onPageFinished(WebView view, String url)
			{
				/*view.setVisibility(View.VISIBLE);
		        ScrollView layoutContent = (ScrollView) findViewById(R.id.layoutContent);
		        layoutContent.setVisibility(View.GONE);*/
			}
		});
		
		String header = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>";
		wv.loadData(header + content, "text/html; charset=UTF-8", null);
		
		
		enableBackButton(true);
    }

}
