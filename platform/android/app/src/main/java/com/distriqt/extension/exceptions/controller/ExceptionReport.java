/**
 *        __       __               __
 *   ____/ /_ ____/ /______ _ ___  / /_
 *  / __  / / ___/ __/ ___/ / __ `/ __/
 * / /_/ / (__  ) / / /  / / /_/ / /
 * \__,_/_/____/_/ /_/  /_/\__, /_/
 *                           / /
 *                           \/
 * http://distriqt.com
 *
 * @author 		Michael Archbold
 * @created		Sep 2, 2016
 * @copyright	http://distriqt.com/copyright/license.txt
 *
 */
package com.distriqt.extension.exceptions.controller;

import java.io.Serializable;

public class ExceptionReport implements Serializable
{

	public long timestamp = -1;
	public String name = "";
	public String reason = "";
	public String report = "";


	public ExceptionReport()
	{

	}


}
