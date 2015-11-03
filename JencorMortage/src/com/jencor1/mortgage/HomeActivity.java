package com.jencor1.mortgage;

import android.os.Bundle;
import android.widget.ListView;

import com.jencor1.mortgage.common.ActivityMenuAdapter;
import com.jencor1.mortgage.common.JMContactsData;
import com.jencor1.mortgage.common.ListViewItemDescriptor;

public class HomeActivity extends BaseActivity
{
	private static final ListViewItemDescriptor [] MENU_ITEMS =
		{
		new ListViewItemDescriptor(R.drawable.btn_interest_rates, R.string.btn_interest_rates, RatesActivity.class, null) 
		, new ListViewItemDescriptor(R.drawable.btn_calculator, R.string.btn_calc, CalcListActivity.class, null) 
		, new ListViewItemDescriptor(R.drawable.btn_news, R.string.btn_latest_news, NewsListActivity.class, null) 
		, new ListViewItemDescriptor(R.drawable.btn_callback, R.string.btn_quick_app, QuickAppActivity.class, null) 
		, new ListViewItemDescriptor(R.drawable.btn_glossary, R.string.btn_glossary, GlossaryActivity.class, null)
		, new ListViewItemDescriptor(R.drawable.btn_partners, R.string.btn_partners, null, JMContactsData.PREFERRED_PARTNERS) 
		, new ListViewItemDescriptor(R.drawable.btn_contact, R.string.btn_contact_info, ContactListActivity.class, null) 
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
        setContentView(R.layout.home);
     
        initDefaultControls();
        
        if (getListView() != null)
        {
        	getListView().setAdapter(new ActivityMenuAdapter(this, MENU_ITEMS, getListView(), R.layout.home_list_view_item));
        }
    }
}
