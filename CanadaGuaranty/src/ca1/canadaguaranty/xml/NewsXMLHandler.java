package ca1.canadaguaranty.xml;

import java.util.ArrayList;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;

import android.text.TextUtils;
import android.util.Log;

public class NewsXMLHandler extends XMLBaseHandler
{
	public class BlogEntry
	{
		public String title;
		public String pubDate;
		public String desctiption;
		public String content;		
	}
	
	public ArrayList<NewsXMLHandler.BlogEntry> blogEntries = new ArrayList<NewsXMLHandler.BlogEntry>();
	
	@Override
	public void startDocument() throws SAXException 
	{
		super.startDocument();
	}	
	
	@Override
	public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException
	{
		super.startElement(uri, localName, qName, attributes);
		
		try
		{
			if (localName.equals(NewsXMLTags.itemRoot))
			{
				blogEntries.add(new BlogEntry());
			}
		}
		catch (Exception ex)
		{
			Log.e("NewsXMLHandler", "XMLError", ex);
			throw new SAXException(ex);
		}
	}

	@Override
	public void characters(char ch[], int start, int length) throws SAXException 
	{
		super.characters(ch, start, length);
		
		try
		{			
			if (!enclosingTags.isEmpty() && blogEntries.size() > 0)
			{
				if (NewsXMLTags.itemTitle.equals(enclosingTags.peek()))
				{
					String title = new String(ch, start, length);
					if (TextUtils.isEmpty(blogEntries.get(blogEntries.size() - 1).title))
						blogEntries.get(blogEntries.size() - 1).title = title;
					else 
						blogEntries.get(blogEntries.size() - 1).title += title;
				}
				else if (NewsXMLTags.itemPubDate.equals(enclosingTags.peek()))
				{
					String s = new String(ch, start, length);
					blogEntries.get(blogEntries.size() - 1).pubDate = s;					
				} 
				else if (NewsXMLTags.itemDescription.equals(enclosingTags.peek()))
				{
					String desctiption = new String(ch, start, length).trim();
					if (!TextUtils.isEmpty(desctiption))
					{
						if (TextUtils.isEmpty(blogEntries.get(blogEntries.size() - 1).desctiption))
							blogEntries.get(blogEntries.size() - 1).desctiption = desctiption;
						else
							blogEntries.get(blogEntries.size() - 1).desctiption += desctiption;
					}
				} 
				else if (NewsXMLTags.itemContent.equals(enclosingTags.peek()))
				{
					String content = new String(ch, start, length).trim();
					if (!TextUtils.isEmpty(content))
					{
						if (TextUtils.isEmpty(blogEntries.get(blogEntries.size() - 1).content))
							blogEntries.get(blogEntries.size() - 1).content = content;
						else
							blogEntries.get(blogEntries.size() - 1).content += content;
					}
				} 
			}
		}
		catch (Exception ex)
		{
			Log.e("NewsXMLHandler", "XMLError", ex);
			throw new SAXException(ex);
		}
 
    }	

}

