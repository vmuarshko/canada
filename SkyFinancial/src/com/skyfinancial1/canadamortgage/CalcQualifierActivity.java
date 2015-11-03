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

public class CalcQualifierActivity extends SFBaseActivity
{
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.calc_qualifier);
     
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
        
        EditText editSecondaryPayments = (EditText) findViewById(R.id.editSecondaryPayments);
        if (editSecondaryPayments != null)
        {
        	editSecondaryPayments.setOnEditorActionListener(editorImeCalcListener);
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
					final Intent intent = new Intent(CalcQualifierActivity.this, QuickAppActivity.class);
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

	private void handleCalc()
	{
		Spinner spinnerAmortization = (Spinner) findViewById(R.id.spinnerAmortization);
        EditText editAnnualIncome = (EditText) findViewById(R.id.editAnnualIncome);
        EditText editAnnualTaxes = (EditText) findViewById(R.id.editAnnualTaxes);
        EditText editMortgageRate = (EditText) findViewById(R.id.editMortgageRate);
        EditText editHeatingCosts = (EditText) findViewById(R.id.editHeatingCosts);
        EditText editLoanPayments = (EditText) findViewById(R.id.editLoanPayments);		
        EditText editSecondaryPayments = (EditText) findViewById(R.id.editSecondaryPayments);
        
        try
        {        	
        	int amortizationMonths = getResources()
        			.getIntArray(R.array.loan_period_values)[spinnerAmortization.getSelectedItemPosition()];        	

        	Double annualIncome = TextUtils.isEmpty(editAnnualIncome.getText().toString().trim()) ?
        			0.0 :
        			Double.parseDouble(editAnnualIncome.getText().toString().trim());
        	if (annualIncome  < 10000.0 || annualIncome > 10000000.0)
        	{
        		editAnnualIncome.requestFocus();
        		throw new Exception(String.format(getString(R.string.error_value_in_range), 10000.0, 10000000.0));
        	}
        	
        	Double annualTaxes = TextUtils.isEmpty(editAnnualTaxes.getText().toString().trim()) ?
        			0.0 :
        			Double.parseDouble(editAnnualTaxes.getText().toString().trim());
        	if (annualTaxes  < 100.0 || annualTaxes > 50000.0)
        	{
        		editAnnualTaxes.requestFocus();
        		throw new Exception(String.format(getString(R.string.error_value_in_range), 100.0, 50000.0));
        	}

        	Double mortgageRate = Double.parseDouble(editMortgageRate.getText().toString().trim());
        	if (mortgageRate <= 0.1 || mortgageRate > 30.0)
        	{
        		editMortgageRate.requestFocus();
        		throw new Exception(String.format(getString(R.string.error_value_in_range), 0.1, 30.0));
        	}

        	Double heatingCosts = TextUtils.isEmpty(editHeatingCosts.getText().toString().trim()) ?
        			0.0 :
        			Double.parseDouble(editHeatingCosts.getText().toString().trim());
        	if (heatingCosts < 20.0 || heatingCosts > 1500.0)
        	{
        		editHeatingCosts.requestFocus();
        		throw new Exception(String.format(getString(R.string.error_value_in_range), 20.0, 1500.0));
        	}

        	Double loanPayments = TextUtils.isEmpty(editLoanPayments.getText().toString().trim()) ?
        			0.0 :
        			Double.parseDouble(editLoanPayments.getText().toString().trim());
        	if (loanPayments < 0.0 || loanPayments > 5000.0)
        	{
        		editLoanPayments.requestFocus();
        		throw new Exception(String.format(getString(R.string.error_value_in_range), 0.0, 5000.0));
        	}

        	Double secondaryPayments = TextUtils.isEmpty(editSecondaryPayments.getText().toString().trim()) ?
        			0.0 :
        			Double.parseDouble(editSecondaryPayments.getText().toString().trim());        	
        	if (secondaryPayments < 2.0 || secondaryPayments > 2500.0)
        	{
        		editSecondaryPayments.requestFocus();
        		throw new Exception(String.format(getString(R.string.error_value_in_range), 2.0, 2500.0));
        	}
        	
        	double RATE = mortgageRate/100.0;
        	double compound = 2.0/12.0;
        	double monTime = amortizationMonths;
        	double yrRate = RATE/2.0;
        	double rdefine = Math.pow((1.0 + yrRate),compound)-1.0;
        	double purchcompound = Math.pow((1.0 + rdefine),monTime);

        	double maxgdsr =.32;
        	double maxtdsr =.42;

        	double GDSPAY = (maxgdsr * annualIncome) - annualTaxes - heatingCosts - secondaryPayments;
        	double TDSPAY = (maxtdsr * annualIncome) - annualTaxes - heatingCosts - secondaryPayments - loanPayments;

        	double PAYMENT = (GDSPAY<TDSPAY) ? GDSPAY/12 : TDSPAY/12;
        	double MORTGAGE = (0 +((PAYMENT*(purchcompound-1.0))/rdefine))/purchcompound;

    		TableLayout tableResults = (TableLayout) findViewById(R.id.tableResults);
    		TextView textViewMaxMortgage = (TextView) findViewById(R.id.textViewMaxMortgage);
    		TextView textViewMonthlyPayment = (TextView) findViewById(R.id.textViewMonthlyPayment);
    		
    		String moneySign = getString(R.string.money_sign);
    		textViewMaxMortgage.setText(String.format("%s%.2f", moneySign, MORTGAGE));
    		textViewMonthlyPayment.setText(String.format("%s%.2f", moneySign, PAYMENT));
        	
    		tableResults.setVisibility(View.VISIBLE);
    		
    		InputMethodManager mgr = (InputMethodManager) this.getSystemService(Context.INPUT_METHOD_SERVICE);
            mgr.hideSoftInputFromWindow(editSecondaryPayments.getWindowToken(), 0);
            
            editAnnualIncome.requestFocus();
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

}


