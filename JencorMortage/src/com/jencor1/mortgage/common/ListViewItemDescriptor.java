package com.jencor1.mortgage.common;

public final class ListViewItemDescriptor
{
	public final int iconId;
	public final int textId;
	public final Class<?> activityClass;
	public final String url;
	
	public ListViewItemDescriptor(int iconId, int textId, final Class<?> activityClass, final String url)
	{
		this.iconId = iconId;
		this.textId = textId;
		this.activityClass = activityClass;
		this.url = url;
	}
}
