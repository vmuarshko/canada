package com.jencor1.mortgage;

import android.os.Bundle;
import android.widget.ListView;

import com.jencor1.mortgage.common.ActivityMenuAdapter;
import com.jencor1.mortgage.common.ListViewItemDescriptor;

public class CalcListActivity extends ContactBaseActivity
{
	private static final ListViewItemDescriptor [] MENU_ITEMS =
		{
		new ListViewItemDescriptor(R.drawable.calc_planning, R.string.calc_planning, CalcQualifierActivity.class, null) 
		, new ListViewItemDescriptor(R.drawable.calc_purchase, R.string.calc_purchase, CalcPaymentActivity.class, null) 
		, new ListViewItemDescriptor(R.drawable.calc_rent_buy, R.string.calc_rent_buy, CalcRentBuyActivity.class, null) 
		};

	
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
        	getListView().setAdapter(new ActivityMenuAdapter(this, MENU_ITEMS, getListView(), R.layout.calc_list_item));
        }
    }
}
