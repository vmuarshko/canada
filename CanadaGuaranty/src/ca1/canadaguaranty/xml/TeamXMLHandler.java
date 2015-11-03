package ca1.canadaguaranty.xml;

import java.util.ArrayList;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;

import ca1.canadaguaranty.common.CommonUtil;

import android.text.TextUtils;
import android.util.Log;

public class TeamXMLHandler extends XMLBaseHandler
{
	public static final class Member
	{
		public String name;
		public String title;
		public String region;
		public String tel;
		public String toolFree;		
		public String toolFreeExt;		
		public String email;		
	}
	
	public static final class Team
	{
		public String name;
		public String region;
		public ArrayList<TeamXMLHandler.Member> members = new ArrayList<TeamXMLHandler.Member>();
		
		@Override
		public String toString() { return region; }
	}
	
	public ArrayList<TeamXMLHandler.Team> teams = new ArrayList<TeamXMLHandler.Team>();
	
	private String currentType;
	private Member currentMember = null;
	
	@Override
	public void startDocument() throws SAXException 
	{
		super.startDocument();
		teams.clear();
		currentType = null;
		currentMember = null;
	}	
	
	@Override
	public void endDocument() throws SAXException 
	{
		super.endDocument();		
		for (Team team: teams)
		{
			team.name = CommonUtil.capitalizeString(team.name);
		}
	}	
	
	@Override
	public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException
	{
		super.startElement(uri, localName, qName, attributes);
		
		try
		{
			if (localName.equals(TeamXMLTags.memberRoot))
			{
				if (!TextUtils.isEmpty(currentType = attributes.getValue(TeamXMLTags.attrMemberType)))
				{
					currentMember = new Member();
				}
			}
		}
		catch (Exception ex)
		{
			Log.e("NewsXMLHandler", "XMLError", ex);
			throw new SAXException(ex);
		}
	}

	@Override
	public void endElement(String uri, String localName, String qName) throws SAXException
	{
		try
		{
			if (localName.equals(TeamXMLTags.memberRoot))
			{
				if (!TextUtils.isEmpty(currentType) && currentMember != null)
				{
					Team team = null;
					for (Team t: teams)
					{
						if (currentType.equals(t.name))
						{
							team = t;
							break;
						}
					}
					
					if (team == null)
					{
						team = new Team();
						team.name = currentType;
						team.region = currentMember.region;
						teams.add(team);
					}
					
					team.members.add(currentMember);
				}
			}
		}
		catch (Exception ex)
		{
			Log.e("NewsXMLHandler", "XMLError", ex);
			throw new SAXException(ex);
		}
		
		
		super.endElement(uri, localName, qName);
	}		
	
	@Override
	public void characters(char ch[], int start, int length) throws SAXException 
	{
		super.characters(ch, start, length);
		
		try
		{			
			if (!enclosingTags.isEmpty() && currentMember != null)
			{
				String s = new String(ch, start, length);
				if (TeamXMLTags.memberName.equals(enclosingTags.peek()))
				{
					if (TextUtils.isEmpty(currentMember.name))
						currentMember.name = s;
					else 
						currentMember.name += s;
				}
				else if (TeamXMLTags.memberTitle.equals(enclosingTags.peek()))
				{
					if (TextUtils.isEmpty(currentMember.title))
						currentMember.title = s;
					else 
						currentMember.title += s;
				}
				else if (TeamXMLTags.memberRegion.equals(enclosingTags.peek()))
				{
					if (TextUtils.isEmpty(currentMember.region))
						currentMember.region = s;
					else 
						currentMember.region += s;
				}
				else if (TeamXMLTags.memberTel.equals(enclosingTags.peek()))
				{
					if (TextUtils.isEmpty(currentMember.tel))
						currentMember.tel = s;
					else 
						currentMember.tel += s;
				}
				else if (TeamXMLTags.memberToolFree.equals(enclosingTags.peek()))
				{
					if (TextUtils.isEmpty(currentMember.toolFree))
						currentMember.toolFree = s;
					else 
						currentMember.toolFree += s;
				}
				else if (TeamXMLTags.memberToolFree.equals(enclosingTags.peek()))
				{
					if (TextUtils.isEmpty(currentMember.toolFree))
						currentMember.toolFree = s;
					else 
						currentMember.toolFree += s;
				}
				else if (TeamXMLTags.memberToolFreeExt.equals(enclosingTags.peek()))
				{
					if (TextUtils.isEmpty(currentMember.toolFreeExt))
						currentMember.toolFreeExt = s;
					else 
						currentMember.toolFreeExt += s;
				}
				else if (TeamXMLTags.memberEmail.equals(enclosingTags.peek()))
				{
					if (TextUtils.isEmpty(currentMember.email))
						currentMember.email = s;
					else 
						currentMember.email += s;
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

