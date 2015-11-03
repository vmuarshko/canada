package ca1.canadaguaranty;

import android.os.Bundle;
import android.text.Html;
import android.widget.TextView;
import ca1.canadaguaranty.R;

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
        enableBackButton(true);
    }

}


