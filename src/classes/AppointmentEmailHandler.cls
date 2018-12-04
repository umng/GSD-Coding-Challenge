global class AppointmentEmailHandler implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        
        
        String emailBody = email.plainTextBody;
        String emailSubject = email.Subject;
        Event evt = [SELECT Id 
                     FROM Event 
                     WHERE Id=:emailSubject
                     LIMIT 1];
        
        if(evt != null) {
            if(emailBody.startsWith('ACCEPTED')) {
                evt.Confirmed_by_Contact__c = true;
            }
            update evt;
        }
        
        
        return result;
    }
}