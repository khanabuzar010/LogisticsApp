public class NotificationEmail {
    public static void sendMail(List<Asset> assets){
       
        List<Messaging.SingleEmailMessage> mails =
              new List<Messaging.SingleEmailMessage>();
            for(Asset asset : assets){
                Asset newAsset = [Select Name,Owner.Name,Driver__r.Name,Account.Name,Status,Driver__r.Driver_Phone__c
                         From Asset Where Id = :asset.Id];
            
          Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
            
          List<String> sendTo = new List<String>();
          sendTo.add('abuzar00022@gmail.com');
          mail.setToAddresses(sendTo);
            
          mail.setReplyTo('theabuzar.khan@gmail.com');
          mail.setSenderDisplayName('The Corner Store');
            
          mail.setSubject('Order Status');
          String body = 'Dear ' + newAsset.Account.Name+',' +'<br/>'+
            '<br/>'+	
              'Current Status of your Product  '+'<b>'+ newAsset.Status +'</b>' +'<br/>'+
              '<br/>'+
              'Delivery Agent: '+ newAsset.Driver__r.Name+ '<br/>'+
              'Phone:  '+ newAsset.Driver__r.Driver_Phone__c+ '<br/>'+
              '<br/>'+
              'Thank you for visiting us and making your purchase!'+ '<br/>'+
              newAsset.Owner.Name
              ;
            
          mail.setHtmlBody(body);    
          
            
          mails.add(mail);
          Messaging.sendEmail(mails);
        }
        }
    }