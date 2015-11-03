package com.skyfinancial1.canadamortgage;

import android.os.Bundle;
import android.text.Html;
import android.text.TextUtils;
import android.widget.TextView;

public class NewsDetailsActivity extends SFBaseActivity
{
	public static final String TITLE = "TITLE";
	public static final String CONTENT = "CONTENT";
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.news_details);
     
        initDefaultControls();
        
        TextView textTitle = (TextView) findViewById(R.id.textTitle);
        if (textTitle != null)
        	textTitle.setText(getIntent().getStringExtra(TITLE));

        TextView textContent = (TextView) findViewById(R.id.textContent);
        if (textContent != null)
        {
        	String content = getIntent().getStringExtra(CONTENT);
        	if (!TextUtils.isEmpty(content))
        		textContent.setText(Html.fromHtml(content));
        }
    }

}
