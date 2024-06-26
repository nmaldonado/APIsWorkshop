public with sharing class ReceiveComponentsController {


    @AuraEnabled (cacheable=true)
    public static Map<String,SObject> getObjects() {
        Map<String,SObject> concreteObjecMap = new Map<String,SObject>();
        List<SObject> sObjectList = new List<SObject>();
        try {
            sObjectList = ConnectionController.getObjects(); 

            for (SObject sObjectItem : sObjectList) {
                Schema.SObjectType sObjectType = sObjectItem.getSObjectType() ;
                concreteObjecMap.put(sObjectType.getDescribe().getName() + ': ' + sObjectItem.Id, sObjectItem);
            }
            
            System.debug('concreteObjecMap ' + JSON.serialize(concreteObjecMap));
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return concreteObjecMap;
    }
}