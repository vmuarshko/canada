package ca1.canadaguaranty;

import java.io.InputStream;

import ca1.canadaguaranty.common.CGContactsData;
import ca1.canadaguaranty.common.CommonUtil;
import ca1.canadaguaranty.R;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.text.Html;
import android.text.TextUtils;
import android.view.View;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ScrollView;
import android.widget.Spinner;
import android.widget.TextView;

public class ContactsActivity extends BaseActivity
{
	public static final String TITLE = "TITLE";
	public static final String CONTENT = "CONTENT";
	public static final String POSTED = "POSTED";
	
	private int selection = 0;
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.contacts);
     
        initDefaultControls();

        Spinner spinnerContactType = (Spinner) findViewById(R.id.spinnerContactType);
        if (spinnerContactType != null)
        {
        	ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(this
        		, R.array.contact_types
        		, android.R.layout.simple_spinner_item);
        	adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        	spinnerContactType.setAdapter(adapter);
        	spinnerContactType.setSelection(selection);

        	spinnerContactType.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
        	    @Override
        	    public void onItemSelected(AdapterView<?> parentView, View selectedItemView, int position, long id) {
        	        selection = position;
        	        setContactText();
        	    }

        	    @Override
        	    public void onNothingSelected(AdapterView<?> parentView) 
        	    {
        	        selection = 0;
        	        setContactText();
        	    }
        	});        	
        }
        
		enableBackButton(false);
    }

    @Override
	protected void onResume()
    {
    	super.onResume();
    	
        final String fileName = getResources().getStringArray(R.array.contact_data_files)[selection];		
        if (TextUtils.isEmpty(fileName)) 
        {
        	selection = 0;
            Spinner spinnerContactType = (Spinner) findViewById(R.id.spinnerContactType);
            if (spinnerContactType != null) spinnerContactType.setSelection(selection);
        }
        setContactText();        
    }

    
    private void setContactText()
    {
		WebView wv = (WebView) findViewById(R.id.webView);
    	wv.setVisibility(View.GONE);
    	
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
				WebView wv = (WebView) findViewById(R.id.webView);
		    	wv.setVisibility(View.VISIBLE);
			}
		});
    	
    	
    	InputStream is = null;
    	try
    	{
            final String fileName = getResources().getStringArray(R.array.contact_data_files)[selection];
    		
            if (!TextUtils.isEmpty(fileName))
            {            
	    		CGContactsData.Resources r = CGContactsData.getResources();
				StringBuilder dirName = new StringBuilder();
	   			dirName.append("data_").append(r.locale.getLanguage()).append('/').append(fileName);
	   			
				is = getAssets().open(dirName.toString());
				if (is != null)
				{
					String content = CommonUtil.streamToString(is, "\n");
					wv.loadData(content, "text/html; charset=UTF-8", null);
					//wv.setVisibility(View.VISIBLE);
					
			        /*TextView textValue = (TextView) findViewById(R.id.textValue);
			        if (textValue != null)
			        	textValue.setText(Html.fromHtml(content));*/
				}
            }
            else 
            {
            	final Intent intent = new Intent(this, ContactDetailsActivity.class);
            	startActivity(intent);
            }
    	}
    	catch (Exception ex)
    	{
    		showErrorMessage(ex.toString());
    	}
    	finally
    	{
    		try
    		{
    			if (is != null) is.close();
    		}
    		catch (Exception ex) {}
    	}
    }
    
}
