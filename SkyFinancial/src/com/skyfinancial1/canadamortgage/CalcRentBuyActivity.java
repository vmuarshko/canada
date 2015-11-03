package com.skyfinancial1.canadamortgage;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.KeyEvent;
import android.view.View;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputMethodManager;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ScrollView;
import android.widget.Spinner;
import android.widget.TableLayout;
import android.widget.TextView;

public class CalcRentBuyActivity extends SFBaseActivity
{
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.calc_rent_buy);
     
        initDefaultControls();

        Spinner spinnerAmortization = (Spinner) findViewById(R.id.spinnerAmortization);
        if (spinnerAmortization != null)
        {
        	ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(this
        		, R.array.loan_periods
        		, android.R.layout.simple_spinner_item);
        	adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        	spinnerAmortization.setAdapter(adapter);
        	spinnerAmortization.setSelection(9);
        }

        Spinner spinnerComparision = (Spinner) findViewById(R.id.spinnerComparision);
        if (spinnerComparision != null)
        {
        	ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(this
        		, R.array.comparision_periods
        		, android.R.layout.simple_spinner_item);
        	adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        	spinnerComparision.setAdapter(adapter);
        	spinnerComparision.setSelection(4);
        }
        
		Spinner spinnerVolumeIncrease = (Spinner) findViewById(R.id.spinnerVolumeIncrease);
        if (spinnerVolumeIncrease != null)
        {
        	ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(this
        		, R.array.volume_percents
        		, android.R.layout.simple_spinner_item);
        	adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        	spinnerVolumeIncrease.setAdapter(adapter);
        	spinnerVolumeIncrease.setSelection(1);
        }
        
        
        EditText editMonthlyRent = (EditText) findViewById(R.id.editMonthlyRent);
        if (editMonthlyRent != null)
        {
        	editMonthlyRent.setOnEditorActionListener(editorImeCalcListener);
        }
        
                
        Button btnCalc = (Button) findViewById(R.id.btnCalc);
        if (btnCalc != null)
        {
        	btnCalc.setOnClickListener(new View.OnClickListener()
			{				
				@Override
				public void onClick(View v)
				{
					handleCalc();					
				}
			});
        }
        
        Button btnQuickApp = (Button) findViewById(R.id.btnQuickApp);
        if (btnQuickApp != null)
        {
        	btnQuickApp.setOnClickListener(new View.OnClickListener()
			{				
				@Override
				public void onClick(View v)
				{
					final Intent intent = new Intent(CalcRentBuyActivity.this, QuickAppActivity.class);
					startActivity(intent);
					finish();
				}
			});
        }
    }

    private TextView.OnEditorActionListener editorImeCalcListener = new TextView.OnEditorActionListener()
	{		
		@Override
		public boolean onEditorAction(TextView v, int actionId, KeyEvent event)
		{
			if (actionId == EditorInfo.IME_ACTION_GO && 
					(event == null || event.getAction() == KeyEvent.ACTION_DOWN)) 
			{ 
				handleCalc();
			}
			return true;				
		}
	};
	
	private static final String decision_message = 
		"<h2>YOU SHOULD %s!</h2>" + 
		"<p><B>Based on the information you have given us, it looks like you should %s. </B>" + 
		"<p>Why? If you bought for <b>$%.2f</b>, the maximum you would qualify for, you would pay down your mortgage " + 
		"of <b>$%.2f</b>" + 
		" by <b>$%.2f</b> over a period of %.0f year(s). With Principal and Interest payments of <b>$%.2f</b> per month, plus your projected property " +
		"value increase of <b>$%.2f</b> your total investment growth would be " +
		"<b>$%.2f</b>. <p>This amount is <b>%s</b> than your total investment growth " +
		"from renting, which would be approximately <b>$%.2f</b> " +
		" after %.0f year(s). This was calculated by growing the combined totals of your monthly savings from renting (<b>$%.2f</b>) and your proposed downpayment " +
		" of <b>$%.2f</b> at a standard after-tax rate of 4%% per year.";				
	
	private void handleCalc()
	{
		Spinner spinnerAmortization = (Spinner) findViewById(R.id.spinnerAmortization);
		Spinner spinnerComparision = (Spinner) findViewById(R.id.spinnerComparision);
		Spinner spinnerVolumeIncrease = (Spinner) findViewById(R.id.spinnerVolumeIncrease);		
		
        EditText editBoughtPayment = (EditText) findViewById(R.id.editBoughtPayment);        
        EditText editDownPayment = (EditText) findViewById(R.id.editDownPayment);
        EditText editAnnualTaxes = (EditText) findViewById(R.id.editAnnualTaxes);        
        EditText editMortgageRate = (EditText) findViewById(R.id.editMortgageRate);        
        EditText editMonthlyRent = (EditText) findViewById(R.id.editMonthlyRent);		
        
        try
        {        	
        	double amortizationMonths = (double)(getResources()
        			.getIntArray(R.array.loan_period_values)[spinnerAmortization.getSelectedItemPosition()]);        	        	
        	double comparisionYears = (double)(getResources()
        			.getIntArray(R.array.comparision_period_values)[spinnerComparision.getSelectedItemPosition()]);        	
        	double volumeIncrease = (double)(getResources()
        			.getIntArray(R.array.volume_percent_values)[spinnerVolumeIncrease.getSelectedItemPosition()]) / 100.0;        	

        	Double boughtPayment = TextUtils.isEmpty(editBoughtPayment.getText().toString().trim()) ?
        			0.0 :
        			Double.parseDouble(editBoughtPayment.getText().toString().trim());
        	if (boughtPayment < 200.0 || boughtPayment > 10000.0)
        	{
        		editBoughtPayment.requestFocus();
        		throw new Exception(String.format(getString(R.string.error_value_in_range), 200.0, 10000.0));
        	}
        	
        	Double downPayment = TextUtils.isEmpty(editDownPayment.getText().toString().trim()) ?
        			0.0 :
        			Double.parseDouble(editDownPayment.getText().toString().trim());
        	if (downPayment < 2000.0 || downPayment > 1000000.0)
        	{
        		editDownPayment.requestFocus();
        		throw new Exception(String.format(getString(R.string.error_value_in_range), 2000.0, 1000000.0));
        	}

        	Double annualTaxes = TextUtils.isEmpty(editAnnualTaxes.getText().toString().trim()) ?
        			0.0 :
        			Double.parseDouble(editAnnualTaxes.getText().toString().trim());
        	if (annualTaxes  < 300.0 || annualTaxes > 10000.0)
        	{
        		editAnnualTaxes.requestFocus();
        		throw new Exception(String.format(getString(R.string.error_value_in_range), 300.0, 10000.0));
        	}
        	
        	Double mortgageRate = Double.parseDouble(editMortgageRate.getText().toString().trim());
        	if (mortgageRate < 2 || mortgageRate > 25)
        	{
        		editMortgageRate.requestFocus();
        		throw new Exception(String.format(getString(R.string.error_value_in_range), 0.1, 30.0));
        	}
        	else mortgageRate = mortgageRate / 100.0; 

        	Double monthlyRent = TextUtils.isEmpty(editMonthlyRent.getText().toString().trim()) ?
        			0.0 :
        			Double.parseDouble(editMonthlyRent.getText().toString().trim());
        	if (monthlyRent < 0.0 || monthlyRent > 5000.0)
        	{
        		editMonthlyRent.requestFocus();
        		throw new Exception(String.format(getString(R.string.error_value_in_range), 0.0, 5000.0));
        	}

        	double compound = 2.0/12.0;
        	double yrRate = mortgageRate/2.0;
        	double rdefine = Math.pow((1.0 + yrRate),compound)-1.0;
        	double purchcompound = Math.pow((1.0 + rdefine), amortizationMonths);

        	double a1 = boughtPayment - (annualTaxes/12.0);
        	double b1 = ((a1*(purchcompound-1.0))/rdefine)/purchcompound;
        	double c1 = downPayment + b1;
        	double res = (b1*(Math.pow((1.0 + rdefine),(12.0*comparisionYears)))) - 
        			((a1 * ((Math.pow((1.0 + rdefine),(12.0*comparisionYears))) - 1.0))/rdefine);
        	double d1 = b1-res;
        	double e1 = c1*((Math.pow((1+(volumeIncrease)),comparisionYears))-1.0);
        	double f1 = boughtPayment - monthlyRent;
        	double g1 = (downPayment+(f1*12.0))*(Math.pow((1.04),comparisionYears))-downPayment;
        	double h1 = d1+e1;
        	
        	String decide =  (h1>g1) ? "BUY" : "CONTINUE TO RENT";
        	String words =  (h1>g1) ? "greater" : "less";
        	
        	String resultString = String.format(decision_message, decide, decide, c1, b1, d1, 
        			comparisionYears, a1, e1, h1, words, g1, comparisionYears, f1, downPayment);
        	
        	final Intent intent = new Intent(this, CalcRentBuyResultActivity.class);
        	intent.putExtra(CalcRentBuyResultActivity.RESULT_TEXT, resultString);
        	intent.putExtra(CalcRentBuyResultActivity.SHOW_QUICK_APP, (h1>g1) ? true : false);
        	startActivity(intent);        	
        }
        catch (NumberFormatException ex)
        {
        	showErrorMessage(getString(R.string.error_number_format));
        }
        catch (Exception ex)
        {
        	showErrorMessage(ex.getMessage());
        }		
	}

}


