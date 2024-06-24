public class Logger {

    // Enum to define log levels
    public enum LogLevel {
        DEBUG, INFO, WARN, ERROR
    }

    // Method to log a message with a specific log level
    public static void log(LogLevel level, String message) {
        // Log the message to the debug log
        System.debug('[' + level + '] ' + message);

        // Optionally, create a Log__c record to store the log in Salesforce
        insertLogRecord(level, message);
    }

    // Method to log a debug message
    public static void debug(String message) {
        log(LogLevel.DEBUG, message);
    }

    // Method to log an info message
    public static void info(String message) {
        log(LogLevel.INFO, message);
    }

    // Method to log a warning message
    public static void warn(String message) {
        log(LogLevel.WARN, message);
    }

    // Method to log an error message
    public static void error(String message) {
        log(LogLevel.ERROR, message);
    }

    // Method to insert a log record in Salesforce
    private static void insertLogRecord(LogLevel level, String message) {
        try {
            Log__c log = new Log__c();
            log.Log_Level__c = level.name();
            log.Message__c = message;
            log.Timestamp__c = System.now();
            insert log;
        } catch (Exception e) {
            // Handle any exceptions that occur while inserting the log record
            System.debug('[ERROR] Failed to insert log record: ' + e.getMessage());
        }
    }
}