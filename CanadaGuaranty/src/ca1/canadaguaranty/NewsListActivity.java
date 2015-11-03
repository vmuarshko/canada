package ca1.canadaguaranty;

import java.io.File;
import java.io.FileInputStream;

import ca1.canadaguaranty.common.CGContactsData;
import ca1.canadaguaranty.common.CommonUtil;
import ca1.canadaguaranty.xml.NewsXMLHandler;
import ca1.canadaguaranty.xml.XMLDataReader;
import ca1.canadaguaranty.R;

import android.content.Intent;
import android.os.Bundle;
import android.text.Html;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.BaseAdapter;
import android.widget.ListView;
import android.widget.TextView;

public class NewsListActivity extends BaseActivity implements OnItemClickListener
{
    private NewsXMLHandler handler = new NewsXMLHandler();
	
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
        setContentView(R.layout.news_list);
     
        initDefaultControls();
        
        File dataFolder = CommonUtil.getFilesFolder(this, null);
        File dataFile = new File(dataFolder, CGContactsData.NEWS_FILE_NAME);
        if (!dataFile.exists()) 
        {  
        	showErrorMessage(getString(R.string.error_news_file_not_found));
        	return;
        }
        
        try
        {
        	XMLDataReader.readFromXML(new FileInputStream(dataFile), handler); 
        }
        catch (Exception ex)
        {
        	showErrorMessage(ex.getLocalizedMessage());
        }
        
        if (getListView() != null && handler.blogEntries.size() > 0)
        {
        	NewsArrayAdapter adapter = new NewsArrayAdapter();
        	getListView().setAdapter(adapter);
        	getListView().setOnItemClickListener(this);
        }
    }

	@Override
	public void onItemClick(AdapterView<?> parent, View view, int position, long id)
	{
		Intent intent = new Intent(this, NewsDetailsActivity.class);
		intent.putExtra(NewsDetailsActivity.TITLE, handler.blogEntries.get(position).title);
		intent.putExtra(NewsDetailsActivity.CONTENT, handler.blogEntries.get(position).content);
		intent.putExtra(NewsDetailsActivity.POSTED, String.format(getString(R.string.msg_posted_on), 
				handler.blogEntries.get(position).pubDate));
		startActivity(intent);		
	}
	
	public class NewsArrayAdapter extends BaseAdapter
	{
		@Override
		public int getCount()
		{
			return handler.blogEntries.size();
		}

		@Override
		public Object getItem(int pos)
		{
			return handler.blogEntries.get(pos);
		}

		@Override
		public long getItemId(int position)
		{
			return position;
		}

		@Override
		public View getView(int position, View view, ViewGroup parent)
		{
			if (view == null)
			{
				view = LayoutInflater.from(NewsListActivity.this).inflate(R.layout.blog_list_item, null);
			}
			
			TextView text1 = (TextView) view.findViewById(R.id.text1);
			if (text1 != null)
				text1.setText(handler.blogEntries.get(position).title);
			TextView text2 = (TextView) view.findViewById(R.id.text2);
			if (text2 != null)
			{
				String description = handler.blogEntries.get(position).desctiption;
				if (!TextUtils.isEmpty(description))
					text2.setText(Html.fromHtml(description));
			}
			
			return view;
		}		
	}

}
