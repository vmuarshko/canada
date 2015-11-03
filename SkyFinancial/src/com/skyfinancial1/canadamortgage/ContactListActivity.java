package com.skyfinancial1.canadamortgage;

import com.skyfinancial1.canadamortgage.common.SFContactsData;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.AdapterView.OnItemClickListener;

public class ContactListActivity extends ContactBaseActivity implements OnItemClickListener
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
        setContentView(R.layout.contact_list);
     
        initDefaultControls();
        
        if (getListView() != null)
        {
        	ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, R.layout.list_view_item
        			, R.id.text1, SFContactsData.OFFICE_LIST);
        	getListView().setAdapter(adapter);
        	getListView().setOnItemClickListener(this);
        }
    }

	@Override
	public void onItemClick(AdapterView<?> parent, View view, int position, long id)
	{
		Intent intent = new Intent(this, ContactDetailsActivity.class);
		intent.putExtra(ContactDetailsActivity.CONTACT_ID, position);
		startActivity(intent);		
	}

}
