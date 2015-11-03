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

public class CalcPaymentActivity extends SFBaseActivity
{
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.calc_payment);
     
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
					final Intent intent = new Intent(CalcPaymentActivity.this, QuickAppActivity.class);
					startActivity(intent);
					finish();
				}
			});
        }
    }

	private void handleCalc()
	{
		Spinner spinnerAmortization = (Spinner) findViewById(R.id.spinnerAmortization);
        EditText editMortgageAmount = (EditText) findViewById(R.id.editMortgageAmount);
        EditText editMortgageRate = (EditText) findViewById(R.id.editMortgageRate);
        
        try
        {
        	int amortizationMonths = getResources()
        			.getIntArray(R.array.loan_period_values)[spinnerAmortization.getSelectedItemPosition()];
        	        	
        	Double mortgageAmount = TextUtils.isEmpty(editMortgageAmount.getText().toString().trim()) ?
        			0.0 :
        			Double.parseDouble(editMortgageAmount.getText().toString().trim());
        	if (mortgageAmount  < 100.0 || mortgageAmount> 10000000.0)
        	{
        		editMortgageAmount.requestFocus();
        		throw new Exception(String.format(getString(R.string.error_value_in_range), 100.0, 10000000.0));
        	}

        	Double mortgageRate = Double.parseDouble(editMortgageRate.getText().toString().trim());
        	if (mortgageRate <= 0.1 || mortgageRate > 30.0)
        	{
        		editMortgageRate.requestFocus();
        		throw new Exception(String.format(getString(R.string.error_value_in_range), 0.1, 30.0));
        	}

        	compPay(mortgageAmount, amortizationMonths, mortgageRate);
        	
    		InputMethodManager mgr = (InputMethodManager) this.getSystemService(Context.INPUT_METHOD_SERVICE);
            mgr.hideSoftInputFromWindow(editMortgageRate.getWindowToken(), 0);
            
            editMortgageAmount.requestFocus();
            ScrollView scrollView1 = (ScrollView) findViewById(R.id.scrollView1);
            if (scrollView1 != null)
            {
            	scrollView1.scrollTo(0, 0);
            }    		        	
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
	
	private double findAmort(double q, double n, double MORTGAGE, double RATE, double COMPOUND, double PAYMENTAG, int FREQ)
	{
		double compound = COMPOUND/12.0;
		double yrRate = RATE/COMPOUND;
		double rdefine = Math.pow((1.0 + yrRate),compound)-1.0;
		double newpay = 1000000000.0;

		double p = 12.0;
		
		switch (FREQ)
		{
		case 2: default: p = 12.0; break;
		case 3: p = 13.0; break;
		case 4: p = 13.0; break;
		}
	
		double i = q;
		for(; newpay>=PAYMENTAG; i += n)
		{
			double monTime = i * p;
			double comfact = Math.pow((1.0 + rdefine),monTime);
			newpay = (MORTGAGE*rdefine * comfact)/  (comfact - 1.0);
		}
		return i-n-n;
	}
	
	
	private double compAmort(double MORTGAGE, double INRATE, double AMORT, double PAYMENTt, int FREQ)
	{
		double COMPOUND = 2.0;
		
		double returnpay = 0.0;

		switch (FREQ)
		{
		case 2: default: returnpay = PAYMENTt*2.0; break; 
		case 3: returnpay = PAYMENTt*2.0; break; 
		case 4: returnpay = PAYMENTt*4.0; break; 
		}
		
		double wholecom = findAmort(1,1,MORTGAGE,INRATE,COMPOUND,returnpay,FREQ);
		double solvecom = findAmort(wholecom,.001,MORTGAGE,INRATE,COMPOUND,returnpay,FREQ);
		
		return solvecom;		
	}
	
	private void compPay(double MORTGAGE, int amortizationMonths, double mortgageRate)
	{
		double AMORT= ((double)amortizationMonths) / 12.0;
		double INRATE= mortgageRate / 100.0;

		double compound = 2.0/12.0;
		double monTime = amortizationMonths;

		double yrRate = INRATE/2;
		double rdefine = Math.pow((1.0 + yrRate),compound)-1.0;
		double comfact = Math.pow((1.0 + rdefine),monTime);
		double PAYMNT = (MORTGAGE*rdefine * comfact)/  (comfact - 1.0);

		double rPAYMENT = PAYMNT;
		double rPAYMENT2 = PAYMNT/2.0;
		double rPAYMENT3 = PAYMNT/4.0;

		TableLayout tableResults = (TableLayout) findViewById(R.id.tableResults);
		TextView textViewPayment1 = (TextView) findViewById(R.id.textViewPayment1);
		TextView textViewPayment2 = (TextView) findViewById(R.id.textViewPayment2);
		TextView textViewPayment3 = (TextView) findViewById(R.id.textViewPayment3);
		TextView textViewPayment4 = (TextView) findViewById(R.id.textViewPayment4);

		String moneySign = getString(R.string.money_sign);
		textViewPayment1.setText(String.format("%s%.2f", moneySign, rPAYMENT));
		textViewPayment2.setText(String.format("%s%.2f", moneySign, rPAYMENT2));		
		textViewPayment3.setText(String.format("%s%.2f", moneySign, rPAYMENT2));
		textViewPayment4.setText(String.format("%s%.2f", moneySign, rPAYMENT3));

		TextView textViewAmort1 = (TextView) findViewById(R.id.textViewAmort1);
		TextView textViewAmort2 = (TextView) findViewById(R.id.textViewAmort2);
		TextView textViewAmort3 = (TextView) findViewById(R.id.textViewAmort3);
		TextView textViewAmort4 = (TextView) findViewById(R.id.textViewAmort4);
		
		textViewAmort1.setText(String.format("%.1f yr", AMORT));
		textViewAmort2.setText(String.format("%.1f yr", compAmort(MORTGAGE, INRATE, AMORT, rPAYMENT2, 2)));
		textViewAmort3.setText(String.format("%.1f yr", compAmort(MORTGAGE, INRATE, AMORT, rPAYMENT2, 3)));
		textViewAmort4.setText(String.format("%.1f yr", compAmort(MORTGAGE, INRATE, AMORT, rPAYMENT3, 4)));
			
		tableResults.setVisibility(View.VISIBLE);
	}
	
}


