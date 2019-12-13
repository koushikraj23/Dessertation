package com.av.model;

import java.text.DecimalFormat;

import javax.persistence.Column;

public class PredictData {
	
	private int id;
	private String p_values;
	private String p_values_2;
	private String p_values_3;
	private String p_values_4;
	private String p_values_5;
	private String p_values_6;
	private String p_dates;
	private int sql_id;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public String getP_values() {
		return p_values;
	}
	public void setP_values(String p_values) {
		this.p_values = p_values;
	}
	
	public String getP_values_2() {
		return p_values_2;
	}
	public void setP_values_2(String p_values_2) {
		this.p_values_2 = p_values_2;
	}
	public String getP_values_3() {
		return p_values_3;
	}
	public void setP_values_3(String p_values_3) {
		this.p_values_3 = p_values_3;
	}
	public String getP_values_4() {
		return p_values_4;
	}
	public void setP_values_4(String p_values_4) {
		this.p_values_4 = p_values_4;
	}
	public String getP_values_5() {
		return p_values_5;
	}
	public void setP_values_5(String p_values_5) {
		this.p_values_5 = p_values_5;
	}
	public String getP_values_6() {
		return p_values_6;
	}
	public void setP_values_6(String p_values_6) {
		this.p_values_6 = p_values_6;
	}
	public String getP_dates() {
		return p_dates;
	}
	public void setP_dates(String p_dates) {
		this.p_dates = p_dates;
	}
	public int getSql_id() {
		return sql_id;
	}
	public void setSql_id(int sql_id) {
		this.sql_id = sql_id;
	}

}
