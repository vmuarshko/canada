package ca1.canadaguaranty;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import ca1.canadaguaranty.R;

public class CalculatorListActivity extends BaseActivity
{
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.calculators);
     
        initDefaultControls();
    }
    
    public void onPaymentCalcClick(View view)
    {
    	startActivity(new Intent(this, CalcPaymentActivity.class));
    }

    public void onInsurancePremiumCalcClick(View view)
    {
    	startActivity(new Intent(this, CalcInsurancePremiumActivity.class));
    }
    
    public void onRentVsBuyCalcClick(View view)
    {
    	startActivity(new Intent(this, CalcRentBuyActivity.class));
    }
}
