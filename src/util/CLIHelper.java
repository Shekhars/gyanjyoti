package util;

/**
 * Parses Command line arguments.
 */
public class CLIHelper {
	public static String getArg(String[] args, int index, String defaultVal) {
		String val = "";
		if (args != null && args.length > index && args[index] != null
				&& args[index].trim().length() > 0)
			val = args[index];
		else
			val = defaultVal;
		return val;
	}
}