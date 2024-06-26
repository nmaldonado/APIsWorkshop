public with sharing class ConnectionController {


    public static List<SObject> getObjects() {
        List<SObject> sObjectList = new List<SObject>();

        try {
            sObjectList = [SELECT Id, name, type, rating FROM ACCOUNT WITH SECURITY_ENFORCED ORDER BY NAME LIMIT 9 ];
        } catch (Exception e) {
            System.debug(e.getMessage());
        }
        return sObjectList;  
    }
}