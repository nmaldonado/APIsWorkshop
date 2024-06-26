public class DynamicRecordSelector {

    @AuraEnabled
    public static List<Map<String, Object>> getRecords(String sObjectType, List<String> fields, String whereClause, Integer lim) {
        // Construct the SOQL query
        String query = 'SELECT ' + String.join(fields, ', ') + ' FROM ' + sObjectType;
        
        if (whereClause != null && whereClause != '') {
            query += ' WHERE ' + whereClause;
        }
        
        if (lim != null) {
            query += ' LIMIT ' + lim;
        }

        // Perform the query and store the results
        List<SObject> results = Database.query(query);
        
        // Transform the results into a list of maps for easier handling in LWC
        List<Map<String, Object>> records = new List<Map<String, Object>>();
        for (SObject record : results) {
            Map<String, Object> recordMap = record.getPopulatedFieldsAsMap();
            records.add(recordMap);
        }

        return records;
    }
}