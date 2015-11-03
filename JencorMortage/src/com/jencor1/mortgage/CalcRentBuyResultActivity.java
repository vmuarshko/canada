package com.jencor1.mortgage;

import com.jencor1.mortgage.R;

import android.content.Intent;
import android.os.Bundle;
import android.text.Html;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class CalcRentBuyResultActivity extends BaseActivity
{
	public static final String RESULT_TEXT = "RESULT_TEXT";
	public static final String SHOW_QUICK_APP = "SHOW_QUICK_APP";
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.calc_rent_buy_result);
     
        initDefaultControls();
        
        String resultText = getIntent().getStringExtra(RESULT_TEXT);
        
        TextView textViewResult = (TextView) findViewById(R.id.textViewResult);
        if (textViewResult != null)
        {
        	textViewResult.setText(Html.fromHtml(resultText));
        }
        
        boolean showQuickApp = getIntent().getBooleanExtra(SHOW_QUICK_APP, false);        
        Button btnQuickApp = (Button) findViewById(R.id.btnQuickApp);
        if (btnQuickApp != null)
        {
        	btnQuickApp.setVisibility(showQuickApp ? View.VISIBLE : View.GONE);
        	btnQuickApp.setOnClickListener(new View.OnClickListener()
			{				
				@Override
				public void onClick(View v)
				{
					final Intent intent = new Intent(CalcRentBuyResultActivity.this, QuickAppActivity.class);
					startActivity(intent);
					finish();
				}
			});
        }
    }

}


