package com.jencor1.mortgage.common;

import java.util.regex.Pattern;

public final class JMContactsData
{
	public static final String [] OFFICE_LIST = new String []
	{
		"Edmonton, Alberta"
		, "Red Deer, Alberta"
		, "Stettler, Alberta"
		, "Grande Prairie, Alberta"
		, "Fort McMurray, Alberta"
		, "Cold Lake, Alberta"
		, "Moose Jaw, Saskatchewan"
		, "Saskatoon, Saskatchewan"
	};
	
	public static final String HOME_URL = "http://www.jencormortgage.com";
	public static final String TWITTER_ADDRESS = "http://twitter.com/Jencormortgage";
	public static final String FACEBOOK_ADDRESS = "http://www.facebook.com/pages/Jencor-Mortgage-Corporation/147402971961593";
	public static final String LINKEDIN_ADDRESS = "http://www.linkedin.com/company/jencor-mortgage?trk=fc_badge"; 
	
	
	
	//public static final String BLOG_SOURCE_URL = "http://www.jencormortgage.com/blog/feed/";
	public static final String BLOG_SOURCE_URL = "http://www.jencormortgage.com/feed/";
	public static final String BLOG_FILE_NAME = "blog.xml";
	
	public static final String CALLBACK_URL = "http://jencormortgage.com/blog/sendemail.php";
		
	public static final String RATES_SOURCE_URL = "http://ws.itoolpro.com/itoolpro/ws-lenderrates.asmx/GetLenderRates?agentID=938";
	public static final String RATES_FILE_NAME = "GetLenderRates.xml";
	
	public static final String QUICK_APP_EMAIL = "info@jencormortgage.com";
	
	public static final String PREFERRED_PARTNERS = "http://www.jencormortgage.com/about-jencor-mortgage-corporation/preferred-partners/"; 
	//public static final String PREFERRED_PARTNERS = "http://www.jencormortgage.com/jencor-ppp.html";
	
	public static final class OfficeData
	{
		public final String addrLine1;
		//public final String addrLine2;
		public final String workPhone;
		public final String mobilePhone;
		public final double latitude;
		public final double longitude;
		public final String url;
		public final String email;
		
		public OfficeData(final String addrLine1
				//, final String addrLine2
				, final String workPhone
				, final String mobilePhone
				, final double latitude
				, final double longitude
				, final String url
				, final String email)
		{
			this.addrLine1 = addrLine1;
			//this.addrLine2 = addrLine2;
			this.workPhone = workPhone;
			this.mobilePhone = mobilePhone;
			this.latitude = latitude;
			this.longitude = longitude;
			this.url = url;
			this.email = email;
		}
	}

	public static final OfficeData [] OFFICE_DATA = new OfficeData []
	{
		new OfficeData("Edmonton, Alberta #213, 11086 – 156 Street, Edmonton, AB, T5P 4M8"
				, "1-800-472-9791", "(780) 486-6639", 0,0
				, "www.mortgagecentreedmonton.com", "sky@mortgagecentreedmonton.com")
		, new OfficeData("Red Deer, Alberta 2 – 5511 Gaetz Avenue, Red Deer, AB, T4N 4B8"
				, "1-800-472-9791", "(403) 346-5410", 0,0 
				, "www.mortgagecentreedmonton.com", "sky@mortgagecentreedmonton.com")
		, new OfficeData("Stettler, Alberta 5019 – 51 Avenue, Stettler, AB, T0G 2L2"
				, "1-800-472-9791", "(403) 742-3215", 0,0
				, "www.mortgagecentreedmonton.com", "sky@mortgagecentreedmonton.com")
		, new OfficeData("Grande Prairie, Alberta #206, 10134 – 97 Avenue, Bldg. 103 Grande Central Station, Grande Prairie, AB, T6V 7X6"
				, "1-800-472-9791", "(780) 532-4065", 0,0
				, "", "sky@mortgagecentreedmonton.com")
		, new OfficeData("Fort McMurray, Alberta Suite # 108, 425 Gregoire Drive (off.), Fort McMurray, AB, T9H 4Y7"
				, "1-800-472-9791", "(780) 791-2232", 0,0
				, "", "sky@mortgagecentreedmonton.com")
		, new OfficeData("Cold Lake, Alberta #120, 4910 – 50 Ave (PO BOX 300), Cold Lake, AB, T9M 1P1"
				, "1-800-472-9791", "(780) 594-1403", 0,0
				, "www.mortgagecentreedmonton.com", "sky@mortgagecentreedmonton.com")
		, new OfficeData("Moose Jaw, Saskatchewan 19 Athabasca Street W, Moose Jaw, SK, S6H 2B6"
				, "1-800-472-9791", "1-800-472-9791", 0,0
				, "", "sky@mortgagecentreedmonton.com")
		, new OfficeData("Saskatoon, Saskatchewan # 6, 510 - 45 Street West, Saskatoon, SK, S7L 6H2"
				, "1-800-472-9791", "(306) 374-6637", 0,0
				, "", "sky@mortgagecentreedmonton.com")

	};
	
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

