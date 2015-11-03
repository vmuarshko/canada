package com.jencor1.mortgage.common;

import com.jencor1.mortgage.R;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.AdapterView.OnItemClickListener;

public final class ActivityMenuAdapter extends BaseAdapter implements OnItemClickListener
{
	private Context context;
	private final int itemResourceId;
	private final ListViewItemDescriptor [] MENU_ITEMS;
	
	public ActivityMenuAdapter(Context context, final ListViewItemDescriptor [] MENU_ITEMS, ListView listView, int itemResourceId)
	{
		this.context = context;
		this.MENU_ITEMS = MENU_ITEMS;
		this.itemResourceId = itemResourceId;
		
		listView.setOnItemClickListener(this);
	}
	
	@Override
	public int getCount()
	{
		return MENU_ITEMS.length;
	}

	@Override
	public Object getItem(int position)
	{
		return MENU_ITEMS[position];
	}

	@Override
	public long getItemId(int position)
	{
		return position;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent)
	{
		View view = null;
		if (convertView == null)
		{
			view = LayoutInflater.from(context).inflate(itemResourceId, null);				
		}
		else view = convertView;
		
		ImageView icon = (ImageView) view.findViewById(R.id.imageViewIcon);
		if (icon != null)
			icon.setImageResource(MENU_ITEMS[position].iconId);
		
		TextView text1 = (TextView) view.findViewById(R.id.text1);
		if (text1 != null)
			text1.setText(context.getString(MENU_ITEMS[position].textId));
		
		return view;
	}
	

	@Override
	public void onItemClick(AdapterView<?> parent, View view, int position, long id)
	{
		if (MENU_ITEMS[position].activityClass != null)
		{
			Intent intent = new Intent(context, MENU_ITEMS[position].activityClass);
			context.startActivity(intent);								
		}
		else if (MENU_ITEMS[position].url != null)
		{
			try
			{
	    		String url = MENU_ITEMS[position].url;
	    		if (!url.startsWith("http://") && !url.startsWith("https://")) url = "http://" + url;
	    		
	    		Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
	    		context.startActivity(browserIntent);
			}
			catch (Exception ex)
			{
				Log.e("ActivityMenuAdapter", "onItemClick", ex);
			}			
		}
	}
}
