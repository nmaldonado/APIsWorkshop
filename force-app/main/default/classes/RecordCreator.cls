public with sharing class  RecordCreator {
    @AuraEnabled
    public static List<CustomSaveResult> createRecords(List<SObject> records, Boolean allOrNone) {
        List<Database.SaveResult> saveResults = Database.insert(records, allOrNone);
        List<CustomSaveResult> customResults = new List<CustomSaveResult>();
        
        for (Database.SaveResult saveResult : saveResults) {
            List<String> errors = new List<String>();
            if (!saveResult.isSuccess()) {
                for (Database.Error error : saveResult.getErrors()) {
                    errors.add(error.getMessage());
                }
            }
            customResults.add(new CustomSaveResult(saveResult.isSuccess(), saveResult.getId(), errors));
        }
        return customResults;
    }


    
    @AuraEnabled
    public static CustomSaveResult createRecord(SObject record) {
        List<SObject> recordList = new List<SObject>{ record };
        List<Database.SaveResult> saveResults = Database.insert(recordList);
        
        if (!saveResults.isEmpty()) {
            Database.SaveResult saveResult = saveResults[0];
            List<String> errors = new List<String>();
            if (!saveResult.isSuccess()) {
                for (Database.Error error : saveResult.getErrors()) {
                    errors.add(error.getMessage());
                }
            }
            return new CustomSaveResult(saveResult.isSuccess(), saveResult.getId(), errors);
        } else {
            return new CustomSaveResult(false, null, new List<String>{'No result returned'});
        }
    }

    public class CustomSaveResult {
        @AuraEnabled public Boolean success;
        @AuraEnabled public String id;
        @AuraEnabled public List<String> errors;
        
        public CustomSaveResult(Boolean success, String id, List<String> errors) {
            this.success = success;
            this.id = id;
            this.errors = errors;
        }
    }
}