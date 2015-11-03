package com.skyfinancial1.canadamortgage;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ArrayAdapter;
import android.widget.ListView;

public class CalcListActivity extends ContactBaseActivity implements OnItemClickListener
{
	
	private ListView __list = null;
	private ListView getListView()
	{
		if (__list == null)
			__list = (ListView) findViewById(android.R.id.list);
		return __list;
	}
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.calc_list);
     
        initDefaultControls();
        
        if (getListView() != null)
        {
        	String [] calculatorList = getResources().getStringArray(R.array.calculator_list);
        	ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, R.layout.list_view_item
        			, R.id.text1, calculatorList);
        	getListView().setAdapter(adapter);
        	getListView().setOnItemClickListener(this);
        }
    }

	@Override
	public void onItemClick(AdapterView<?> parent, View view, int position, long id)
	{
		switch (position)
		{
		case 0:
		{
			final Intent intent = new Intent(this, CalcQualifierActivity.class);
			startActivity(intent);
		} break;			
		case 1:
		{
			final Intent intent = new Intent(this, CalcRentBuyActivity.class);
			startActivity(intent);
		} break;			
		case 2:
		{
			final Intent intent = new Intent(this, CalcPaymentActivity.class);
			startActivity(intent);
		} break;			
		}
	}

}
