package score;

import util.CLIHelper;

/**
 * incognizant of scoring strategy, this class is a scorer for videos, used for
 * sigaccess 2011 paper
 */
public class ScoreMethod {

	/**
	 * the scoring strategy Setting Name="tupleScoringFormula"
	 * Value="OnlyPatternCubedScoreBasedTupleScore" <br>
	 * 4 possibilities are as follows:<br>
	 * FreqBasedTupleScore <br>
	 * LogFreqTunedPatternScoreBasedTupleScore <br>
	 * OnlyPatternScoreBasedTupleScore <br>
	 * OnlyPatternCubedScoreBasedTupleScore
	 */
	static String strategyInConfig;
	@SuppressWarnings("rawtypes")
	static Class clazz;

	public static double score(String patterns, int relationID) {

		double tupleScore = 0;

		return tupleScore;
	}

	public static double score(Context context, Scorer scores) {
		double resultantTupleScore = context.executeStrategy(scores);
		return resultantTupleScore;
	}

	/**
	 * @description this method onlySpatioScore onlyColorScore avgColorSpatio
	 * @throws IllegalAccessException
	 * @throws InstantiationException
	 */
	public static Context init(String[] args) throws InstantiationException,
			IllegalAccessException {
		strategyInConfig = CLIHelper.getArg(args, 0, "avgColorSpatio");
		String className = onlyColorScore.class.getPackage().getName() + "."
				+ strategyInConfig.trim();

		try {
			clazz = Class.forName(className);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return new Context((Strategy) clazz.newInstance());

	}
}

/**
 * 
 * @description The classes that implement a concrete strategy should implement
 *              this
 */
interface Strategy {
	/**
	 * @description The context class uses this to call the concrete strategy
	 * @param scores
	 */
	double computeOneTupleScore(Scorer scores);
}

class onlyColorScore implements Strategy {

	@Override
	public double computeOneTupleScore(Scorer scores) {
		return scores.getColorScore();
	}

}

class onlySpatioScore implements Strategy {

	@Override
	public double computeOneTupleScore(Scorer scores) {
		return scores.getSpatioScore();
	}
}

class avgColorSpatio implements Strategy {

	@Override
	public double computeOneTupleScore(Scorer scores) {
		return (scores.getColorScore() + scores.getSpatioScore()) / 2;
	}

}

class onlyHistoScore implements Strategy {

	@Override
	public double computeOneTupleScore(Scorer scores) {
		return scores.getHistoScore();
	}
}

/**
 * Configured with a ConcreteStrategy object and maintains a reference to a
 * Strategy object
 */
class Context {

	private Strategy strategy;

	public Context(Strategy strategy) {
		this.strategy = strategy;
	}

	/**
	 * Dispenser of the method call to various functions.
	 * 
	 * @param scores
	 * 
	 * @param numerator
	 * @param denominator1
	 * @param denominator2
	 * @return
	 */
	public double executeStrategy(Scorer scores) {
		return strategy.computeOneTupleScore(scores);
	}
}
