package com.skyfinancial1.canadamortgage.common;

import java.util.regex.Pattern;

public final class SFContactsData
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
		, "Prince George, BC"
	};
	
	public static final String HOME_URL = "http://www.mortgagecentreedmonton.com";
	public static final String SKY_BUDGET_URL = "http://www.skybudget.ca";
	public static final String TWITTER_ADDRESS = "https://twitter.com/skymortgage";
	public static final String FACEBOOK_ADDRESS = "https://www.facebook.com/pages/Sky-Financial-Corporation-The-Mortgage-Centre/121421887952201?sk=app_249347133607 ";
	
	//public static final String BLOG_SOURCE_URL = "http://www.mortgagecentreedmonton.com/blog/?feed=rss2";
	public static final String BLOG_SOURCE_URL = "http://www.mortgagecentreedmonton.com/feed/";
	
	public static final String BLOG_FILE_NAME = "blog.xml";
	
	public static final String RATES_SOURCE_URL = "http://ws.itoolpro.com/itoolpro/ws-lenderrates.asmx/GetLenderRates?agentID=1286";
	public static final String RATES_FILE_NAME = "GetLenderRates.xml";
	
	public static final String QUICK_APP_EMAIL = "bill@mortgagecentreedmonton.com";
	
	public static final class OfficeData
	{
		public final String addrLine1;
		//public final String addrLine2;
		public final String phone;
		public final double latitude;
		public final double longitude;
		public final String url;
		public final String email;
		
		public OfficeData(final String addrLine1
				//, final String addrLine2
				, final String phone
				, final double latitude
				, final double longitude
				, final String url
				, final String email)
		{
			this.addrLine1 = addrLine1;
			//this.addrLine2 = addrLine2;
			this.phone = phone;
			this.latitude = latitude;
			this.longitude = longitude;
			this.url = url;
			this.email = email;
		}
	}

	public static final OfficeData [] OFFICE_DATA = new OfficeData []
	{
		new OfficeData("Edmonton, Alberta #213,\n11086 – 156 Street,\nEdmonton, AB, T5P 4M8"
				, "1-800-472-9791, (780) 486-6639", 0,0
				, "www.mortgagecentreedmonton.com", "sky@mortgagecentreedmonton.com")
		, new OfficeData("Red Deer, Alberta 2 – 5511\nGaetz Avenue, Red Deer, AB\nT4N 4B8"
				, "1-800-472-9791, (403) 346-5410", 0,0 
				, "www.mortgagecentreedmonton.com", "sky@mortgagecentreedmonton.com")
		, new OfficeData("Stettler, Alberta 5019 – 51\nAvenue, Stettler, AB, T0G 2L2"
				, "1-800-472-9791, (403) 742-3215", 0,0
				, "www.mortgagecentreedmonton.com", "sky@mortgagecentreedmonton.com")
		, new OfficeData("Grande Prairie, Alberta #206,\n10134 – 97 Avenue, Bldg. 103\n Grande Central Station,\nGrande Prairie, AB, T6V 7X6"
				, "1-800-472-9791, (780) 532-4065", 0,0
				, "", "sky@mortgagecentreedmonton.com")
		, new OfficeData("Fort McMurray, Alberta Suite\n# 108, 425 Gregoire Drive\n(off.), Fort McMurray,AB,\nT9H 4Y7"
				, "1-800-472-9791, (780) 791-2232", 0,0
				, "", "sky@mortgagecentreedmonton.com")
		, new OfficeData("Cold Lake, Alberta #120,\n4910 – 50 Ave (PO BOX 300),\nCold Lake, AB, T9M 1P1"
				, "1-800-472-9791, (780) 594-1403", 0,0
				, "www.mortgagecentreedmonton.com", "sky@mortgagecentreedmonton.com")
		, new OfficeData("Moose Jaw, Saskatchewan\n19 Athabasca Street W,\nMoose Jaw, SK, S6H 2B6"
				, "1-800-472-9791, 1-800-472-9791", 0,0
				, "", "sky@mortgagecentreedmonton.com")
		, new OfficeData("Saskatoon, Saskatchewan #\n6, 510 - 45 Street West,\nSaskatoon\nSK, S7L 6H2"
				, "1-800-472-9791, (306) 374-6637", 0,0
				, "", "sky@mortgagecentreedmonton.com")
		, new OfficeData("Prince George, BC\n7628 St Mark Crescent\nPrince George, BC\nV2M 4B8"
				, "1-800-472-9791, (306) 374-6637", 0,0
				, "", "sky@mortgagecentreedmonton.com")

		
//		Prince George BC.
//		7628 St Mark Crescent
//		Prince George BC. V2M 4B8

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
