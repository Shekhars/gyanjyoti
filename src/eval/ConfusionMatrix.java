package eval;

import java.util.TreeMap;

/**
 * Evaluates precision, recall.
 */
public class ConfusionMatrix {

	/**
	 * possible labels of the tuple.
	 */
	public enum LabelsAll {
		positive, negative, unknown
	}

	public int totalCorrect;
	public int totalPositive;
	public int totalWrong;
	public int totalCorrectWrong;
	public double threshold;
	private int totalNegative;

	public int tp;
	public int tn;
	public int fn;
	public int fp;

	/**
	 * Feb 3, 2011 ModelEvaluator 6:50:49 PM
	 * 
	 * @author ntandon
	 */
	public ConfusionMatrix() {
		totalCorrect = 0;
		totalPositive = 0;
		totalWrong = 0;
		totalCorrectWrong = 0;
		totalNegative = 0;
	}

	public int getTotalPositive() {
		return totalPositive;
	}

	public int getTotalNegative() {
		return totalNegative;
	}

	public void setTotalPositive(int totalPositive) {
		this.totalPositive = totalPositive;
	}

	public double getThreshold() {
		return threshold;
	}

	public void setThreshold(double threshold) {
		this.threshold = threshold;
	}

	public void incrementPositive(int incrementCount) {
		totalPositive += incrementCount;
	}

	public void incrementTruePos() {
		tp++;
		totalCorrect++;
		totalCorrectWrong++;
	}

	public void incrementTrueNeg() {
		tn++;
		totalCorrect++;
		totalCorrectWrong++;
	}

	public void incrementFalsePos() {
		fp++;
		totalWrong++;
		totalCorrectWrong++;
	}

	public void incrementFalseNeg() {
		fn++;
		totalWrong++;
		totalCorrectWrong++;
	}

	/**
	 * @description this method = tp/ (tp + fp)
	 * @return
	 * @date Mar 31, 2011
	 * @author ntandon
	 */
	public double computePrecision() {
		double precision = (double) tp / ((double) tp + (double) fp);
		return precision;

	}

	/**
	 * @description this method = tp/ (tp + fn)
	 * @return
	 * @date Mar 31, 2011
	 * @author ntandon
	 */
	public double computeRecall() {
		double recall = (double) tp / ((double) tp + (double) fn);
		return recall;
	}

	/**
	 * @description BUGGY METHOD DONT USE this method = tp/ (tp + fn)
	 * @return
	 * @deprecated
	 * @date Mar 31, 2011
	 * @author ntandon
	 */
	public double computeRecall(int totalPositiveInTrainSet) {
		double recall = (double) totalPositive
				/ (double) totalPositiveInTrainSet;

		return recall;
	}

	public double computeFMeasure(int normOfFMeasure, double precision,
			double recall) {
		if (normOfFMeasure < 1) {
			// F-1 Measure by default.
			normOfFMeasure = 1;
		}

		double fmeasure = 0.0;
		fmeasure = (double) ((1 + (normOfFMeasure * normOfFMeasure))
				* precision * recall)
				/ (double) ((normOfFMeasure * normOfFMeasure * precision) + recall);
		return fmeasure;
	}

	public double computeFMeasure() {
		// F-1 Measure by default.
		int normOfFMeasure = 1;

		double fmeasure = 0.0;
		double precision = computePrecision();
		double recall = computeRecall();
		fmeasure = (double) ((1 + (normOfFMeasure * normOfFMeasure))
				* precision * recall)
				/ (double) ((normOfFMeasure * normOfFMeasure * precision) + recall);
		return fmeasure;
	}

	/**
	 * @description this method
	 * @param incrementCount
	 * @date Apr 29, 2011
	 * @author ntandon
	 */
	public void incrementNegative(int incrementCount) {

		totalNegative += incrementCount;
	}

	private TreeMap<Double, ConfusionMatrix> rangeThresholdsCorrectness;

	/**
	 * @description this method checks PR on a range of thresholds.
	 * @param classifierConfidence
	 *            the confidence value from the classifier for this sample.
	 * @param label
	 *            the actual label of this sample.
	 * @param lowerRange
	 *            the lowest value in the grid of confidence values, generally
	 *            0.0
	 * @param upperRange
	 *            the highest value in the grid of confidence values, generally
	 *            1.0
	 * @param stepSize
	 *            generally 0.01 , can also be 0.1
	 * @date Apr 30, 2011
	 * @author ntandon
	 */
	public void evaluateGrid(double classifierConfidence, LabelsAll label,
			double lowerRange, double upperRange, double stepSize) {
		/*
		 * initialize evaluator objects, only for the first time.
		 */
		if (rangeThresholdsCorrectness == null
				|| rangeThresholdsCorrectness.size() < 1) {
			rangeThresholdsCorrectness = new TreeMap<Double, ConfusionMatrix>();
			for (double currentThreshold = lowerRange; currentThreshold <= upperRange; currentThreshold += stepSize) {
				ConfusionMatrix obj = new ConfusionMatrix();
				obj.setThreshold(currentThreshold);
				rangeThresholdsCorrectness.put(currentThreshold, obj);
			}
		}

		for (double currentThreshold = lowerRange; currentThreshold <= upperRange; currentThreshold += stepSize) {
			if (classifierConfidence >= currentThreshold
					&& label.equals(LabelsAll.positive)) {
				rangeThresholdsCorrectness.get(currentThreshold)
						.incrementTruePos();
			} else if (classifierConfidence < currentThreshold
					&& label.equals(LabelsAll.negative)) {
				rangeThresholdsCorrectness.get(currentThreshold)
						.incrementTrueNeg();
			}

			else if (classifierConfidence < currentThreshold
					&& label.equals(LabelsAll.positive)) {
				rangeThresholdsCorrectness.get(currentThreshold)
						.incrementFalseNeg();
			}

			else if (classifierConfidence >= currentThreshold
					&& label.equals(LabelsAll.negative)) {
				rangeThresholdsCorrectness.get(currentThreshold)
						.incrementFalsePos();
			}

		}

	}

	/**
	 * @return the rangeThresholdsCorrectness
	 */
	public TreeMap<Double, ConfusionMatrix> getRangeThresholdsCorrectness() {
		return rangeThresholdsCorrectness;
	}

	/**
	 * @description this method gets the data to plot for the grid of Precision
	 *              recall with the threshold.
	 * 
	 * @date Apr 30, 2011
	 * @author ntandon
	 */
	public String computePlotData(double lowerRange, double upperRange,
			double stepSize) {
		String plotData = "";
		plotData += "Threshold" + "\tPrecision \t Recall\tFMeasure\n\n";
		for (double currentThreshold = lowerRange; currentThreshold <= upperRange; currentThreshold += stepSize) {
			ConfusionMatrix eval = rangeThresholdsCorrectness
					.get(currentThreshold);
			plotData += eval.getThreshold() + "\t" + eval.computePrecision()
					+ "\t" + eval.computeRecall() + "\t"
					+ eval.computeFMeasure() + "\n";
		}
		return plotData;
	}
}
