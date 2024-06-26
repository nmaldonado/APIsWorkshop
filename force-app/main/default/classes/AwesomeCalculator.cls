public class AwesomeCalculator {
    public static Double add(Double x, Double y) {
        calculatorServices.CalculatorImplPort calculator = new calculatorServices.CalculatorImplPort();
        return calculator.doAdd(x,y);
    }

    public static Double multiply(Double x , Double y) {
        calculatorServices.CalculatorImplPort calculator = new calculatorServices.CalculatorImplPort();
        return calculator.doMultiply(x, y);
        
    }
}