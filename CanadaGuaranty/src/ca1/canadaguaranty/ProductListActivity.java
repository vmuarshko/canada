package ca1.canadaguaranty;

import java.io.File;
import java.io.FileInputStream;

import ca1.canadaguaranty.common.CGContactsData;
import ca1.canadaguaranty.common.CommonUtil;
import ca1.canadaguaranty.xml.ProductsXMLHandler;
import ca1.canadaguaranty.xml.XMLDataReader;
import ca1.canadaguaranty.R;

import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.BaseAdapter;
import android.widget.ListView;
import android.widget.TextView;

public class ProductListActivity extends BaseActivity implements OnItemClickListener
{
    private ProductsXMLHandler handler = new ProductsXMLHandler();
	
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
        File dataFile = new File(dataFolder, CGContactsData.PRODUCTS_FILE_NAME);
        if (!dataFile.exists()) 
        {  
        	showErrorMessage(getString(R.string.error_products_file_not_found));
        	return;
        }
        
        try
        {
        	XMLDataReader.readFromXML(new FileInputStream(dataFile), handler); 
        }
        catch (Exception ex)
        {
        	showErrorMessage(ex.getLocalizedMessage());
        	return;
        }
        
        if (getListView() != null && handler.products.size() > 0)
        {
        	ProductsArrayAdapter adapter = new ProductsArrayAdapter();
        	getListView().setAdapter(adapter);
        	getListView().setOnItemClickListener(this);
        }
    }

	@Override
	public void onItemClick(AdapterView<?> parent, View view, int position, long id)
	{
		Intent intent = new Intent(this, ProductDetailsActivity.class);
		intent.putExtra(ProductDetailsActivity.PRODUCT_INDEX, position);
		startActivity(intent);		
	}
	
	public class ProductsArrayAdapter extends BaseAdapter
	{
		@Override
		public int getCount()
		{
			return handler.products.size();
		}

		@Override
		public Object getItem(int pos)
		{
			return handler.products.get(pos);
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
				view = LayoutInflater.from(ProductListActivity.this).inflate(android.R.layout.simple_list_item_1, null);
			}
			
			TextView text1 = (TextView) view.findViewById(android.R.id.text1);
			if (text1 != null)
				text1.setText(handler.products.get(position).title);
			
			return view;
		}		
	}

}
