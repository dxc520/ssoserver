package com.dataman.cas.web.flow.principal;


/**
 * 卡的凭证
 * 
 * @author xyyue
 * @since 1.6
 * @version 1.6
 */
public class CardCredentials extends CACredentials {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5051994870186184236L;

	private String cardIndentityCode;

	/**
	 * @return the cardIndentityCode
	 */
	public String getCardIndentityCode() {
		return cardIndentityCode;
	}

	/**
	 * @param cardIndentityCode
	 *            the cardIndentityCode to set
	 */
	public void setCardIndentityCode(String cardIndentityCode) {
		this.cardIndentityCode = cardIndentityCode;
	}
}
