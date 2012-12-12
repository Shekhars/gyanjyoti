/**
 * @description this class is 
 * @classname SIGACCESS2011MainClass.java
 * @date Apr 30, 2011
 * @author ntandon
 */
package score;

import java.util.ArrayList;

import util.CLIHelper;
import util.FileUtil;
import eval.ConfusionMatrix;
import eval.ConfusionMatrix.LabelsAll;

/**
 * AFTER matlab provides the feature file for the videos, scores the videos and
 * evaluates.
 */
public class Runner {

	public enum Method {
		local, global, lg
		// , localPlusGlobal
	}

	double lowerRange = 0.0;
	double upperRange = 1.0;
	double stepSize = 0.01;

	public static void main(String[] args) {
		Runner runner = new Runner();
		runner.run(args);
	}

	public Context scoringContext;

	public void run(String[] args) {
		try {
			scoringContext = ScoreMethod.init(args);
		} catch (Exception e) {
			e.printStackTrace();
		}

		String inputPath = CLIHelper.getArg(args, 1,
				"./results-analysis/analysis-v0-2011/");
		String resultPath = CLIHelper.getArg(args, 2,
				"./results-analysis/analysis-v0-2011/grid-results-new.txt");
		computeScoreAndEvaluate(inputPath, resultPath);
		/*
		 * String dataToPlot = evaluatedObj.computePlotData(lowerRange,
		 * upperRange, stepSize); FileUtil.writeFile(resultPath, dataToPlot,
		 * true);
		 */
	}

	/**
	 * Parses the output by matlab files and computes accessibility score of the video.
	 */
	private ConfusionMatrix computeScoreAndEvaluate(String inputPath,
			String resultPath) {
		Method[] allMethods = Method.values();
		String[] labels = { "positive", "negative" };
		for (int i = 0; i < allMethods.length; i++) {
			ConfusionMatrix eval = new ConfusionMatrix();
			String currentMethod = allMethods[i].name();
			for (int k = 0; k < labels.length; k++) {
				String label = labels[k];
				LabelsAll labelToPass = LabelsAll.negative;
				if (label.equalsIgnoreCase("positive")) {
					labelToPass = LabelsAll.positive;
				}
				ArrayList<String> lines = FileUtil.readAsList(inputPath
						+ currentMethod + "/" + label + ".txt");
				if (lines == null || lines.size() < 1) {
					continue;
				}
				/*
				 * [ 1 / 18 ] File : 38-Meter High Dive Goes Wrong.avi score :
				 * 0.593986 color_score : 0.912051 spatio_score : 0.869907
				 */
				int SPATIO_INDEX = 4;
				int COLOR_INDEX = 3;
				int TOTAL_SCORE_INDEX = 2;

				for (String line : lines) {
					String scoreIndicator = "score : ";

					if (!line.contains(scoreIndicator)) {
						continue;
					}
					String[] tokens = line.split("\t");
					Scorer scores = new Scorer();
					int startIndex = tokens[TOTAL_SCORE_INDEX]
							.indexOf(scoreIndicator) + scoreIndicator.length();
					scores.setTotalScore(Double
							.parseDouble(tokens[TOTAL_SCORE_INDEX]
									.substring(startIndex + 1)));
					startIndex = tokens[COLOR_INDEX].indexOf(scoreIndicator)
							+ scoreIndicator.length();
					;
					scores.setColorScore(Double.parseDouble(tokens[COLOR_INDEX]
							.substring(startIndex + 1)));
					startIndex = tokens[SPATIO_INDEX].indexOf(scoreIndicator)
							+ scoreIndicator.length();
					;
					scores.setSpatioScore(Double
							.parseDouble(tokens[SPATIO_INDEX]
									.substring(startIndex + 1)));
					eval.evaluateGrid(scores.getScoreToPass(scoringContext),
							labelToPass, lowerRange, upperRange, stepSize);
				}
			}
			/*
			 * plot data for one method.
			 */
			String dataToPlot = eval.computePlotData(lowerRange, upperRange,
					stepSize);
			String dataToWrite = "\n\nmethod: " + currentMethod + " [ "
					+ ScoreMethod.strategyInConfig + "]\n" + dataToPlot;
			FileUtil.writeFile(resultPath, dataToWrite, true);
		}

		return null;
	}
}
