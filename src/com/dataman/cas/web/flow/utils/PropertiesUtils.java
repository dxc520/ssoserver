package com.dataman.cas.web.flow.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.configuration.AbstractConfiguration;
import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.commons.configuration.SystemConfiguration;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 读取配置文件
 * 
 * @author xyyue
 * @version 1.0
 * @since 1.6
 */
public class PropertiesUtils {
	private static Logger logger = LoggerFactory
			.getLogger(PropertiesUtils.class);
	private static Properties license = new Properties();
	private static boolean inited = false;
	private static boolean lcsInited = false;

	static CompositeConfiguration config = loadingProperties();

	private static synchronized CompositeConfiguration loadingProperties() {
		CompositeConfiguration config = new CompositeConfiguration();
		config.addConfiguration(new PropertiesUtils().new EnvironmentConfiguration());
		config.addConfiguration(new SystemConfiguration());
		try {
			PropertiesConfiguration props = new PropertiesConfiguration();
			props.setFileName("cas.properties");
			props.setDelimiterParsingDisabled(true);
			props.load();
			config.addConfiguration(props);

			inited = true;
		} catch (ConfigurationException e) {
			logger.error(e.getMessage());
		}
		return config;
	}

	/**
	 * 加载cas.properties配置文件
	 */
	synchronized public static void loadingLicenseProperties() {
		InputStream is = PropertiesUtils.class.getClassLoader()
				.getResourceAsStream("license.properties");
		if (is != null) {
			try {
				license.load(is);
				lcsInited = true;
			} catch (IOException e) {
				logger.error("Loading properties file ERROR!");
			} finally {
				try {
					is.close();
				} catch (Exception e) {
					logger.error("Closing properties file inputStream ERROR!");
				}
			}
		}
	}

	/**
	 * 解析properties中key的值，取不到则使用默认值。
	 * 
	 * @param key
	 *            关键字
	 * @param defaultValue
	 *            默认值
	 * @return 值
	 */
	public static String getValue(String key, String... defaultValue) {
		if (!inited) {
			loadingProperties();
		}
		String value = config.getString(key);
		if (defaultValue != null && value == null) {
			value = config.getString(key, defaultValue[0]);
		}
		return value;
	}

	/**
	 * 解析license.properties中key的值，取不到则使用默认值。
	 * 
	 * @param key
	 *            关键字
	 * @param defaultValue
	 *            默认值
	 * @return 值
	 */
	public static String getLicenseConfig(String key, String... defaultValue) {
		if (!lcsInited) {
			loadingLicenseProperties();
		}
		String defValue = null;
		Object value = license.get(key);
		if (defaultValue != null && value == null) {
			defValue = defaultValue[0];
		}
		return value != null ? (String) value : defValue;
	}

	class EnvironmentConfiguration extends AbstractConfiguration {
		private Map<String, String> environment;

		public EnvironmentConfiguration() {
			environment = System.getenv();
		}

		public boolean isEmpty() {
			return environment.isEmpty();
		}

		public boolean containsKey(String key) {
			if (StringUtils.isEmpty(key)) {
				return false;
			}
			return environment.containsKey(key)
					|| environment.containsKey(key.toUpperCase());
		}

		public Object getProperty(String key) {
			if (StringUtils.isEmpty(key))
				return null;
			String value = environment.get(key);
			return StringUtils.isNotEmpty(value) ? value : environment.get(key
					.toUpperCase());
		}

		@SuppressWarnings("rawtypes")
		public Iterator getKeys() {
			return environment.keySet().iterator();
		}

		@Override
		protected void addPropertyDirect(String key, Object value) {
			throw new UnsupportedOperationException(
					"Configuration is read-only!");
		}
	}
}