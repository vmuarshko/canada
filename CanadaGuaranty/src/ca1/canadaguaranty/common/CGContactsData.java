package ca1.canadaguaranty.common;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Pattern;

public final class CGContactsData
{
	public static final String HOME_URL = "http://www.canadaguaranty.ca";
	/*public static final String TWITTER_ADDRESS = "http://twitter.com/Jencormortgage";
	public static final String FACEBOOK_ADDRESS = "http://www.facebook.com/pages/Jencor-Mortgage-Corporation/147402971961593";
	public static final String LINKEDIN_ADDRESS = "http://www.linkedin.com/company/jencor-mortgage?trk=fc_badge";*/ 

	public static final String NEWS_FILE_NAME = "news.xml";
	public static final String NATIONAL_SALES_TEAM_FILE_NAME = "national-sales-team.xml";
	public static final String PRODUCTS_FILE_NAME = "insurance-products.xml";
	
	public static class Resources
	{
		public final Locale locale;
		public final String NEWS_SOURCE_URL;
		public final String NATIONAL_SALES_TEAM_URL;
		public final String PRODUCTS_URL;
		
		public Resources(final Locale locale
						, final String NEWS_SOURCE_URL
						, final String NATIONAL_SALES_TEAM_URL
						, final String PRODUCTS_URL)
		{
			this.locale = locale;
			this.NEWS_SOURCE_URL = NEWS_SOURCE_URL;
			this.NATIONAL_SALES_TEAM_URL = NATIONAL_SALES_TEAM_URL;
			this.PRODUCTS_URL = PRODUCTS_URL;
		}
	}
	
	public static final Map<Locale, Resources> resourceMap = new HashMap<Locale, Resources>();
	
	static
	{
		resourceMap.put(Locale.CANADA, new Resources(Locale.CANADA
			, "http://www.canadaguaranty.ca/feed?cat=1"
			, "http://www.canadaguaranty.ca/contact-us/national-sales-team/?xml=feed2"
			, "http://www.canadaguaranty.ca/insurance-products/?xml=feed"
			)
		);
		resourceMap.put(Locale.CANADA_FRENCH, new Resources(Locale.CANADA_FRENCH
			, "http://www.canadaguaranty.ca/fr/feed?cat=1"
			, "http://www.canadaguaranty.ca/fr/contactez-nous/equipe-nationale-des-ventes?xml=feed2"
			, "http://www.canadaguaranty.ca/fr/produits-dassurance/?xml=feed"
			)
		);	
	}
		
	public static Resources getResources()
	{
		Locale l = Locale.getDefault();
		for (Locale locale: resourceMap.keySet())
		{
			if (l.getLanguage().equals(locale.getLanguage()))
				return resourceMap.get(locale); 
		}
		return resourceMap.get(Locale.CANADA); 
	}	

	public static Resources getResources(final Locale l)
	{
		if (resourceMap.containsKey(l))
			return resourceMap.get(l);
		else 
			return null;
	}	
	
	public static final Pattern EMAIL_ADDRESS_PATTERN = Pattern.compile(
	          "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}" +
	          "\\@" +
	          "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
	          "(" +
	          "\\." +
	          "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
	          ")+"
	      );	
}
