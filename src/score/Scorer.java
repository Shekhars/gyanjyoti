/**
 * @description this class is 
 * @classname SigaccessScore.java
 * @date Apr 30, 2011
 * @author ntandon
 */
package score;

/**
 * scores videos as in the sigaccess 2011 paper
 */
public class Scorer {
	private double colorScore;
	private double spatioScore;
	private double histoScore;
	private double totalScore;

	public double getColorScore() {
		return colorScore;
	}

	public void setColorScore(double colorScore) {
		this.colorScore = colorScore;
	}

	public double getSpatioScore() {
		return spatioScore;
	}

	public void setSpatioScore(double spatioScore) {
		this.spatioScore = spatioScore;
	}

	public double getHistoScore() {
		return histoScore;
	}

	public void setHistoScore(double histoScore) {
		this.histoScore = histoScore;
	}

	public double getTotalScore() {
		return totalScore;
	}

	public void setTotalScore(double totalScore) {
		this.totalScore = totalScore;
	}

	public double getScoreToPass(Context scoringContext) {
		return ScoreMethod.score(scoringContext, this);
	}

}
